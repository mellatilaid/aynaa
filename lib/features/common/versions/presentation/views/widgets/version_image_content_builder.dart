import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../manager/creata_new_aynaa_version_cubit/create_new_aynaa_version_cubit.dart';
import '../../manager/pick_file_cubit/pick_file_cubit.dart';
import 'lesson_media_preview.dart';

class VersionImageContentBuilder extends StatelessWidget {
  final String? filePath;
  final Function(String path) onFileLoaded;
  const VersionImageContentBuilder({
    super.key,
    required this.filePath,
    required this.onFileLoaded,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PickFileCubit, PickFileState>(
      listener: (context, state) {
        if (state is PickFileLoaded) {
          BlocProvider.of<CreateNewAynaaVersionCubit>(context)
              .setFilePath(state.filePath.path);
        }
      },
      builder: (context, state) {
        if (state is PickFileFailure) {
          return ErrorWidget(state.errMessage);
        } else if (state is PickFileLoaded) {
          onFileLoaded(state.filePath.path);
          return LessonMediaPreview(
            filePath: state.filePath,
          );
        }
        return const LessonMediaPreview();
      },
    );
  }
}
