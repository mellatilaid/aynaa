import 'package:atm_app/core/common/entitiy.dart';
import 'package:isar/isar.dart';

part 'aynaa_versions_entity.g.dart';

@Collection()
class AynaaVersionsEntity with Entity {
  Id id = Isar.autoIncrement;
  @override
  @Index(unique: true)
  final String entityID;
  @override
  final String versionName;
  @override
  bool isDeleted;
  @override
  String? localFilePath;
  String updatedAt;
  @override
  String url;
  AynaaVersionsEntity({
    required this.entityID,
    required this.versionName,
    required this.url,
    required this.updatedAt,
    this.isDeleted = false,
    this.localFilePath,
  });

  @override
  // TODO: implement name
  String get name => versionName;
}
