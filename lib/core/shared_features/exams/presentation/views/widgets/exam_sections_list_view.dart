import 'package:atm_app/core/functions/custom_alert_dialog.dart';
import 'package:atm_app/core/materials/presentation/views/widgets/exam_section_card.dart';
import 'package:atm_app/core/shared_features/exams/domain/entities/exam_sections_entity.dart';
import 'package:atm_app/core/shared_features/exams/presentation/manager/exam_section_cubit/exam_section_cubit.dart';
import 'package:atm_app/core/utils/app_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ExamSectionsListView extends StatefulWidget {
  final List<ExamSectionsEntity> sections;
  const ExamSectionsListView({super.key, required this.sections});

  @override
  State<ExamSectionsListView> createState() => _ExamSectionsListViewState();
}

class _ExamSectionsListViewState extends State<ExamSectionsListView> {
  Map<int, int> scores = {};
  @override
  void initState() {
    super.initState();
    if (widget.sections.isNotEmpty) {
      widget.sections[0].isLocked = false;
    }
  }

  void _unlockNextSection(int completedIndex, int score) {
    setState(() {
      scores[completedIndex] = score; // Save the score

      if (completedIndex < widget.sections.length - 1) {
        widget.sections[completedIndex + 1].isLocked =
            false; // Unlock next section
      } else {
        _showFinalScore();
      }
    });
  }

  void _showFinalScore() {
    int totalScore = scores.values.fold(0, (sum, score) => sum + score);
    int maxScore =
        widget.sections.length * 100; // Assuming each quiz is out of 100

    customAlertDialog(
      context: context,
      title: const Text("نتيجتك النهائية"),
      content: Text("مجموعك: $totalScore / $maxScore"),
      popButtonTitle: 'حسنًا',
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: widget.sections.length,
        itemBuilder: (context, index) {
          return ExamSectionCard(
            onTap: () async {
              final sectionScore = await context.push<int>(
                AppRouter.testView,
                extra: widget.sections[index],
              );

              if (sectionScore != null) {
                _unlockNextSection(index, sectionScore);
              }
            },
            onDelete: () =>
                BlocProvider.of<ExamSectionCubit>(context).deleteExamSection(
              examSection: widget.sections[index],
            ),
            onEdit: () {},
            item: widget.sections[index],
          );
        });
  }
}
