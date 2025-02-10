import 'dart:io';

import 'package:atm_app/core/widgets/custom_image_frame.dart';
import 'package:atm_app/features/admin/materials/domain/entities/lesson_entity.dart';
import 'package:atm_app/features/admin/materials/presentation/views/widgets/lesson_text_widget.dart';
import 'package:flutter/material.dart';

class LessonView extends StatelessWidget {
  final LessonEntity lesson;
  const LessonView({super.key, required this.lesson});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Lesson Title'),
      ),
      body: LessonViewBody(
        lesson: lesson,
      ),
    );
  }
}

class LessonViewBody extends StatelessWidget {
  final LessonEntity lesson;
  const LessonViewBody({super.key, required this.lesson});

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
            LessonTextWidget(lessonText: lesson.description!),
          ],
        ),
      ),
    );
  }
}
