mixin Entity {
  String get entityID; // Abstract getter (required)
  String? get name;
  String? get url;
  String? get localFilePath;
  String? get oldUrl;
  String get versionName;
  String get updatedAt;
  bool get isDeleted;
  set localFilePath(String? path);
}
