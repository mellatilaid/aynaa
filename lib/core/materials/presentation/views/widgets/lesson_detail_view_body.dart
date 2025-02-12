import 'dart:io';

import 'package:flutter/material.dart';

import '../../../../widgets/custom_image_frame.dart';
import '../../../domain/entities/lesson_entity.dart';
import 'lesson_text_widget.dart';

class LessonDetailViewBody extends StatelessWidget {
  final LessonEntity lesson;
  const LessonDetailViewBody({super.key, required this.lesson});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            CustomImageFame(
              child: Image.file(
                File(lesson.localFilePath!),
              ),
            ),
            LessonTextWidget(lessonText: lesson.description),
          ],
        ),
      ),
    );
  }
}
