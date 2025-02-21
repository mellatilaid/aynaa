import 'package:isar/isar.dart';

part 'settings_entity.g.dart';

@Collection()
class SettingsEntity {
  Id id = 0;
  final String entityID = '0';
  final String lastTimeVersionsFetched;

  SettingsEntity({required this.lastTimeVersionsFetched});
}
