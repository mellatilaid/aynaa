import 'package:atm_app/core/common/settings_entity.dart';

abstract class ILocalSettingsService {
  Future<void> init({required SettingsEntity settingsEntity});
  Future<SettingsEntity?> getSettings();
  Future<void> updateSettings({required SettingsEntity settingsEntity});
}
