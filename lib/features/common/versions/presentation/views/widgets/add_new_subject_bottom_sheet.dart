import 'package:atm_app/core/const/local_db_const.dart';
import 'package:atm_app/core/utils/set_up_service_locator.dart';
import 'package:atm_app/core/widgets/scaffold_message.dart';
import 'package:atm_app/features/common/versions/domain/entities/subjects_entity.dart';
import 'package:atm_app/features/common/versions/domain/repos/subjects_repo.dart';
import 'package:atm_app/features/common/versions/presentation/manager/add_text_lesson_cubit/lesson_cubit.dart';
import 'package:atm_app/features/common/versions/presentation/manager/fetch_subjects_cubit/fetch_subject_cubit.dart';
import 'package:atm_app/features/common/versions/presentation/manager/pick_file_cubit/pick_file_cubit.dart';
import 'package:atm_app/features/common/versions/presentation/manager/subject_cubit/subject_cubit.dart';
import 'package:atm_app/features/common/versions/presentation/views/widgets/add_new_subject_bottom_sheet_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../../core/classes/pick_file.dart';

class NewSubjectBottomSheet extends StatelessWidget {
  final bool isEditMode;
  final SubjectsEntity? subjectsEntity;
  final FetchSubjectCubit fetchSubjectsCubit;
  const NewSubjectBottomSheet({
    super.key,
    this.isEditMode = false,
    this.subjectsEntity,
    required this.fetchSubjectsCubit,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              SubjectCubit(subjectsRepo: getit.get<SubjectsRepo>()),
        ),
        BlocProvider(
          create: (context) => PickFileCubit(getit.get<FilePickerHelper>()),
        ),
      ],
      child: BlocBuilder<SubjectCubit, SubjectState>(
        builder: (context, state) {
          if (state is SubjectSuccuss) {
            final versionID = context.read<LessonCubit>().versionID;

            fetchSubjectsCubit.fetchSubjects(versionID: state.versionID);
            Future.microtask(() {
              if (!context.mounted) return;
              context.pop();
            });
          } else if (state is SubjectFailure) {
            context.pop();
            showScaffoldMessage(context, state.errMessage);
          } else if (state is NoInternetState) {
            context.pop();
            showScaffoldMessage(context, kNoInternetMessage);
          }
          return (isEditMode)
              ? AddSubjectBottomSheetBody.edit(subject: subjectsEntity!)
              : const AddSubjectBottomSheetBody();
        },
      ),
    );
  }
}
