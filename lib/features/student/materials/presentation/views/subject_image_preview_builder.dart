import 'package:atm_app/features/admin/materials/presentation/manager/add_new_subject_cubit/add_new_subject_cubit.dart';
import 'package:atm_app/features/admin/materials/presentation/manager/pick_file_cubit/pick_file_cubit.dart';
import 'package:atm_app/features/admin/materials/presentation/views/widgets/lesson_media_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SubjectImageContentBuilder extends StatelessWidget {
  final String? filePath;
  const SubjectImageContentBuilder({
    super.key,
    required this.filePath,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PickFileCubit, PickFileState>(
      listener: (context, state) {
        if (state is PickFileLoaded) {
          BlocProvider.of<AddNewSubjectCubit>(context)
              .setFilePath(state.filePath.path);
        }
      },
      builder: (context, state) {
        if (state is PickFileFailure) {
          return ErrorWidget(state.errMessage);
        } else if (state is PickFileLoaded) {
          return LessonMediaPreview(
            filePath: state.filePath,
          );
        }
        return const LessonMediaPreview();
      },
    );
  }
}
