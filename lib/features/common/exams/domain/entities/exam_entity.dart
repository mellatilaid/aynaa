import 'package:atm_app/core/common/entitiy.dart';
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
  String? oldUrl;
  @override
  String? localFilePath;
  @override
  bool isDeleted;
  @override
  String updatedAt;
  ExamEntity({
    required this.entityID,
    required this.title,
    required this.versionID,
    required this.versionName,
    required this.url,
    required this.updatedAt,
    this.isDeleted = false,
    this.localFilePath,
    this.oldUrl,
  });

  ExamEntity copyWith({
    String? title,
    String? updatedAt,
  }) {
    return ExamEntity(
      entityID: entityID,
      title: title ?? this.title,
      versionID: versionID,
      url: url,
      oldUrl: oldUrl,
      versionName: versionName,
      localFilePath: localFilePath,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  // TODO: implement name
  String? get name => title;
}
