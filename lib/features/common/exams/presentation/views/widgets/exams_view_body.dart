import 'dart:developer';

import 'package:atm_app/core/services/local_db_service/i_local_db_service.dart';
import 'package:atm_app/core/utils/set_up_service_locator.dart';
import 'package:atm_app/core/widgets/empty_widget.dart';
import 'package:atm_app/core/widgets/failure_message_widget.dart';
import 'package:atm_app/core/widgets/loading_widget.dart';
import 'package:atm_app/features/common/exams/domain/entities/exam_entity.dart';
import 'package:atm_app/features/common/exams/presentation/manager/fetch_exams_cubit/fetch_exams_cubit.dart';
import 'package:atm_app/features/common/exams/presentation/views/widgets/exams_list_view.dart';
import 'package:atm_app/features/common/versions/domain/entities/aynaa_versions_entity.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExamsViewBody extends StatefulWidget {
  final AynaaVersionsEntity versionsEntity;
  const ExamsViewBody({super.key, required this.versionsEntity});

  @override
  State<ExamsViewBody> createState() => _ExamsViewBodyState();
}

class _ExamsViewBodyState extends State<ExamsViewBody> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    log('version id is ${widget.versionsEntity.entityID}');
    if (0 == 0) {
      BlocProvider.of<FetchExamsCubit>(context)
          .fetchExams(versionID: widget.versionsEntity.entityID);
    } else {
      getit.get<ILocalDbService>().clear<ExamEntity>();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FetchExamsCubit, FetchExamsState>(
      builder: (context, state) {
        if (state is FetchExamsSuccuss) {
          if (state.exams.isEmpty) {
            return const EmptyWidget();
          }
          return ExamsListView(exams: state.exams);
        } else if (state is FetchExamsLoading) {
          return const LoadingWidget();
        } else if (state is FetchExamsFailure) {
          return FailureMessageWidget(message: state.errMessage);
        }
        return Container();
      },
    );
  }
}
