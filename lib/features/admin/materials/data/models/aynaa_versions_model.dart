import '../../domain/entities/aynaa_versions_entity.dart';

class AynaaVersionsModel extends AynaaVersionsEntity {
  final String aynaaVersion;

  AynaaVersionsModel({required this.aynaaVersion})
      : super(versionName: aynaaVersion);
}
