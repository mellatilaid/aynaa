import 'package:isar/isar.dart';

part 'settings_entity.g.dart';

@Collection()
class SettingsEntity {
  Id id = 0;
  @Index(unique: true, replace: true)
  final String entityID;
  String? lastTimeVersionsFetched;

  SettingsEntity(
      {required this.entityID, required this.lastTimeVersionsFetched});
}
