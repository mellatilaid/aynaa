import 'package:atm_app/features/common/versions/presentation/manager/add_text_lesson_cubit/lesson_cubit.dart';
import 'package:atm_app/features/common/versions/presentation/manager/pick_file_cubit/pick_file_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'lesson_media_preview.dart';

class LessonMediaContentBuilder extends StatelessWidget {
  final String? filePath;
  const LessonMediaContentBuilder({
    super.key,
    required this.filePath,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PickFileCubit, PickFileState>(
      listener: (context, state) {
        if (state is PickFileLoaded) {
          BlocProvider.of<LessonCubit>(context)
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
