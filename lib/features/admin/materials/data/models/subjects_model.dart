import 'package:atm_app/features/admin/materials/domain/entities/subjects_entity.dart';

class SubjectsModel extends SubjectsEntity {
  @override
  final String id;
  @override
  final String subjectName;

  SubjectsModel({required this.id, required this.subjectName})
      : super(id: id, subjectName: subjectName);
}
