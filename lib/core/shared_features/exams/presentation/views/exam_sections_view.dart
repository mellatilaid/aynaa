import 'package:atm_app/core/shared_features/exams/presentation/views/widgets/exam_sections_view_body.dart';
import 'package:flutter/material.dart';

class ExamSectionsView extends StatelessWidget {
  const ExamSectionsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
      ),
      body: const ExamSectionsViewBody(),
    );
  }
}
