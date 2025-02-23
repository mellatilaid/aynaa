import 'package:atm_app/core/helper/enums.dart';
import 'package:atm_app/core/services/local_settings_service/i_local_settings_service.dart';
import 'package:atm_app/core/utils/set_up_service_locator.dart';

updateLastFetchedItemsTime({required Entities itemType}) async {
  switch (itemType) {
    case Entities.versions:
      final settings = await getit.get<ILocalSettingsService>().getSettings();
      settings!.lastTimeVersionsFetched =
          DateTime.now().toUtc().toIso8601String();
      await getit
          .get<ILocalSettingsService>()
          .updateSettings(settingsEntity: settings);
      break;
    default:
  }
}
