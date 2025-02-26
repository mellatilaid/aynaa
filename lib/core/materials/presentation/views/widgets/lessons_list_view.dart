import 'package:atm_app/core/materials/domain/repos/lessons_repo.dart';
import 'package:atm_app/core/materials/presentation/views/widgets/add_text_lesson_bottom_sheet.dart';
import 'package:atm_app/core/utils/app_route.dart';
import 'package:atm_app/core/utils/set_up_service_locator.dart';
import 'package:atm_app/features/admin/materials/presentation/manager/fetch_lessons_cubit/fetch_lessons_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../core/materials/domain/entities/lesson_entity.dart';
import 'custom_lesson_card.dart';

class LessonsListView extends StatelessWidget {
  final List<LessonEntity> lessons;
  const LessonsListView({super.key, required this.lessons});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: lessons.length,
      itemBuilder: (context, index) {
        return CustomLessonCard(
          onTap: () => context.push(
            AppRouter.lessonDetailView,
            extra: lessons[index],
          ),
          item: lessons[index],
          onDelete: () {
            getit.get<LessonsRepo>().deleteLesson(lesson: lessons[index]);
          },
          onEdit: () {
            final fetchLessonsCubit = context.read<FetchLessonsCubit>();
            showModalBottomSheet(
                isScrollControlled: true,
                context: context,
                builder: (context) {
                  return AddTextLessonBottomSheet(
                    fetchLessonsCubit: fetchLessonsCubit,
                    isTextOnly: true,
                    isEditMode: true,
                    lessonEntity: lessons[index],
                  );
                });
          },
        );
        //return CustomCard(entity: lessons[index]);
      },
    );
  }
}
