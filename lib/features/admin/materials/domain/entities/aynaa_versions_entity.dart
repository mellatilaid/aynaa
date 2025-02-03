import 'package:atm_app/core/entities/entitiy.dart';
import 'package:isar/isar.dart';

part 'aynaa_versions_entity.g.dart';

@Collection()
class AynaaVersionsEntity with Entity {
  Id id = Isar.autoIncrement;
  @override
  final String entityID;
  @override
  final String versionName;

  AynaaVersionsEntity({required this.entityID, required this.versionName});

  @override
  // TODO: implement name
  String get name => versionName;

  @override
  // TODO: implement localFilePath
  String get localFilePath => throw UnimplementedError();

  @override
  // TODO: implement url
  String get url => throw UnimplementedError();

  @override
  set localFilePath(String? path) {
    // TODO: implement localFilePath
  }
}
