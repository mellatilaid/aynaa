import 'package:atm_app/core/helper/enums.dart';
import 'package:atm_app/core/services/local_settings_service/i_local_settings_service.dart';
import 'package:atm_app/core/utils/set_up_service_locator.dart';

updateLastFetchedItemsTime<T>({required Entities itemType}) async {
  final settings = await getit.get<ILocalSettingsService>().getSettings();
  switch (itemType) {
    case Entities.versions:
      settings!.lastTimeVersionsFetched =
          DateTime.now().toUtc().toIso8601String();
      await getit
          .get<ILocalSettingsService>()
          .updateSettings(settingsEntity: settings);
      break;
    case Entities.subjects:
      settings!.lastTimeSubjectsFetched =
          DateTime.now().toUtc().toIso8601String();
      await getit
          .get<ILocalSettingsService>()
          .updateSettings(settingsEntity: settings);
      break;
    case Entities.lessons:
      settings!.lastTimeLessonssFetched =
          DateTime.now().toUtc().toIso8601String();
      await getit
          .get<ILocalSettingsService>()
          .updateSettings(settingsEntity: settings);
      break;
    case Entities.exam:
      settings!.lastTimeExamsFetched = DateTime.now().toUtc().toIso8601String();
      await getit
          .get<ILocalSettingsService>()
          .updateSettings(settingsEntity: settings);
      break;
    case Entities.examSections:
      settings!.lastTimeSectionsFetched =
          DateTime.now().toUtc().toIso8601String();
      await getit
          .get<ILocalSettingsService>()
          .updateSettings(settingsEntity: settings);
      break;
    case Entities.questions:
      settings!.lastTimeQuestionsFetched =
          DateTime.now().toUtc().toIso8601String();
      await getit
          .get<ILocalSettingsService>()
          .updateSettings(settingsEntity: settings);
      break;
    default:
  }
}
