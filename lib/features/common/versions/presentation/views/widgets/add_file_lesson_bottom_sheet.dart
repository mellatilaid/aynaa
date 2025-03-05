import 'package:atm_app/core/classes/pick_file.dart';
import 'package:atm_app/core/utils/set_up_service_locator.dart';
import 'package:atm_app/features/common/versions/domain/repos/lessons_repo.dart';
import 'package:atm_app/features/common/versions/presentation/manager/add_file_lesson_cubit/add_file_lesson_cubit.dart';
import 'package:atm_app/features/common/versions/presentation/manager/add_text_lesson_cubit/lesson_cubit.dart';
import 'package:atm_app/features/common/versions/presentation/manager/fetch_lessons_cubit/fetch_lessons_cubit.dart';
import 'package:atm_app/features/common/versions/presentation/manager/pick_file_cubit/pick_file_cubit.dart';
import 'package:atm_app/features/common/versions/presentation/views/widgets/add_file_lesson_bottom_sheet_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../../core/widgets/scaffold_message.dart';

class AddFileLessonBottomSheet extends StatefulWidget {
  const AddFileLessonBottomSheet({
    super.key,
  });

  @override
  State<AddFileLessonBottomSheet> createState() =>
      _AddFileLessonBottomSheetState();
}

class _AddFileLessonBottomSheetState extends State<AddFileLessonBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => PickFileCubit(getit.get<FilePickerHelper>()),
        ),
        BlocProvider(
          create: (context) =>
              AddFileLessonCubit(lessonsRepo: getit.get<LessonsRepo>()),
        ),
      ],
      child: FractionallySizedBox(
        heightFactor:
            0.8, // Adjust this for the height you need (e.g., 90% of the screen)
        child: BlocListener<LessonCubit, LessonState>(
          listener: (context, state) {
            if (state is LessonFailure) {
              context.pop();
              showScaffoldMessage(context, state.errMessage);
            } else if (state is LessonSuccuss) {
              Future.microtask(() {
                if (!context.mounted) return;
                context.pop();
              });
              context.read<FetchLessonsCubit>().fetchLessons(
                    subjectID: _getSubjectID(),
                    versionID: _getVersionID(),
                  );
            }
          },
          child: const AddFileLessonBottomSheetBody(),
        ),
      ),
    );
    return BlocProvider(
      create: (context) => PickFileCubit(getit.get<FilePickerHelper>()),
      child: FractionallySizedBox(
        heightFactor:
            0.8, // Adjust this for the height you need (e.g., 90% of the screen)
        child: BlocListener<LessonCubit, LessonState>(
          listener: (context, state) {
            if (state is LessonFailure) {
              context.pop();
              showScaffoldMessage(context, state.errMessage);
            } else if (state is LessonSuccuss) {
              Future.microtask(() {
                if (!context.mounted) return;
                context.pop();
              });
              context.read<FetchLessonsCubit>().fetchLessons(
                    subjectID: _getSubjectID(),
                    versionID: _getVersionID(),
                  );
            }
          },
          child: const AddFileLessonBottomSheetBody(),
        ),
      ),
    );
  }

  _getVersionID() {
    final versionID = context.read<LessonCubit>().versionID;
    return versionID!;
  }

  _getSubjectID() {
    final subjectID = context.read<LessonCubit>().subjectID;
    return subjectID!;
  }
}
