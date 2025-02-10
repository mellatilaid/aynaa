import 'package:atm_app/core/materials/domain/entities/aynaa_versions_entity.dart';

abstract class AynaaVersionsRemoteDataSource {
  Future<List<AynaaVersionsEntity>> fetchAynaaVersions();
}
