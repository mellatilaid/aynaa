import 'package:atm_app/core/materials/presentation/views/widgets/exam_section_card.dart';
import 'package:atm_app/core/shared_features/exams/domain/entities/exam_sections_entity.dart';
import 'package:flutter/material.dart';

class ExamSectionsListView extends StatelessWidget {
  final List<ExamSectionsEntity> sections;
  const ExamSectionsListView({super.key, required this.sections});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: sections.length,
        itemBuilder: (context, index) {
          return ExamSectionCard(
            item: sections[index],
          );
        });
  }
}
