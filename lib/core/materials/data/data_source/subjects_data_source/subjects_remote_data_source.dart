import 'package:atm_app/core/materials/domain/entities/subjects_entity.dart';

abstract class SubjectsRemoteDataSource {
  Future<List<SubjectsEntity>> fetchSubjects({required String versionID});
  Future<void> syncDB({required String versionID});
}
