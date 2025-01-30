import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:crypto/crypto.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

abstract class FileCacheManager {
  Future<File?> getCachedFile(String filePath);
  Future<String> cacheFile(String filePath, Uint8List data);
  Future<void> deleteCachedFile(String filePath);
  Future<bool> isFileCached(String filePath);
}

class FileSystemCacheManager implements FileCacheManager {
  static const String _cacheDirectoryName = 'supabase_cache';
  late Directory _cacheDirectory;

  FileSystemCacheManager() {
    _init();
  }

  Future<void> _init() async {
    final appDocDir = await getApplicationDocumentsDirectory();
    _cacheDirectory = Directory(p.join(appDocDir.path, _cacheDirectoryName));
    if (!await _cacheDirectory.exists()) {
      await _cacheDirectory.create(recursive: true);
    }
  }

  String _generateFilename(String filePath) {
    // Get the SHA-256 hash for uniqueness
    final hashedName = sha256.convert(utf8.encode(filePath)).toString();

    // Extract the file extension
    final extension = p.extension(filePath);

    final baseName = p.basename(filePath);
    log('$hashedName$baseName$extension');
    // Return the hash with the original file extension
    return "$hashedName$baseName$extension";
  }

  @override
  Future<File?> getCachedFile(String filePath) async {
    await _init();
    final file =
        File(p.join(_cacheDirectory.path, _generateFilename(filePath)));
    return await file.exists() ? file : null;
  }

  @override
  Future<String> cacheFile(String filePath, Uint8List data) async {
    await _init();
    final file =
        File(p.join(_cacheDirectory.path, _generateFilename(filePath)));
    final File cachedFile = await file.writeAsBytes(data);
    log('chacked file path is ${cachedFile.path}');
    return cachedFile.path;
  }

  @override
  Future<void> deleteCachedFile(String filePath) async {
    await _init();
    final file =
        File(p.join(_cacheDirectory.path, _generateFilename(filePath)));
    if (await file.exists()) {
      await file.delete();
    }
  }

  @override
  Future<bool> isFileCached(String filePath) async {
    await _init();
    final file =
        File(p.join(_cacheDirectory.path, _generateFilename(filePath)));
    return await file.exists();
  }
}
