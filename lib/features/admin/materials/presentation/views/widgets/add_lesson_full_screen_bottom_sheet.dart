import 'package:atm_app/features/admin/materials/presentation/manager/add_lesson_cubit/add_lesson_cubit.dart';
import 'package:atm_app/features/admin/materials/presentation/manager/fetch_lessons_cubit/fetch_lessons_cubit.dart';
import 'package:atm_app/features/admin/materials/presentation/views/widgets/add_lesson_button_sheet_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../core/widgets/scaffold_message.dart';

class AddLessonBottomSheet extends StatefulWidget {
  const AddLessonBottomSheet({
    super.key,
  });

  @override
  State<AddLessonBottomSheet> createState() => _AddLessonBottomSheetState();
}

class _AddLessonBottomSheetState extends State<AddLessonBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      heightFactor:
          0.8, // Adjust this for the height you need (e.g., 90% of the screen)
      child: BlocBuilder<AddLessonCubit, AddLessonState>(
        builder: (context, state) {
          if (state is AddLessonFailure) {
            context.pop();
            showScaffoldMessage(context, state.errMessage);
          } else if (state is AddLessonSuccuss) {
            Future.microtask(() {
              if (!context.mounted) return;
              context.pop();
            });
            context.read<FetchLessonsCubit>().fetchLessons(
                  subjectID: _getSubjectID(),
                  versionID: _getVersionID(),
                );
          }
          return const AddLessonBottomSheetBody();
        },
      ),
    );
  }

  _getVersionID() {
    final versionID = context.read<AddLessonCubit>().versionID;
    return versionID!;
  }

  _getSubjectID() {
    final subjectID = context.read<AddLessonCubit>().subjectID;
    return subjectID!;
  }
}

class LessonMediaContent extends StatelessWidget {
  const LessonMediaContent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      color: Colors.grey[300],
      child: const Center(child: Text('Other Content Goes Here')),
    );
  }
}
