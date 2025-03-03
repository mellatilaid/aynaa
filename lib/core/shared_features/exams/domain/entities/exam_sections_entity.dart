import 'package:atm_app/core/common/entitiy.dart';
import 'package:isar/isar.dart';

part 'exam_sections_entity.g.dart';

@Collection()
class ExamSectionsEntity with Entity {
  Id id = Isar.autoIncrement;
  @override
  @Index(unique: true)
  final String entityID;
  final String title;
  final String examTitle;
  @override
  final String versionName;

  @override
  String? url;
  @override
  String? oldUrl;
  final String examID;
  @override
  String? localFilePath;
  bool isLocked;
  @override
  String updatedAt;
  int score;
  int totalQuestions;
  @override
  bool isDeleted;
  ExamSectionsEntity({
    required this.entityID,
    required this.title,
    required this.examTitle,
    required this.versionName,
    required this.updatedAt,
    this.url,
    this.oldUrl,
    required this.examID,
    this.localFilePath,
    this.isDeleted = false,
    this.isLocked = true,
    this.score = 0,
    this.totalQuestions = 0,
  });

  ExamSectionsEntity copyWith({
    String? title,
    String? updatedAt,
  }) {
    return ExamSectionsEntity(
      entityID: entityID,
      title: title ?? this.title,
      examTitle: examTitle,
      versionName: versionName,
      updatedAt: updatedAt ?? this.updatedAt,
      url: url,
      oldUrl: oldUrl,
      examID: examID,
      localFilePath: localFilePath,
      isDeleted: isDeleted,
      isLocked: isLocked,
      score: score,
      totalQuestions: totalQuestions,
    );
  }

  @override
  // TODO: implement name
  String? get name => title;
}
