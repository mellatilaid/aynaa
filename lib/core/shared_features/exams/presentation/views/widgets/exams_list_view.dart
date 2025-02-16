import 'package:atm_app/core/materials/presentation/views/widgets/custom_subject_card.dart';
import 'package:flutter/material.dart';

import '../../../domain/entities/exam_entity.dart';

class ExamsListView extends StatelessWidget {
  final List<ExamEntity> exams;
  const ExamsListView({super.key, required this.exams});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: exams.length,
        itemBuilder: (context, index) {
          return CustomSubjectCard(item: exams[index]);
        });
  }
}
