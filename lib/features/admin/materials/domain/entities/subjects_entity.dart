import 'package:atm_app/core/entities/entitiy.dart';
import 'package:hive/hive.dart';

part 'subjects_entity.g.dart';

@HiveType(typeId: 1)
class SubjectsEntity extends HiveObject with Entity {
  @override
  @HiveField(0)
  final String? id;
  @HiveField(1)
  final String subjectName;
  @HiveField(2)
  final String versionID;

  SubjectsEntity({
    this.id,
    required this.subjectName,
    required this.versionID,
  });

  @override
  // TODO: implement name
  String get name => subjectName;

  @override
  // TODO: implement localFilePath
  String? get localFilePath => throw UnimplementedError();

  @override
  // TODO: implement url
  String? get url => throw UnimplementedError();

  @override
  // TODO: implement versionName
  String get versionName => throw UnimplementedError();

  @override
  set localFilePath(String? path) {}
}
