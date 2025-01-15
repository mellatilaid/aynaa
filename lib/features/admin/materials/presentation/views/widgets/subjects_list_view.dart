import 'package:atm_app/features/admin/materials/presentation/views/widgets/custom_card.dart';
import 'package:flutter/material.dart';

import '../../../domain/entities/subjects_entity.dart';

class SubjectsListView extends StatelessWidget {
  final List<SubjectsEntity> subjects;
  const SubjectsListView({super.key, required this.subjects});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: subjects.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          child: CustomCard(entity: subjects[index]),
        );
      },
    );
  }
}
