import 'package:atm_app/core/entities/entitiy.dart';
import 'package:isar/isar.dart';

part 'subjects_entity.g.dart';

@Collection()
class SubjectsEntity with Entity {
  Id id = Isar.autoIncrement;
  @override
  @Index(unique: true)
  final String entityID;
  final String subjectName;
  final String versionID;
  final bool isDeleted = false;
  @override
  final String url;
  @override
  String? localFilePath;
  SubjectsEntity({
    required this.entityID,
    required this.subjectName,
    required this.versionID,
    required this.url,
    this.localFilePath,
  });

  @override
  // TODO: implement name
  String get name => subjectName;

  @override
  // TODO: implement versionName
  String get versionName => '';
}
