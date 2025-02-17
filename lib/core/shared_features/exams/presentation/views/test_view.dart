import 'package:atm_app/core/shared_features/exams/domain/entities/exam_sections_entity.dart';
import 'package:atm_app/core/shared_features/exams/domain/repos/question_repo.dart';
import 'package:atm_app/core/shared_features/exams/presentation/manager/add_questions_cubit/add_questions_cubit.dart';
import 'package:atm_app/core/shared_features/exams/presentation/views/widgets/add_question_dialog.dart';
import 'package:atm_app/core/utils/set_up_service_locator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'widgets/test_view_body.dart';

class TestView extends StatelessWidget {
  final ExamSectionsEntity examSectionsEntity;
  const TestView({super.key, required this.examSectionsEntity});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
      ),
      body: const TestViewBody(),
      floatingActionButton: Builder(
        builder: (fabContext) {
          return FloatingActionButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
            onPressed: () {
              showGeneralDialog(
                context: context,
                barrierDismissible: true,
                barrierLabel: "Full Screen Dialog",
                pageBuilder: (context, animation, secondaryAnimation) {
                  return Provider<AddQuestionsCubit>(
                    create: (context) => AddQuestionsCubit(
                        questionRepo: getit.get<QuestionRepo>()),
                    child: AddQuestionsDialog(
                      examSectionsEntity: examSectionsEntity,
                    ),
                  );
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
              );
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
