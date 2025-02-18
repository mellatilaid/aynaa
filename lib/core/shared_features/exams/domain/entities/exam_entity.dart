import 'package:atm_app/core/entities/entitiy.dart';
import 'package:isar/isar.dart';

part 'exam_entity.g.dart';

@Collection()
class ExamEntity with Entity {
  Id id = Isar.autoIncrement;

  @override
  @Index(unique: true)
  final String entityID;
  final String title;
  final String versionID;
  @override
  final String versionName;
  @override
  final String? url;
  @override
  String? localFilePath;
  ExamEntity({
    required this.entityID,
    required this.title,
    required this.versionID,
    required this.versionName,
    required this.url,
    this.localFilePath,
  });

  @override
  // TODO: implement name
  String? get name => title;
}
