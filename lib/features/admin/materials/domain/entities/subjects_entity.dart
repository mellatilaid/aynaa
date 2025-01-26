import 'package:atm_app/core/entities/entitiy.dart';
import 'package:hive/hive.dart';

part 'subjects_entity.g.dart';

@HiveType(typeId: 1)
class SubjectsEntity implements Entity {
  @override
  @HiveField(0)
  final String? id;
  @HiveField(1)
  final String subjectName;
  @HiveField(2)
  final String versionID;

  SubjectsEntity({
    this.id,
    required this.subjectName,
    required this.versionID,
  });

  @override
  // TODO: implement name
  String get name => subjectName;
}
