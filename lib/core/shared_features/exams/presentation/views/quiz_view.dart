import 'package:atm_app/core/services/local_db_service/i_local_db_service.dart';
import 'package:atm_app/core/shared_features/exams/domain/entities/exam_sections_entity.dart';
import 'package:atm_app/core/shared_features/exams/domain/repos/question_repo.dart';
import 'package:atm_app/core/shared_features/exams/presentation/manager/add_questions_cubit/questions_cubit.dart';
import 'package:atm_app/core/shared_features/exams/presentation/manager/fethc_questions_cubit/fetch_questions_cubit.dart';
import 'package:atm_app/core/shared_features/exams/presentation/views/widgets/add_question_dialog.dart';
import 'package:atm_app/core/shared_features/exams/presentation/views/widgets/quiz_view_body.dart';
import 'package:atm_app/core/utils/set_up_service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class QuizView extends StatelessWidget {
  final ExamSectionsEntity examSectionsEntity;
  const QuizView({super.key, required this.examSectionsEntity});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => FetchQuestionsCubit(
            questionsRepo: getit.get<QuestionRepo>(),
            iLocalDbService: getit.get<ILocalDbService>(),
          ),
        ),
        BlocProvider(
          create: (context) =>
              QuestionsCubit(questionRepo: getit.get<QuestionRepo>()),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          leading: const BackButton(),
        ),
        body: QuizViewBody(
          id: examSectionsEntity.entityID,
        ),
        floatingActionButton: Builder(
          builder: (fabContext) {
            return FloatingActionButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
              onPressed: () {
                final fetchQuestionsCubit =
                    fabContext.read<FetchQuestionsCubit>();
                showGeneralDialog(
                  context: context,
                  barrierDismissible: true,
                  barrierLabel: "Full Screen Dialog",
                  pageBuilder: (context, animation, secondaryAnimation) {
                    return Provider<QuestionsCubit>(
                      create: (context) => QuestionsCubit(
                          questionRepo: getit.get<QuestionRepo>()),
                      child: Provider.value(
                        value: fetchQuestionsCubit,
                        child: AddQuestionsDialog(
                          examSectionsEntity: examSectionsEntity,
                        ),
                      ),
                    );
                  },
                  transitionBuilder:
                      (context, animation, secondaryAnimation, child) {
                    return SlideTransition(
                      position: Tween<Offset>(
                              begin: const Offset(0, 1),
                              end: const Offset(0, 0))
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
