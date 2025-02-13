mixin Entity {
  String get entityID; // Abstract getter (required)
  String? get name;
  String? get url;
  String? get localFilePath;
  String get versionName;
  set localFilePath(String? path);
}
