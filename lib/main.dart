import 'package:atm_app/core/utils/app_route.dart';
import 'package:atm_app/core/utils/set_up_service_locator.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: 'var.env');

  await Supabase.initialize(
    url: dotenv.get('Project_URL'),
    anonKey: dotenv.get('ANON_KEY'),
  );
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
    return MaterialApp.router(
      routerConfig: AdminAppRouter.router,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('ar', 'DZ'),
        Locale('en', 'US'),
      ],
      locale: const Locale('ar', 'DZ'),
    );
  }
}
