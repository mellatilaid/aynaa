import 'package:atm_app/features/admin/materials/domain/entities/lesson_entity.dart';
import 'package:flutter/material.dart';

import '../../../../../../core/widgets/custom_item_card_type_2.dart';

class LessonsListView extends StatelessWidget {
  final List<LessonEntity> lessons;
  const LessonsListView({super.key, required this.lessons});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: lessons.length,
      itemBuilder: (context, index) {
        return CustomItemCardType2(
          item: lessons[index],
        );
        //return CustomCard(entity: lessons[index]);
      },
    );
  }
}
