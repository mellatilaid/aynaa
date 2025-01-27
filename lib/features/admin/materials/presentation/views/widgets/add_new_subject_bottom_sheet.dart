import 'package:atm_app/core/utils/set_up_service_locator.dart';
import 'package:atm_app/core/widgets/scaffold_message.dart';
import 'package:atm_app/features/admin/materials/presentation/manager/add_new_subject_cubit/add_new_subject_cubit.dart';
import 'package:atm_app/features/admin/materials/presentation/manager/fetch_subjects_cubit/fetch_subject_cubit.dart';
import 'package:atm_app/features/admin/materials/presentation/views/widgets/add_new_subject_bottom_sheet_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../domain/repos/subjects_repo.dart';
import '../../manager/add_text_lesson_cubit/add_lesson_cubit.dart';

class NewSubjectBottomSheet extends StatelessWidget {
  const NewSubjectBottomSheet({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          AddNewSubjectCubit(subjectsRepo: getit.get<SubjectsRepo>()),
      child: BlocBuilder<AddNewSubjectCubit, AddNewSubjectState>(
        builder: (context, state) {
          if (state is AddNewSubjectSuccuss) {
            final versionID = context.read<AddLessonCubit>().versionID;
            BlocProvider.of<FetchSubjectCubit>(context)
                .fetchSubjects(versionID: versionID!);
            Future.microtask(() {
              if (!context.mounted) return;
              context.pop();
            });
          } else if (state is AddNewSubjectFailure) {
            showScaffoldMessage(context, state.errMessage);
          }
          return const AddImageNoteBottomSheetBody();
        },
      ),
    );
  }
}
