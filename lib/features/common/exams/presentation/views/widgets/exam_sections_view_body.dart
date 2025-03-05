import 'package:atm_app/core/services/local_db_service/i_local_db_service.dart';
import 'package:atm_app/core/utils/set_up_service_locator.dart';
import 'package:atm_app/core/widgets/loading_widget.dart';
import 'package:atm_app/features/common/exams/domain/entities/exam_entity.dart';
import 'package:atm_app/features/common/exams/domain/entities/exam_sections_entity.dart';
import 'package:atm_app/features/common/exams/presentation/manager/fetch_exam_sections_cubit/fetch_exam_sections_cubit.dart';
import 'package:atm_app/features/common/exams/presentation/views/widgets/exam_sections_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExamSectionsViewBody extends StatefulWidget {
  final ExamEntity examEntity;
  const ExamSectionsViewBody({super.key, required this.examEntity});

  @override
  State<ExamSectionsViewBody> createState() => _ExamSectionsViewBodyState();
}

class _ExamSectionsViewBodyState extends State<ExamSectionsViewBody> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (0 == 10) {
      getit.get<ILocalDbService>().clear<ExamSectionsEntity>();
    } else {
      BlocProvider.of<FetchExamSectionsCubit>(context)
          .fetchExamSections(id: widget.examEntity.entityID);
    }
  }

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
