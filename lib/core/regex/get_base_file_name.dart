String getBaseFileName(String fullFileName) {
  RegExp regex =
      RegExp(r'^[a-f0-9]{64}'); // Matches a 64-character hash at the start
  return fullFileName.replaceFirst(regex, '').trim();
}
