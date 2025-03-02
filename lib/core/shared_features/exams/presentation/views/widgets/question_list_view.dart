import 'package:atm_app/core/shared_features/exams/domain/entities/question_entity.dart';
import 'package:atm_app/core/shared_features/exams/presentation/manager/add_questions_cubit/questions_cubit.dart';
import 'package:atm_app/core/shared_features/exams/presentation/views/widgets/custom_question_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
          onEdit: () {},
        );
      },
    );
  }
}
