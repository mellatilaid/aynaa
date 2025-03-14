import 'package:atm_app/core/services/realtime_sync_service.dart';
import 'package:atm_app/core/utils/app_route.dart';
import 'package:atm_app/core/utils/set_up_service_locator.dart';
import 'package:atm_app/features/auth/domain/repos/auth_repo.dart';
import 'package:atm_app/features/auth/presentation/manager/sign_out_cubit/sign_out_cubit.dart';
import 'package:atm_app/features/common/versions/domain/repos/lessons_repo.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'features/common/versions/presentation/manager/add_text_lesson_cubit/lesson_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: 'var.env');
  await Supabase.initialize(
    url: dotenv.get('Project_URL'),
    anonKey: dotenv.get('ANON_KEY'),
  );

  //await initializeCache();
  await setUpCoreServiceLocator();

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

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();

    // Add observer to monitor app lifecycle
    WidgetsBinding.instance.addObserver(this);

    // Subscribe to the channel when the app starts
    getit.get<RealtimeSyncService>().initialize();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    if (state == AppLifecycleState.resumed) {
      // App is in the foreground, subscribe to the channel
      RealtimeSyncService().initialize();
    } else if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.detached) {
      // App is in the background or closed, unsubscribe from the channel
      RealtimeSyncService().dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LessonCubit(getit.get<LessonsRepo>()),
        ),
        BlocProvider(
          create: (context) => SignOutCubit(authRepo: getit.get<AuthRepo>()),
        ),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: AppRouter.router,
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
      ),
    );
  }
}
