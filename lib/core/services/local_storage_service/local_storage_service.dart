import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:atm_app/core/helper/enums.dart';
import 'package:atm_app/core/services/local_storage_service/i_local_storage_service.dart';
import 'package:crypto/crypto.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

class LocalStorageService implements ILocalStorageService {
  static const String _cacheDirectoryName = 'supabase_cache';
  late Directory _cacheDirectory;
  late Directory appDocDir;
  LocalStorageService() {
    _init();
  }

  Future<void> _init({String? filePath}) async {
    appDocDir = await getApplicationDocumentsDirectory();

    if (filePath != null) {
      List<String> parts = _splitFilePath(filePath);
      if (parts.length <= 2) {
        _cacheDirectory =
            Directory(p.join(appDocDir.path, _cacheDirectoryName, parts[0]));
      } else {
        _cacheDirectory = Directory(
            p.join(appDocDir.path, _cacheDirectoryName, parts[0], parts[1]));
      }
    } else {
      _cacheDirectory = Directory(p.join(appDocDir.path, _cacheDirectoryName));
    }
    if (!await _cacheDirectory.exists()) {
      await _cacheDirectory.create(recursive: true);
    }
  }

  Map<String, String?> _parseFilePath(String? filePath) {
    final List<String> segments = filePath?.split('/') ?? [];
    return {
      'version': segments.isNotEmpty ? segments[0] : null,
      'subject': segments.length > 1 ? segments[1] : null,
      'filename': segments.length > 2 ? segments[2] : 'image.png',
    };
  }

  String _generateFilename(String filePath) {
    final parts = _parseFilePath(filePath);
    // Always use "image.png" for subject images
    return parts['filename'] ?? 'image.png';
  }

  String _generateCacheKey(String filePath) {
    final uri = Uri.parse(filePath);
    // Remove query parameters and fragments
    final cleanPath = uri.path;
    // Get stable hash from clean path
    return sha256.convert(utf8.encode(cleanPath)).toString();
  }

  /* String _generateFilename(String filePath) {
    // Get the SHA-256 hash for uniqueness
    final baseName = p.basename(filePath);
    final hashedName = sha256.convert(utf8.encode(baseName)).toString();

    // Extract the file extension
    final extension = p.extension(filePath);

    // Return the hash with the original file extension
    return "$hashedName${DateTime.now().millisecondsSinceEpoch}$baseName";
  }*/

  @override
  Future<File?> getCachedFile(String filePath) async {
    await _init(filePath: filePath);

    final file =
        File(p.join(_cacheDirectory.path, _generateFilename(filePath)));
    return await file.exists() ? file : null;
  }

  @override
  Future<String?> cacheFile(String filePath, Uint8List data) async {
    await _init(filePath: filePath);
    final targetFile =
        File(p.join(_cacheDirectory.path, _generateFilename(filePath)));

    // Force overwrite existing image
    if (await targetFile.exists()) await targetFile.delete();

    return (await targetFile.writeAsBytes(data)).path;
    /*log(filePath);
    final cacheKey = _generateFilename(filePath);
    final file = File(p.join(_cacheDirectory.path, cacheKey));
    if (await file.exists()) {
      await file.delete();
      log('Deleted previous version: ${file.path}');
    }
    final File cachedFile = await file.writeAsBytes(data);

    return cachedFile.path;*/
  }

  @override
  Future<void> deleteCachedFile(
      String filePath, Entities deletedItemType) async {
    switch (deletedItemType) {
      case Entities.lessons:
        await _init(filePath: filePath);

        final file =
            File(p.join(_cacheDirectory.path, _generateFilename(filePath)));
        log(file.path);
        if (await file.exists()) {
          await file.delete();
        }
        break;
      case Entities.subjects:
        await _init(filePath: filePath);
        final parts = p.split(filePath);
        final dir = Directory(
            p.join(appDocDir.path, _cacheDirectoryName, parts[0], parts[1]));
        if (await dir.exists()) {
          await dir.delete(recursive: true);
        }
        break;
      case Entities.versions:
        await _init(filePath: filePath);
        final parts = p.split(filePath);
        final dir =
            Directory(p.join(appDocDir.path, _cacheDirectoryName, parts[0]));
        if (await dir.exists()) {
          await dir.delete(recursive: true);
        }
        break;
      case Entities.examSections:
      case Entities.exam:
      case Entities.questions:
    }
  }

  @override
  Future<bool> isFileCached(String filePath) async {
    await _init(filePath: filePath);
    final file =
        File(p.join(_cacheDirectory.path, _generateFilename(filePath)));

    return await file.exists();
  }

  _splitFilePath(String filePath) {
    final List<String> parts = filePath.split('/');
    return parts;
  }
}
