import 'package:atm_app/features/admin/materials/data/models/aynaa_versions_model.dart';
import 'package:atm_app/features/admin/materials/domain/entities/aynaa_versions_entity.dart';

import '../../../../../../core/services/storage_service.dart';

abstract class AynaaVersionsRemoteDataSource {
  Future<List<AynaaVersionsEntity>> fetchAynaaVersions();
}

class AynaaVersionsRemoteDataSourceImpl
    implements AynaaVersionsRemoteDataSource {
  final StorageService storageService;

  AynaaVersionsRemoteDataSourceImpl({required this.storageService});
  @override
  Future<List<AynaaVersionsEntity>> fetchAynaaVersions() async {
    final List<dynamic> buckets = await storageService.getAllBuckets();

    List<AynaaVersionsEntity> aynaaVersions =
        convertToAynaaVersionEntity(buckets);

    return aynaaVersions;
  }

  List<AynaaVersionsEntity> convertToAynaaVersionEntity(List<dynamic> buckets) {
    final List<AynaaVersionsEntity> aynaaVersions = buckets.map((bucket) {
      return AynaaVersionsModel.fromSupabase(bucket);
    }).toList();
    return aynaaVersions;
  }
}
