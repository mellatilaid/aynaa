import 'package:atm_app/core/entities/entitiy.dart';

class AynaaVersionsEntity implements Entity {
  @override
  final String id;
  final String versionName;

  AynaaVersionsEntity({required this.id, required this.versionName});

  @override
  // TODO: implement name
  String get name => versionName;
}
