import 'package:atm_app/core/shared_features/exams/domain/entities/exam_entity.dart';
import 'package:atm_app/core/shared_features/exams/presentation/views/widgets/add_section_bottom_sheet.dart';
import 'package:atm_app/core/shared_features/exams/presentation/views/widgets/exam_sections_view_body.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ExamSectionsView extends StatelessWidget {
  final ExamEntity examEntity;
  const ExamSectionsView({super.key, required this.examEntity});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
      ),
      body: const ExamSectionsViewBody(),
      floatingActionButton: Builder(
        builder: (fabContext) {
          return FloatingActionButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
            onPressed: () {
              showModalBottomSheet(
                  isScrollControlled: true,
                  context: context,
                  builder: (context) {
                    return Provider<ExamEntity>(
                      create: (context) => examEntity,
                      child: const AddExamSectionBottomSheet(),
                    );
                    return const AddExamSectionBottomSheet();
                  });
              /*showDialog(
                  context: context,
                  builder: (context) {
                    return BlocProvider.value(
                      value: aynaaVersionCubit,
                      child: const AddAynaaVersionAlertDialog(),
                    );
                  });*/
            },
            child: const Icon(Icons.add),
          );
        },
      ),
    );
  }
}


/* showGeneralDialog(
                context: context,
                barrierDismissible: true,
                barrierLabel: "Full Screen Dialog",
                pageBuilder: (context, animation, secondaryAnimation) {
                  return const FullScreenDialog();
                },
                transitionBuilder:
                    (context, animation, secondaryAnimation, child) {
                  return SlideTransition(
                    position: Tween<Offset>(
                            begin: const Offset(0, 1), end: const Offset(0, 0))
                        .animate(animation),
                    child: child,
                  );
                },
              );*/