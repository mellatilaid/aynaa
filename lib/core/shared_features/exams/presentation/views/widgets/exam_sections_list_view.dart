import 'package:atm_app/core/materials/presentation/views/widgets/exam_section_card.dart';
import 'package:atm_app/core/shared_features/exams/domain/entities/exam_sections_entity.dart';
import 'package:atm_app/core/utils/app_route.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ExamSectionsListView extends StatelessWidget {
  final List<ExamSectionsEntity> sections;
  const ExamSectionsListView({super.key, required this.sections});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: sections.length,
        itemBuilder: (context, index) {
          return ExamSectionCard(
            onTap: () => context.push(
              AppRouter.testView,
              extra: sections[index],
            ),
            item: sections[index],
          );
        });
  }
}
