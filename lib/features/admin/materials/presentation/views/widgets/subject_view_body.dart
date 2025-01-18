import 'package:atm_app/features/admin/materials/domain/entities/aynaa_versions_entity.dart';
import 'package:atm_app/features/admin/materials/presentation/manager/fetch_subjects_cubit/fetch_subject_cubit.dart';
import 'package:atm_app/features/admin/materials/presentation/views/widgets/subjects_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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

    BlocProvider.of<FetchSubjectCubit>(context)
        .fetchSubjects(versionID: widget.versionsEntity.id);
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
