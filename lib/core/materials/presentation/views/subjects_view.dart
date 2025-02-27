import 'package:atm_app/core/const/app_const.dart';
import 'package:atm_app/core/helper/user_profile.dart';
import 'package:atm_app/core/materials/domain/entities/aynaa_versions_entity.dart';
import 'package:atm_app/core/materials/domain/repos/subjects_repo.dart';
import 'package:atm_app/core/services/local_db_service/i_local_db_service.dart';
import 'package:atm_app/core/shared_features/exams/domain/repos/exams_repo.dart';
import 'package:atm_app/core/shared_features/exams/presentation/manager/add_exam_cubit/exam_cubit.dart';
import 'package:atm_app/core/shared_features/exams/presentation/manager/fetch_exams_cubit/fetch_exams_cubit.dart';
import 'package:atm_app/core/shared_features/exams/presentation/views/widgets/add_exam_bottom_sheet.dart';
import 'package:atm_app/core/utils/set_up_service_locator.dart';
import 'package:atm_app/core/widgets/custom_speed_dial_child.dart';
import 'package:atm_app/features/admin/materials/presentation/manager/delete_subject_cubit/delete_subject_cubit.dart';
import 'package:atm_app/features/admin/materials/presentation/manager/fetch_subjects_cubit/fetch_subject_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../const/remote_db_const.dart';
import '../../../shared_features/exams/presentation/views/widgets/exams_view_body.dart';
import '../../../widgets/floating_optional_speed_dial.dart';
import 'widgets/add_new_subject_bottom_sheet.dart';
import 'widgets/subject_view_body.dart';

class SubjectsView extends StatelessWidget {
  final AynaaVersionsEntity aynaaVersionsEntity;
  const SubjectsView({super.key, required this.aynaaVersionsEntity});
//FetchSubjectCubit(getit.get<SubjectsRepo>()),
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => FetchSubjectCubit(
            getit.get<SubjectsRepo>(),
            getit.get<ILocalDbService>(),
          ),
        ),
        BlocProvider(
          create: (context) => FetchExamsCubit(
            examsRepo: getit.get<ExamsRepo>(),
            iLocalDbService: getit.get<ILocalDbService>(),
          ),
        ),
        BlocProvider(
          create: (context) =>
              DeleteSubjectCubit(subjectsRepo: getit.get<SubjectsRepo>()),
        ),
        BlocProvider(
          create: (context) => ExamCubit(
            examsRepo: getit.get<ExamsRepo>(),
            // iLocalDbService: getit.get<ILocalDbService>(),
          ),
        ),
      ],
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(aynaaVersionsEntity.versionName.toString()),
            bottom: const TabBar(
              labelColor: kPrimaryColor,
              tabs: [
                Tab(text: "المواد"),
                Tab(text: "الامتحانات"),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              SubjectsViewBody(
                versionsEntity: aynaaVersionsEntity,
              ),
              ExamsViewBody(
                versionsEntity: aynaaVersionsEntity,
              ),
            ],
          ),
          floatingActionButton: (globalUserRole != null &&
                  globalUserRole == kAdminRole)
              ? Builder(builder: (fabContext) {
                  return FloatingAddOptionsSpeedDial(
                    speedDials: [
                      customSpeedDialChild(
                        onTap: () {
                          final subjectsCubit =
                              fabContext.read<FetchSubjectCubit>();
                          showModalBottomSheet(
                              isScrollControlled: true,
                              context: context,
                              builder: (context) {
                                return BlocProvider.value(
                                  value: subjectsCubit,
                                  child: NewSubjectBottomSheet(
                                    fetchSubjectsCubit: subjectsCubit,
                                  ),
                                );
                              });
                        },
                        icon: const Icon(Icons.text_fields),
                        label: 'أضف مادة',
                      ),
                      customSpeedDialChild(
                        onTap: () {
                          final examsCubit = fabContext.read<FetchExamsCubit>();
                          showModalBottomSheet(
                              isScrollControlled: true,
                              context: context,
                              builder: (context) {
                                return BlocProvider.value(
                                  value: examsCubit,
                                  child: const AddExamBottomSheet(),
                                );
                              });
                        },
                        icon: const FaIcon(FontAwesomeIcons.tents),
                        label: 'أضف إمتحان',
                      ),
                    ],
                  );
                })
              : null,
        ),
      ),
    );
  }
}

/*  return FloatingActionButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                        onPressed: () {
                          final subjectsCubit =
                              fabContext.read<FetchSubjectCubit>();
                          showModalBottomSheet(
                              isScrollControlled: true,
                              context: context,
                              builder: (context) {
                                return BlocProvider.value(
                                  value: subjectsCubit,
                                  child: const NewSubjectBottomSheet(),
                                );
                              });
                        },
                        child: const Icon(Icons.add),
                      );*/
