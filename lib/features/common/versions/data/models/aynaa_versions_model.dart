import 'package:atm_app/features/common/versions/domain/entities/aynaa_versions_entity.dart';

import '../../../../../../../core/const/remote_db_const.dart';
import '../../../../../../../core/mixins/mappable.dart';

class AynaaVersionsModel extends AynaaVersionsEntity with Mappable {
  AynaaVersionsModel({
    required super.entityID,
    required super.versionName,
    required super.url,
    required super.updatedAt,
    super.isDeleted,
    super.localFilePath,
  });
  factory AynaaVersionsModel.fromJson(Map<String, dynamic> data) {
    return AynaaVersionsModel(
      entityID: data[kUuid].toString(),
      versionName: data[kVersionName],
      url: data[kUrl],
      updatedAt: data[kUpdatedAt],
      isDeleted: data[kIsDeleted],
      //localFilePath: data[kLocalFilePath],
    );
  }

  factory AynaaVersionsModel.fromVersionEntity(AynaaVersionsEntity version) {
    return AynaaVersionsModel(
      entityID: version.entityID,
      versionName: version.versionName,
      url: version.url,
      updatedAt: version.updatedAt,
      //localFilePath: data[kLocalFilePath],
    );
  }

  /* static AynaaVersionsModel fromMap(Map<String, dynamic> data) {
    return AynaaVersionsModel(
      data[kUuid].toString(),
      aynaaVersion: data[kVersionName],
      url: data[kUrl],
      localFilePath: data[kLocalFilePath],
    );
  }*/

  @override
  Map<String, dynamic> toMap() {
    return {
      kVersionName: versionName,
      kUrl: url,
      kUpdatedAt: updatedAt,
    };
  }
}
