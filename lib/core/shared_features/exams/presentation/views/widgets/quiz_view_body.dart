import 'package:atm_app/core/shared_features/exams/presentation/manager/fethc_questions_cubit/fetch_questions_cubit.dart';
import 'package:atm_app/core/shared_features/exams/presentation/views/widgets/one_choice_quize.dart';
import 'package:atm_app/core/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class QuizViewBody extends StatefulWidget {
  final String id;
  const QuizViewBody({super.key, required this.id});

  @override
  State<QuizViewBody> createState() => _QuizViewBodyState();
}

class _QuizViewBodyState extends State<QuizViewBody> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<FetchQuestionsCubit>(context).fetchQuestions(id: widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FetchQuestionsCubit, FetchQuestionsState>(
      builder: (context, state) {
        if (state is FetchQuestionsSuccuss) {
          return OneChoiceQuize(questions: state.questions);
        } else if (state is FetchQuestionsLoading) {
          return const LoadingWidget();
        } else if (state is FetchQuestionsFailure) {
          return ErrorWidget(state.errMessage);
        }
        return Container();
      },
    );
  }
}
