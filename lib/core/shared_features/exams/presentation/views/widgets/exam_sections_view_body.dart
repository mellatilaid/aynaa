import 'package:atm_app/core/shared_features/exams/presentation/manager/fetch_exam_sections_cubit/fetch_exam_sections_cubit.dart';
import 'package:atm_app/core/shared_features/exams/presentation/views/widgets/exam_sections_list_view.dart';
import 'package:atm_app/core/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExamSectionsViewBody extends StatelessWidget {
  const ExamSectionsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FetchExamSectionsCubit, FetchExamSectionsState>(
      builder: (context, state) {
        if (state is FetchExamSectionsSuccuss) {
          return ExamSectionsListView(sections: state.sections);
        } else if (state is FetchExamSectionsLoading) {
          return const LoadingWidget();
        } else if (state is FetchExamSectionsFailure) {
          return ErrorWidget(state.errMessage);
        }
        return Container();
      },
    );
  }
}
