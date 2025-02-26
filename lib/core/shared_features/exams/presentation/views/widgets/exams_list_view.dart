import 'package:atm_app/core/materials/presentation/views/widgets/custom_subject_card.dart';
import 'package:atm_app/core/utils/app_route.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../domain/entities/exam_entity.dart';

class ExamsListView extends StatelessWidget {
  final List<ExamEntity> exams;
  const ExamsListView({super.key, required this.exams});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: exams.length,
        itemBuilder: (context, index) {
          return CustomSubjectCard(
            onTap: () => context.push(
              extra: exams[index],
              AppRouter.examSectionsView,
            ),
            onDelete: () {},
            onEdit: () {},
            item: exams[index],
          );
        });
  }
}
