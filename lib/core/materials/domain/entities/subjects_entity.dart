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
  String? oldUrl;
  @override
  late String? localFilePath;
  String updatedAt;
  String? pickedFilePath;
  SubjectsEntity({
    required this.entityID,
    required this.subjectName,
    required this.versionName,
    required this.url,
    this.oldUrl,
    required this.versionID,
    this.localFilePath,
    required this.updatedAt,
    this.pickedFilePath,
  });

  SubjectsEntity copyWith({
    String? title,
    String? updatedAt,
    String? oldUrl,
  }) {
    return SubjectsEntity(
      entityID: entityID,
      subjectName: title ?? subjectName,
      versionID: versionID,
      url: url,
      oldUrl: oldUrl,
      versionName: versionName,
      localFilePath: localFilePath,
      updatedAt: updatedAt ?? this.updatedAt,
      pickedFilePath: pickedFilePath,
    );
  }

  @override
  // TODO: implement name
  String get name => subjectName;
}
