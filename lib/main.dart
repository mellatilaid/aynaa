import 'package:atm_app/core/services/initiliaze_cache.dart';
import 'package:atm_app/core/utils/set_up_service_locator.dart';
import 'package:atm_app/features/admin/admin_material_app.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: 'var.env');
  await Supabase.initialize(
    url: dotenv.get('Project_URL'),
    anonKey: dotenv.get('ANON_KEY'),
  );

  await initializeCache();
  setUpServiceLocator();
  //await Firebase.initializeApp();
  if (0 == 0) {
    runApp(DevicePreview(
      enabled: true, // Set to `true` to enable DevicePreview
      builder: (context) => const MyApp(), // Your app entry point
    ));
  } else {
    runApp(const MyApp());
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const AdminMaterialApp();
  }
}
