import 'package:atm_app/core/services/data_base.dart';
import 'package:atm_app/features/admin/materials/data/models/subjects_model.dart';
import 'package:atm_app/features/admin/materials/domain/entities/subjects_entity.dart';

import '../../../../../../core/utils/db_enpoints.dart';

abstract class SubjectsRemoteDataSource {
  Future<List<SubjectsEntity>> fetchSubjects();
}

class subjectsRemoteDataSourceImpl extends SubjectsRemoteDataSource {
  final DataBase dataBase;

  subjectsRemoteDataSourceImpl({required this.dataBase});

  @override
  Future<List<SubjectsEntity>> fetchSubjects() async {
    final List<Map<String, dynamic>> aynaaSubjects =
        await dataBase.getDate(path: DbEnpoints.subjects);

    List<SubjectsEntity> subjects = _convertToAynaaVersionEntity(aynaaSubjects);

    return subjects;
  }

  List<SubjectsEntity> _convertToAynaaVersionEntity(
      List<Map<String, dynamic>> versions) {
    final List<SubjectsEntity> aynaaVersions = versions.map((item) {
      return SubjectsModel.fromMap(item);
    }).toList();
    return aynaaVersions;
  }
}
