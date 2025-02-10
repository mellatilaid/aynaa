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
  bool isDeleted = false;
  @override
  final String versionName;
  @override
  final String url;
  @override
  late String? localFilePath;
  SubjectsEntity({
    required this.entityID,
    required this.subjectName,
    required this.versionID,
    required this.url,
    required this.versionName,
    this.localFilePath,
  });

  @override
  // TODO: implement name
  String get name => subjectName;
}
