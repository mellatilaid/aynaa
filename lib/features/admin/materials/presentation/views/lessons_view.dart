import 'package:atm_app/features/admin/materials/domain/entities/subjects_entity.dart';
import 'package:atm_app/features/admin/materials/presentation/manager/fetch_lessons_cubit/fetch_lessons_cubit.dart';
import 'package:atm_app/features/admin/materials/presentation/views/widgets/add_lesson_full_screen_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/set_up_service_locator.dart';
import '../../domain/repos/lessons_repo.dart';
import 'widgets/lessons_view_body.dart';

class LessonsView extends StatelessWidget {
  final SubjectsEntity subjectsEntity;
  const LessonsView({super.key, required this.subjectsEntity});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          FetchLessonsCubit(lessonsRepo: getit.get<LessonsRepo>()),
      child: Scaffold(
        appBar: AppBar(
          leading: const BackButton(),
        ),
        body: LessonsViewBody(
          subjectsEntity: subjectsEntity,
        ),
        floatingActionButton: Builder(builder: (fabcontext) {
          // addLessonCubit = fabcontext.read<AddLessonCubit>();
          return FloatingActionButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
            child: const Icon(Icons.add),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled:
                    true, // Allows it to take up the full height
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
                builder: (context) {
                  return const AddLessonBottomSheet();
                },
              );
            },
          );
        }),
      ),
    );
  }
}
