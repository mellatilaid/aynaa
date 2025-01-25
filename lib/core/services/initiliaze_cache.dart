import 'package:atm_app/features/admin/materials/domain/entities/aynaa_versions_entity.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future<void> initializeCache() async {
  await Hive.initFlutter();

  // Register all adapters
  Hive.registerAdapter(AynaaVersionsEntityAdapter());
}
