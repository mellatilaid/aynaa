import 'package:atm_app/core/shared_features/exams/presentation/manager/fetch_exams_cubit/fetch_exams_cubit.dart';
import 'package:atm_app/core/shared_features/exams/presentation/views/widgets/exams_list_view.dart';
import 'package:atm_app/core/widgets/loading_widget.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExamsViewBody extends StatefulWidget {
  const ExamsViewBody({super.key});

  @override
  State<ExamsViewBody> createState() => _ExamsViewBodyState();
}

class _ExamsViewBodyState extends State<ExamsViewBody> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<FetchExamsCubit>(context).fetchExams();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FetchExamsCubit, FetchExamsState>(
      builder: (context, state) {
        if (state is FetchExamsSuccuss) {
          return ExamsListView(exams: state.exams);
        } else if (state is FetchExamsLoading) {
          return const LoadingWidget();
        } else if (state is FetchExamsFailure) {
          return ErrorWidget(state.errMessage);
        }
        return Container();
      },
    );
  }
}
