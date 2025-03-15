import 'package:atm_app/core/widgets/custom_text_button.dart';
import 'package:atm_app/features/common/exams/presentation/manager/add_questions_cubit/questions_cubit.dart';
import 'package:atm_app/features/common/exams/presentation/manager/fethc_questions_cubit/fetch_questions_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class SaveQuestionsButtonBuilder extends StatelessWidget {
  final bool isEditMode;
  const SaveQuestionsButtonBuilder({
    super.key,
    required this.isEditMode,
    required this.onSave,
  });

  final VoidCallback onSave;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QuestionsCubit, QuestionsState>(
      builder: (context, state) {
        if (state is QuestionsSuccuss) {
          Provider.of<FetchQuestionsCubit>(context)
              .fetchQuestions(id: state.questionID);
          Provider.of<QuestionsCubit>(context).resetState();
          context.pop();
        }
        return CustomTextButton(
          isLoading: state is QuestionsLoading ? true : false,
          title: isEditMode ? 'تحديث' : 'حفظ',
          onPressed: onSave,
        );
      },
    );
  }
}
