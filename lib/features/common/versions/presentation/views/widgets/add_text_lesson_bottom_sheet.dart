import 'package:atm_app/core/classes/pick_file.dart';
import 'package:atm_app/core/utils/set_up_service_locator.dart';
import 'package:atm_app/features/common/versions/domain/entities/lesson_entity.dart';
import 'package:atm_app/features/common/versions/presentation/manager/add_text_lesson_cubit/lesson_cubit.dart';
import 'package:atm_app/features/common/versions/presentation/manager/fetch_lessons_cubit/fetch_lessons_cubit.dart';
import 'package:atm_app/features/common/versions/presentation/manager/pick_file_cubit/pick_file_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../../core/widgets/scaffold_message.dart';
import 'add_lesson_button_sheet_body.dart';

class AddTextLessonBottomSheet extends StatefulWidget {
  final bool isTextOnly;
  final bool isEditMode;
  final LessonEntity? lessonEntity;
  final FetchLessonsCubit fetchLessonsCubit;
  const AddTextLessonBottomSheet({
    super.key,
    required this.fetchLessonsCubit,
    required this.isTextOnly,
    this.isEditMode = false,
    this.lessonEntity,
  });

  @override
  State<AddTextLessonBottomSheet> createState() =>
      _AddTextLessonBottomSheetState();
}

class _AddTextLessonBottomSheetState extends State<AddTextLessonBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PickFileCubit(getit.get<FilePickerHelper>()),
      child: BlocBuilder<LessonCubit, LessonState>(
        builder: (context, state) {
          if (state is LessonFailure) {
            context.pop();

            showScaffoldMessage(context, state.errMessage);
            BlocProvider.of<LessonCubit>(context).resetState();
          } else if (state is LessonSuccuss) {
            Future.microtask(() {
              if (!context.mounted) return;
              context.pop();
            });
            widget.fetchLessonsCubit.fetchLessons(
              subjectID: _getSubjectID(),
              versionID: _getVersionID(),
            );
            BlocProvider.of<LessonCubit>(context).resetState();
          }
          return (widget.isEditMode)
              ? AddLessonBottomSheetBody.edit(lesson: widget.lessonEntity!)
              : AddLessonBottomSheetBody(
                  isTextOnly: widget.isTextOnly,
                );
        },
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
