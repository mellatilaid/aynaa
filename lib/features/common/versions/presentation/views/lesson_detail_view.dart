import 'package:atm_app/features/common/versions/domain/entities/lesson_entity.dart';
import 'package:flutter/material.dart';

import 'widgets/lesson_detail_view_body.dart';

class LessonDetailView extends StatelessWidget {
  final LessonEntity lesson;
  const LessonDetailView({super.key, required this.lesson});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(lesson.name),
      ),
      body: LessonDetailViewBody(
        lesson: lesson,
      ),
    );
  }
}
