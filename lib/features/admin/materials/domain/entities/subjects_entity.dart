import 'package:atm_app/core/entities/entitiy.dart';
import 'package:isar/isar.dart';

part 'subjects_entity.g.dart';

@Collection()
class SubjectsEntity with Entity {
  Id id = Isar.autoIncrement;
  @override
  final String entityID;
  final String subjectName;
  final String versionID;

  SubjectsEntity({
    required this.entityID,
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
