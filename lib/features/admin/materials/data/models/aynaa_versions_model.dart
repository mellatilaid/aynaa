import '../../../../../const.dart';
import '../../domain/entities/aynaa_versions_entity.dart';

class AynaaVersionsModel extends AynaaVersionsEntity {
  final String aynaaVersion;

  @override
  final String id;

  AynaaVersionsModel(this.id, {required this.aynaaVersion})
      : super(versionName: aynaaVersion, id: id);

  factory AynaaVersionsModel.fromSupabase(Map<String, dynamic> data) {
    return AynaaVersionsModel(data[kUuid].toString(),
        aynaaVersion: data[kVersionName]);
  }
}
