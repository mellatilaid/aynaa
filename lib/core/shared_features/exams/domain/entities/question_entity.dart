import 'package:atm_app/core/common/entitiy.dart';
import 'package:isar/isar.dart';

part 'question_entity.g.dart';

@Collection()
class QuestionEntity with Entity {
  Id id = Isar.autoIncrement;
  @override
  @Index(unique: true)
  final String entityID;
  final String sectionID;
  final String question;
  final String answer;
  final List<String> options;
  @override
  String updatedAt;

  QuestionEntity({
    required this.entityID,
    required this.sectionID,
    required this.question,
    required this.answer,
    required this.options,
    required this.updatedAt,
  });

  @override
  String? localFilePath;

  @override
  // TODO: implement isDeleted
  bool get isDeleted => false;

  @override
  // TODO: implement name
  String? get name => null;

  @override
  // TODO: implement oldUrl
  String? get oldUrl => null;

  @override
  // TODO: implement url
  String? get url => '';

  @override
  // TODO: implement versionName
  String get versionName => '';
}
