import 'package:hive/hive.dart';

part 'aynaa_versions_entity.g.dart';

@HiveType(typeId: 0)
class AynaaVersionsEntity extends HiveObject {
  @override
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String versionName;

  AynaaVersionsEntity({required this.id, required this.versionName});

  @override
  // TODO: implement name
  String get name => versionName;
}
