import 'package:atm_app/core/materials/domain/entities/aynaa_versions_entity.dart';
import 'package:atm_app/core/materials/domain/entities/subjects_entity.dart';
import 'package:atm_app/features/admin/materials/presentation/manager/fetch_subjects_cubit/fetch_subject_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/utils/set_up_service_locator.dart';
import '../../../../services/local_db_service/local_d_b_service.dart';
import 'subjects_list_view.dart';

class SubjectsViewBody extends StatefulWidget {
  final AynaaVersionsEntity versionsEntity;
  const SubjectsViewBody({
    super.key,
    required this.versionsEntity,
  });

  @override
  State<SubjectsViewBody> createState() => _SubjectsViewBodyState();
}

class _SubjectsViewBodyState extends State<SubjectsViewBody> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //getit.get<HiveCache<SubjectsEntity>>().clear(boxName: kSubjectsBox);
    if (0 == 0) {
      BlocProvider.of<FetchSubjectCubit>(context)
          .fetchSubjects(versionID: widget.versionsEntity.entityID);
    } else {
      getit.get<LocalDbService>().clear<SubjectsEntity>();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FetchSubjectCubit, FetchSubjectState>(
      builder: (context, state) {
        if (state is FetchSubjectLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is FetchSubjectFailure) {
          return ErrorWidget(state.errMessage);
        } else if (state is FetchSubjectSucuss) {
          return SubjectsListView(subjects: state.subjects);
        } else {
          return Container();
        }
      },
    );
  }
}
