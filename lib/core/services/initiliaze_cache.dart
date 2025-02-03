import 'package:hive_flutter/hive_flutter.dart';

Future<void> initializeCache() async {
  await Hive.initFlutter();

  // Register all adapters
  /*Hive.registerAdapter(AynaaVersionsEntityAdapter());
  Hive.registerAdapter(SubjectsEntityAdapter());
  Hive.registerAdapter(LessonEntityAdapter());*/
}
