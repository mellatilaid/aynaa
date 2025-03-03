import 'dart:developer';

import 'package:atm_app/core/functions/custom_alert_dialog.dart';
import 'package:atm_app/core/materials/presentation/views/widgets/exam_section_card.dart';
import 'package:atm_app/core/shared_features/exams/data/data_source/exam_sections_data_source/exam_sections_local_data_source.dart';
import 'package:atm_app/core/shared_features/exams/domain/entities/exam_sections_entity.dart';
import 'package:atm_app/core/shared_features/exams/presentation/manager/exam_section_cubit/exam_section_cubit.dart';
import 'package:atm_app/core/utils/app_route.dart';
import 'package:atm_app/core/utils/set_up_service_locator.dart';
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
  @override
  void initState() {
    super.initState();
    if (widget.sections.isNotEmpty) {
      widget.sections[0].isLocked = false;
    }
  }

  void _unlockNextSection(int completedIndex, int score, int total) {
    customAlertDialog(
      context: context,
      title: const Text("نتيجتك النهائية"),
      content: Text("مجموعك: $score/$total "),
      popButtonTitle: 'حسنًا',
    );

    setState(() {
      if (completedIndex < widget.sections.length - 1) {
        widget.sections[completedIndex + 1].isLocked =
            false; // Unlock next section
      }
    });
    if (completedIndex < widget.sections.length - 1) {
      // Update the score and questions num of the completed section
      final section = widget.sections[completedIndex];
      section.score = score;
      section.totalQuestions = total;
      _updateSectionEntity(section);
      // Unlock the next section
      final nextSection = widget.sections[completedIndex + 1];
      section.isLocked = false;
      _updateSectionEntity(nextSection);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: widget.sections.length,
        itemBuilder: (context, index) {
          log('section $index is locked: ${widget.sections[index].isLocked}');
          log('section $index score: ${widget.sections[index].score}');
          return ExamSectionCard(
            onTap: () async {
              final resault = await context.push<List<int>>(
                AppRouter.testView,
                extra: widget.sections[index],
              );

              if (resault != null) {
                _unlockNextSection(index, resault[0], resault[1]);
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

  //update the cached section entity
  _updateSectionEntity(ExamSectionsEntity sectionEntity) async {
    getit.get<ExamSectionsLocalDataSource>().updateCachedSection(
          section: sectionEntity,
        );
  }
}
