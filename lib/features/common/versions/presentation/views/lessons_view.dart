import 'package:atm_app/core/services/local_db_service/i_local_db_service.dart';
import 'package:atm_app/core/services/profile_storage.dart';
import 'package:atm_app/core/widgets/floating_optional_speed_dial.dart';
import 'package:atm_app/features/common/versions/domain/entities/subjects_entity.dart';
import 'package:atm_app/features/common/versions/domain/repos/lessons_repo.dart';
import 'package:atm_app/features/common/versions/presentation/manager/add_text_lesson_cubit/lesson_cubit.dart';
import 'package:atm_app/features/common/versions/presentation/manager/fetch_lessons_cubit/fetch_lessons_cubit.dart';
import 'package:atm_app/features/common/versions/presentation/views/widgets/add_text_lesson_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../../../../../../core/utils/set_up_service_locator.dart';
import '../../../../../../core/widgets/custom_speed_dial_child.dart';
import '../../../../../core/const/remote_db_const.dart';
import 'widgets/add_file_lesson_bottom_sheet.dart';
import 'widgets/lessons_view_body.dart';

class LessonsView extends StatelessWidget {
  final SubjectsEntity subjectsEntity;
  const LessonsView({super.key, required this.subjectsEntity});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FetchLessonsCubit(
        lessonsRepo: getit.get<LessonsRepo>(),
        iLocalDbService: getit.get<ILocalDbService>(),
      ),
      child: Scaffold(
        appBar: AppBar(
          leading: const BackButton(),
        ),
        body: LessonsViewBody(
          subjectsEntity: subjectsEntity,
        ),
        floatingActionButton: (ProfileStorageImpl.userRole == kAdminRole)
            ? Builder(builder: (fabContext) {
                fabContext.read<LessonCubit>().resetState();
                return FloatingAddOptionsSpeedDial(
                  speedDials: [
                    customSpeedDialChild(
                      onTap: () {
                        showModalBottomSheet(
                          context: fabContext,
                          isScrollControlled:
                              true, // Allows it to take up the full height
                          shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.vertical(top: Radius.circular(16)),
                          ),
                          builder: (context) {
                            return BlocProvider.value(
                              value: fabContext.read<FetchLessonsCubit>(),
                              child: Provider(
                                create: (context) => subjectsEntity,
                                child: AddTextLessonBottomSheet(
                                  fetchLessonsCubit:
                                      fabContext.read<FetchLessonsCubit>(),
                                  isTextOnly: true,
                                ),
                              ),
                            );
                          },
                        );
                      },
                      icon: const Icon(Icons.text_fields),
                      label: 'نص فقط',
                    ),
                    customSpeedDialChild(
                      onTap: () {
                        showModalBottomSheet(
                          context: fabContext,
                          isScrollControlled:
                              true, // Allows it to take up the full height
                          shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.vertical(top: Radius.circular(16)),
                          ),
                          builder: (context) {
                            return BlocProvider.value(
                              value: fabContext.read<FetchLessonsCubit>(),
                              child: const AddFileLessonBottomSheet(),
                            );
                          },
                        );
                      },
                      icon: const FaIcon(FontAwesomeIcons.file),
                      label: 'أضف ملف',
                    ),
                  ],
                );
                /*  return FloatingActionButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
            child: const Icon(Icons.add),
            onPressed: () {
              fabContext.read<AddLessonCubit>().resetState();
              showModalBottomSheet(
                context: fabContext,
                isScrollControlled:
                    true, // Allows it to take up the full height
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
                builder: (context) {
                  return BlocProvider.value(
                      value: fabContext.read<FetchLessonsCubit>(),
                      child: const AddLessonBottomSheet());
                },
              );
            },
          );*/
              })
            : Container(),
      ),
    );
  }
}
