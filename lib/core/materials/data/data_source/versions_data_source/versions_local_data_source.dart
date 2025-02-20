import 'package:atm_app/core/helper/enums.dart';
import 'package:atm_app/core/materials/domain/entities/aynaa_versions_entity.dart';

abstract class VersionsLocalDataSource {
  Future<List<AynaaVersionsEntity>> fetchVersion();

  Future<void> handleUpdate(
      {AynaaVersionsEntity? version,
      String? id,
      required PostgressEventType eventType});
  Stream<List<AynaaVersionsEntity>> get versionsStream;
}
