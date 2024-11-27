import '../../domain/entities/aynaa_versions_entity.dart';

class AynaaVersionsModel extends AynaaVersionsEntity {
  final String aynaaVersion;
  @override
  final String id;

  AynaaVersionsModel(this.id, {required this.aynaaVersion})
      : super(versionName: aynaaVersion, id: id);
}
