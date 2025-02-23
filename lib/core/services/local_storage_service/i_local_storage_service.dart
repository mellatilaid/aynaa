import 'dart:io';
import 'dart:typed_data';

import 'package:atm_app/core/helper/enums.dart';

abstract class ILocalStorageService {
  Future<File?> getCachedFile(String filePath);
  Future<String?> cacheFile(String filePath, Uint8List data);
  Future<void> deleteCachedFile(String filePath, Entities deletedItemType);
  Future<bool> isFileCached(String filePath);
}
