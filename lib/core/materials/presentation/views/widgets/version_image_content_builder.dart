import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../features/admin/materials/presentation/manager/creata_new_aynaa_version_cubit/create_new_aynaa_version_cubit.dart';
import '../../../../../features/admin/materials/presentation/manager/pick_file_cubit/pick_file_cubit.dart';
import 'lesson_media_preview.dart';

class VersionImageContentBuilder extends StatelessWidget {
  final String? filePath;
  const VersionImageContentBuilder({
    super.key,
    required this.filePath,
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
          return LessonMediaPreview(
            filePath: state.filePath,
          );
        }
        return const LessonMediaPreview();
      },
    );
  }
}
