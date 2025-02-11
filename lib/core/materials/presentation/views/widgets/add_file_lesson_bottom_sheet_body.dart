import 'package:atm_app/core/materials/presentation/views/widgets/lesson_media_content_builder.dart';
import 'package:atm_app/core/materials/presentation/views/widgets/upload_lesson_media_button_section.dart';
import 'package:atm_app/features/admin/materials/presentation/manager/add_file_lesson_cubit/add_file_lesson_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/widgets/invisibla_text_field.dart';

class AddFileLessonBottomSheetBody extends StatefulWidget {
  const AddFileLessonBottomSheetBody({
    super.key,
  });

  @override
  State<AddFileLessonBottomSheetBody> createState() =>
      _AddFileLessonBottomSheetBodyState();
}

class _AddFileLessonBottomSheetBodyState
    extends State<AddFileLessonBottomSheetBody> {
  final _lessonTitleController = TextEditingController();
  String? selectedFile;
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _lessonTitleController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Scrollable content
        Padding(
          padding: const EdgeInsets.only(bottom: 60.0),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    LessonMediaContentBuilder(
                      filePath: selectedFile,
                    ),
                    const SizedBox(height: 16),
                    InvisibleTextField(
                      controller: _lessonTitleController,
                      hintText: 'محتوى الدرس',
                      maxLines: 6,
                    ),
                    const SizedBox(height: 16),
                    const UploadFileProgressIndicatorBuilder(),
                  ],
                ),
              ),
            ),
          ),
        ),
        // Fixed button at the bottom
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: UplaodLessonMediaButtonBlocBuilder(
              lessonContent: _lessonTitleController,
            ),
          ),
        ),
      ],
    );
  }
}

class UploadFileProgressIndicatorBuilder extends StatelessWidget {
  const UploadFileProgressIndicatorBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddFileLessonCubit, AddFileLessonState>(
      builder: (context, state) {
        if (state is AddFileLessonLoading) {
          return UploadProgressWidget(
            progress: state.progress,
            estimate: state.estimate,
          );
        }
        return Container();
      },
    );
  }
}

class UploadProgressWidget extends StatelessWidget {
  final double progress;
  final Duration estimate;

  const UploadProgressWidget({
    super.key,
    required this.progress,
    required this.estimate,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text(
          "Uploading File...",
          style: TextStyle(fontSize: 18),
        ),
        const SizedBox(height: 20),
        LinearProgressIndicator(value: progress),
        const SizedBox(height: 10),
        Text("Progress: ${(progress * 100).toStringAsFixed(1)}%"),
        const SizedBox(height: 10),
        Text("Estimated time remaining: ${estimate.inSeconds}s"),
      ],
    );
  }
}
