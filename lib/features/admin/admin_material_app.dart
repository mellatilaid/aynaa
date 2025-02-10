import 'package:atm_app/core/materials/domain/repos/lessons_repo.dart';
import 'package:atm_app/core/utils/set_up_service_locator.dart';
import 'package:atm_app/features/admin/materials/presentation/manager/add_text_lesson_cubit/add_lesson_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import '../../core/utils/app_route.dart';

class AdminMaterialApp extends StatefulWidget {
  const AdminMaterialApp({
    super.key,
  });

  @override
  State<AdminMaterialApp> createState() => _AdminMaterialAppState();
}

class _AdminMaterialAppState extends State<AdminMaterialApp>
    with WidgetsBindingObserver {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddLessonCubit(getit.get<LessonsRepo>()),
      child: MaterialApp.router(
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
      ),
    );
  }
}
