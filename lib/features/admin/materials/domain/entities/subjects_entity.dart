import 'package:atm_app/core/entities/entitiy.dart';

class SubjectsEntity implements Entity {
  @override
  final String? id;
  final String subjectName;
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
