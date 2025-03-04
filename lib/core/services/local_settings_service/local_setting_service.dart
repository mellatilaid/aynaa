import 'package:atm_app/core/common/settings_entity.dart';
import 'package:atm_app/core/services/local_db_service/i_local_db_service.dart';
import 'package:atm_app/core/services/local_settings_service/i_local_settings_service.dart';

class LocalSettingService extends ILocalSettingsService {
  final ILocalDbService localDBService;
  LocalSettingService({required this.localDBService});
  @override
  Future<SettingsEntity?> getSettings() async {
    final settingsEntity = await localDBService.get<SettingsEntity>(id: '0');
    return settingsEntity;
  }

  @override
  Future<void> updateSettings({required SettingsEntity settingsEntity}) async {
    await localDBService.put<SettingsEntity>(item: settingsEntity);
  }

  @override
  Future<void> init({required SettingsEntity settingsEntity}) async {
    final settings = await getSettings();
    if (settings != null) return;
    await localDBService.put<SettingsEntity>(item: settingsEntity);
  }
}
