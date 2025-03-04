import 'package:atm_app/features/admin/materials/presentation/manager/pick_file_cubit/pick_file_cubit.dart';
import 'package:cross_file/cross_file.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'widgets/lesson_media_preview.dart';

class ImageContentBuilder extends StatelessWidget {
  final String? filePath;
  final ValueChanged<String?> onImageChanged;
  const ImageContentBuilder({
    super.key,
    required this.filePath,
    required this.onImageChanged,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PickFileCubit, PickFileState>(
      listener: (context, state) {
        if (state is PickFileLoaded) {
          onImageChanged(state.filePath.path);
          /*    BlocProvider.of<AddNewSubjectCubit>(context)
              .setFilePath(state.filePath.path);*/
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
        return LessonMediaPreview(
          filePath: (filePath != null) ? XFile(filePath!) : null,
        );
      },
    );
  }
}

/*class SubjectImageContentBuilderCopy extends StatelessWidget {
  const SubjectImageContentBuilderCopy({
    super.key,
    required this.filePath,
    required this.onImageChanged,
  });

  final String? filePath;
  final ValueChanged<String?> onImageChanged;

  void _handleImageSelection() async {
    final file = BlocProvider.of<PickFileCubit>(context).pickFile(
      fileType: FileType.image,
    );
    if (file != null) {
      onImageChanged(file.path);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleImageSelection,
      child: CircleAvatar(
        radius: 50,
        backgroundImage: filePath != null ? FileImage(File(filePath!)) : null,
        child:
            filePath == null ? const Icon(Icons.add_a_photo, size: 30) : null,
      ),
    );
  }
}*/
