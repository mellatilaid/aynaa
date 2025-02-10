import '../../../../../core/const/remote_db_const.dart';
import '../../../../../core/mixins/mappable.dart';
import '../../domain/entities/aynaa_versions_entity.dart';

class AynaaVersionsModel extends AynaaVersionsEntity with Mappable {
  final String aynaaVersion;

  @override
  final String entityID;
  @override
  String? localFilePath;
  @override
  String url;

  AynaaVersionsModel(this.entityID,
      {required this.aynaaVersion, required this.url, this.localFilePath})
      : super(
          versionName: aynaaVersion,
          entityID: entityID,
          url: url,
          localFilePath: localFilePath,
        );

  factory AynaaVersionsModel.fromSupabase(Map<String, dynamic> data) {
    return AynaaVersionsModel(
      data[kUuid].toString(),
      aynaaVersion: data[kVersionName],
      url: data[kUrl],
      //localFilePath: data[kLocalFilePath],
    );
  }

  factory AynaaVersionsModel.fromVersionEntity(AynaaVersionsEntity version) {
    return AynaaVersionsModel(
      version.entityID,
      aynaaVersion: version.versionName,
      url: version.url,
      //localFilePath: data[kLocalFilePath],
    );
  }

  static AynaaVersionsModel fromMap(Map<String, dynamic> data) {
    return AynaaVersionsModel(
      data[kUuid].toString(),
      aynaaVersion: data[kVersionName],
      url: data[kUrl],
      localFilePath: data[kLocalFilePath],
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      kVersionName: aynaaVersion,
      kUrl: url,
    };
  }
}
