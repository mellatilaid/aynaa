import 'package:atm_app/features/admin/materials/domain/entities/lesson_entity.dart';
import 'package:atm_app/features/admin/materials/presentation/views/widgets/Custom_lesson_preview_card.dart';
import 'package:flutter/material.dart';

class LessonsListView extends StatelessWidget {
  final List<LessonEntity> lessons;
  const LessonsListView({super.key, required this.lessons});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: lessons.length,
      itemBuilder: (context, index) {
        return CustomLessonPreviewCard(
          lesson: lessons[index],
        );
        //return CustomCard(entity: lessons[index]);
      },
    );
  }
}
