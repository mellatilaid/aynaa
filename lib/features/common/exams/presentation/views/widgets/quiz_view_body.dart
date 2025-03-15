import 'package:atm_app/core/const/remote_db_const.dart';
import 'package:atm_app/core/services/local_db_service/i_local_db_service.dart';
import 'package:atm_app/core/services/profile_storage.dart';
import 'package:atm_app/core/utils/set_up_service_locator.dart';
import 'package:atm_app/core/widgets/empty_widget.dart';
import 'package:atm_app/core/widgets/loading_widget.dart';
import 'package:atm_app/features/common/exams/domain/entities/question_entity.dart';
import 'package:atm_app/features/common/exams/presentation/manager/fethc_questions_cubit/fetch_questions_cubit.dart';
import 'package:atm_app/features/common/exams/presentation/views/widgets/one_choice_quize.dart';
import 'package:atm_app/features/common/exams/presentation/views/widgets/question_list_view.dart';
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
    if (0 == 01) {
      getit.get<ILocalDbService>().clear<QuestionEntity>();
    } else {
      BlocProvider.of<FetchQuestionsCubit>(context)
          .fetchQuestions(id: widget.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FetchQuestionsCubit, FetchQuestionsState>(
      builder: (context, state) {
        if (state is FetchQuestionsSuccuss) {
          if (state.questions.isEmpty) {
            return const EmptyWidget();
          }
          if (ProfileStorageImpl.userRole == kAdminRole) {
            return QuestionsListView(questions: state.questions);
          }
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
