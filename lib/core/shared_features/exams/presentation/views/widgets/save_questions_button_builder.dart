import 'package:atm_app/core/shared_features/exams/presentation/manager/add_questions_cubit/add_questions_cubit.dart';
import 'package:atm_app/core/widgets/custom_text_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SaveQuestionsButtonBuilder extends StatelessWidget {
  const SaveQuestionsButtonBuilder({
    super.key,
    required this.onSave,
  });

  final VoidCallback onSave;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddQuestionsCubit, AddQuestionsState>(
      builder: (context, state) {
        if (state is AddQuestionsSuccuss) {
          context.pop();
        }
        return CustomTextButton(
          isLoading: state is AddQuestionsLoading ? true : false,
          title: 'حفظ',
          onPressed: onSave,
        );
      },
    );
  }
}
