import 'package:atm_app/core/entities/entitiy.dart';
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
  String? localFilePath;
  @override
  String url;
  AynaaVersionsEntity(
      {required this.entityID,
      required this.versionName,
      required this.url,
      this.localFilePath});

  @override
  // TODO: implement name
  String get name => versionName;
}
