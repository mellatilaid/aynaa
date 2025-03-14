RegExp hashedFileNameRegEx = RegExp(r'^[a-f0-9]{64}');

RegExp storageNameRegEx =
    RegExp(r'^\d+\.\d+\.\d+(-(?![\p{Arabic}])[\p{L}0-9]+)?$');
String getBaseFileName(String fullFileName) {
  return fullFileName.replaceFirst(hashedFileNameRegEx, '').trim();
}
