import 'package:atm_app/core/entities/entitiy.dart';
import 'package:hive/hive.dart';

part 'aynaa_versions_entity.g.dart';

@HiveType(typeId: 0)
class AynaaVersionsEntity extends HiveObject with Entity {
  @override
  @HiveField(0)
  final String id;
  @override
  @HiveField(1)
  final String versionName;

  AynaaVersionsEntity({required this.id, required this.versionName});

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
