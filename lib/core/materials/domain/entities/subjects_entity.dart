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
  @override
  bool isDeleted = false;

  final String versionID;
  @override
  final String url;
  @override
  late String? localFilePath;
  String updatedAt;
  SubjectsEntity({
    required this.entityID,
    required this.subjectName,
    required this.versionName,
    required this.url,
    required this.versionID,
    this.localFilePath,
    required this.updatedAt,
  });

  @override
  // TODO: implement name
  String get name => subjectName;
}
