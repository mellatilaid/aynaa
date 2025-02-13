import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:atm_app/core/helper/enums.dart';
import 'package:crypto/crypto.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

abstract class FileCacheManager {
  Future<File?> getCachedFile(String filePath);
  Future<String?> cacheFile(String filePath, Uint8List data);
  Future<void> deleteCachedFile(
      String filePath, DeletedItemType deletedItemType);
  Future<bool> isFileCached(String filePath);
}

class FileSystemCacheManager implements FileCacheManager {
  static const String _cacheDirectoryName = 'supabase_cache';
  late Directory _cacheDirectory;
  late Directory appDocDir;
  FileSystemCacheManager() {
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

  String _generateFilename(String filePath) {
    // Get the SHA-256 hash for uniqueness
    final baseName = p.basename(filePath);
    final hashedName = sha256.convert(utf8.encode(baseName)).toString();

    // Extract the file extension
    final extension = p.extension(filePath);

    // Return the hash with the original file extension
    return "$hashedName$baseName";
  }

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

    log(filePath);
    final file =
        File(p.join(_cacheDirectory.path, _generateFilename(filePath)));
    final File cachedFile = await file.writeAsBytes(data);

    return cachedFile.path;
  }

  @override
  Future<void> deleteCachedFile(
      String filePath, DeletedItemType deletedItemType) async {
    switch (deletedItemType) {
      case DeletedItemType.lesson:
        await _init(filePath: filePath);

        final file =
            File(p.join(_cacheDirectory.path, _generateFilename(filePath)));
        log(file.path);
        if (await file.exists()) {
          await file.delete();
        }
        break;
      case DeletedItemType.subject:
        await _init(filePath: filePath);
        final parts = p.split(filePath);
        final dir = Directory(
            p.join(appDocDir.path, _cacheDirectoryName, parts[0], parts[1]));
        if (await dir.exists()) {
          await dir.delete(recursive: true);
        }
        break;
      case DeletedItemType.version:
        await _init(filePath: filePath);
        final parts = p.split(filePath);
        final dir =
            Directory(p.join(appDocDir.path, _cacheDirectoryName, parts[0]));
        if (await dir.exists()) {
          await dir.delete(recursive: true);
        }
        break;
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
