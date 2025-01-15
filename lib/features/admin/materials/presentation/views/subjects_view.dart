import 'package:atm_app/core/utils/set_up_service_locator.dart';
import 'package:atm_app/features/admin/materials/domain/entities/aynaa_versions_entity.dart';
import 'package:atm_app/features/admin/materials/domain/repos/subjects_repo.dart';
import 'package:atm_app/features/admin/materials/presentation/manager/fetch_subjects_cubit/fetch_subject_cubit.dart';
import 'package:atm_app/features/admin/materials/presentation/views/widgets/add_new_subject_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'widgets/subject_view_body.dart';

class SubjectsView extends StatelessWidget {
  final AynaaVersionsEntity aynaaVersionsEntity;
  const SubjectsView({super.key, required this.aynaaVersionsEntity});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FetchSubjectCubit(getit.get<SubjectsRepo>()),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(aynaaVersionsEntity.versionName.toString()),
        ),
        body: const SubjectsViewBody(),
        floatingActionButton: Builder(builder: (fabContext) {
          return FloatingActionButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
            onPressed: () {
              final subjectsCubit = fabContext.read<FetchSubjectCubit>();
              showModalBottomSheet(
                  isScrollControlled: true,
                  context: context,
                  builder: (context) {
                    return BlocProvider.value(
                        value: subjectsCubit,
                        child: const NewSubjectBottomSheet());
                  });
            },
            child: const Icon(Icons.add),
          );
        }),
      ),
    );
  }
}
