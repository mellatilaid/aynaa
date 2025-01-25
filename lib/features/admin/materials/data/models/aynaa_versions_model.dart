import '../../../../../core/const/remote_db_const.dart';
import '../../../../../core/mixins/mappable.dart';
import '../../domain/entities/aynaa_versions_entity.dart';

class AynaaVersionsModel extends AynaaVersionsEntity with Mappable {
  final String aynaaVersion;

  @override
  final String id;

  AynaaVersionsModel(this.id, {required this.aynaaVersion})
      : super(versionName: aynaaVersion, id: id);

  factory AynaaVersionsModel.fromSupabase(Map<String, dynamic> data) {
    return AynaaVersionsModel(
      data[kUuid].toString(),
      aynaaVersion: data[kVersionName],
    );
  }

  @override
  Map<String, dynamic> toMap() {
    // TODO: implement toMap
    throw UnimplementedError();
  }
}
