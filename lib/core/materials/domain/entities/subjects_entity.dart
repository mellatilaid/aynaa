import 'package:atm_app/core/common/entitiy.dart';
import 'package:isar/isar.dart';

part 'subjects_entity.g.dart';

@Collection()
class SubjectsEntity with Entity {
  Id id = Isar.autoIncrement;
  @override
  @Index(unique: true)
  final String entityID;
  final String subjectName;
  @override
  final String versionName;
  bool isDeleted = false;

  final String versionID;
  @override
  final String url;
  @override
  late String? localFilePath;
  SubjectsEntity({
    required this.entityID,
    required this.subjectName,
    required this.versionName,
    required this.url,
    required this.versionID,
    this.localFilePath,
  });

  @override
  // TODO: implement name
  String get name => subjectName;
}
