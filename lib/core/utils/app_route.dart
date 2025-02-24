import 'package:atm_app/core/materials/domain/entities/aynaa_versions_entity.dart';
import 'package:atm_app/core/materials/domain/entities/lesson_entity.dart';
import 'package:atm_app/core/materials/domain/entities/subjects_entity.dart';
import 'package:atm_app/core/shared_features/exams/domain/entities/exam_entity.dart';
import 'package:atm_app/core/shared_features/exams/domain/entities/exam_sections_entity.dart';
import 'package:atm_app/core/shared_features/exams/presentation/views/exam_sections_view.dart';
import 'package:atm_app/core/shared_features/exams/presentation/views/quiz_view.dart';
import 'package:atm_app/features/admin/admin_bottom_nav_view.dart';
import 'package:atm_app/features/auth/presentation/views/sign_in_view.dart';
import 'package:atm_app/features/splash_view/presentation/views/splash_view.dart';
import 'package:atm_app/features/student/student_bottom_nav_view.dart';
import 'package:go_router/go_router.dart';

import '../materials/presentation/views/lesson_detail_view.dart';
import '../materials/presentation/views/lessons_view.dart';
import '../materials/presentation/views/subjects_view.dart';
import '../materials/presentation/views/upload_file_test.dart';

abstract class AppRouter {
  static const String adminHomeView = '/home';
  static const String adminNavBarView = '/adminNavBar';
  static const String versionSubjectsView = '/versionSubjects';
  static const String lessonsView = '/lessons';
  static const String uploadPage = '/uploadPage';
  static const String lessonDetailView = '/lessonDetailView';
  static const String studentBottomNavView = '/studnetNavBarView';
  static const String signInView = '/signInView';
  static const String examSectionsView = '/examSectionsView';
  static const String testView = '/testView';
  static final router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/lll',
        builder: (context, state) => const SplashView(),
      ),
      GoRoute(
        path: '/ddd',
        builder: (context, state) => const SignInView(),
      ),
      GoRoute(
        path: '/',
        builder: (context, state) => const AdminBottomNavView(),
      ),
      GoRoute(
        path: uploadPage,
        builder: (context, state) => const UploadPage(),
      ),
      GoRoute(
        path: versionSubjectsView,
        builder: (context, state) {
          final data = state.extra as AynaaVersionsEntity;

          return SubjectsView(
            aynaaVersionsEntity: data,
          );
        },
      ),
      GoRoute(
        path: lessonDetailView,
        builder: (context, state) {
          final data = state.extra as LessonEntity;

          return LessonDetailView(
            lesson: data,
          );
        },
      ),
      GoRoute(
        path: lessonsView,
        builder: (context, state) {
          final data = state.extra as SubjectsEntity;
          //return const UploadPage();
          return LessonsView(
            subjectsEntity: data,
          );
        },
      ),
      GoRoute(
        path: 'dddd',
        builder: (context, state) => const StudentBottomNavView(),
      ),
      GoRoute(
          path: examSectionsView,
          builder: (context, state) {
            final data = state.extra as ExamEntity;
            return ExamSectionsView(
              examEntity: data,
            );
          }),
      GoRoute(
          path: testView,
          builder: (context, state) {
            final data = state.extra as ExamSectionsEntity;
            return QuizView(
              examSectionsEntity: data,
            );
          }),
    ],
  );
}

abstract class StudentAppRouter {
  static const String studentHomeView = '/student';
  static const String studentBottomNavView = '/studnetNavBarView';
  static final router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: studentHomeView,
        builder: (context, state) => const SignInView(),
      ),
      GoRoute(
        path: '/',
        builder: (context, state) => const StudentBottomNavView(),
      ),
      GoRoute(
        path: '/',
        builder: (context, state) => const AdminBottomNavView(),
      ),
    ],
  );
}
