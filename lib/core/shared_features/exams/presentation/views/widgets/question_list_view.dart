import 'package:atm_app/core/functions/show_full_screen_dialog.dart';
import 'package:atm_app/core/shared_features/exams/domain/entities/question_entity.dart';
import 'package:atm_app/core/shared_features/exams/presentation/manager/add_questions_cubit/questions_cubit.dart';
import 'package:atm_app/core/shared_features/exams/presentation/manager/fethc_questions_cubit/fetch_questions_cubit.dart';
import 'package:atm_app/core/shared_features/exams/presentation/views/widgets/add_question_dialog.dart';
import 'package:atm_app/core/shared_features/exams/presentation/views/widgets/custom_question_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class QuestionsListView extends StatelessWidget {
  final List<QuestionEntity> questions;
  const QuestionsListView({
    super.key,
    required this.questions,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: questions.length,
      itemBuilder: (context, idnex) {
        return QuestionCard(
          question: questions[idnex],
          onDelete: () => BlocProvider.of<QuestionsCubit>(context)
              .deleteQuestion(question: questions[idnex]),
          onEdit: () {
            fullScreenDialog(
              context,
              child: Provider.value(
                value: BlocProvider.of<FetchQuestionsCubit>(context),
                child: Provider.value(
                  value: BlocProvider.of<QuestionsCubit>(context),
                  child: AddQuestionsDialog.edit(
                    questionEntity: questions[idnex],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
