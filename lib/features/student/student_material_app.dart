import 'package:atm_app/features/admin/materials/presentation/manager/add_text_lesson_cubit/lesson_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import '../../core/materials/domain/repos/lessons_repo.dart';
import '../../core/utils/app_route.dart';
import '../../core/utils/set_up_service_locator.dart';

class StudentMaterialApp extends StatelessWidget {
  const StudentMaterialApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LessonCubit(getit.get<LessonsRepo>()),
      child: MaterialApp.router(
        routerConfig: StudentAppRouter.router,
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
