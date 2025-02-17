import 'package:atm_app/core/materials/presentation/views/widgets/lesson_media_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../features/admin/materials/presentation/manager/pick_file_cubit/pick_file_cubit.dart';

class ExamSectionImageContentBuilder extends StatelessWidget {
  final String? filePath;
  const ExamSectionImageContentBuilder({
    super.key,
    required this.filePath,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PickFileCubit, PickFileState>(
      listener: (context, state) {
        if (state is PickFileLoaded) {}
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
