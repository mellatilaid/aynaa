mixin Entity {
  String? get id; // Abstract getter (required)
  String? get name;
  String? get url;
  String? get localFilePath;
  String get versionName;
  set localFilePath(String? path);
}
