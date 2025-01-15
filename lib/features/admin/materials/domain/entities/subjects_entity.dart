import 'package:atm_app/core/entities/entitiy.dart';

class SubjectsEntity implements Entity {
  @override
  final String? id;
  final String subjectName;
  SubjectsEntity({
    this.id,
    required this.subjectName,
  });

  @override
  // TODO: implement name
  String get name => subjectName;
}
