import 'package:atm_app/core/shared_features/exams/domain/repos/exams_repo.dart';
import 'package:atm_app/core/shared_features/exams/presentation/manager/add_exam_cubit/exam_cubit.dart';
import 'package:atm_app/core/shared_features/exams/presentation/manager/fetch_exams_cubit/fetch_exams_cubit.dart';
import 'package:atm_app/core/shared_features/exams/presentation/views/widgets/add_exam_bottom_sheet_body.dart';
import 'package:atm_app/core/utils/set_up_service_locator.dart';
import 'package:atm_app/core/widgets/scaffold_message.dart';
import 'package:atm_app/features/admin/materials/presentation/manager/pick_file_cubit/pick_file_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../core/classes/pick_file.dart';

class AddExamBottomSheet extends StatelessWidget {
  const AddExamBottomSheet({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ExamCubit(examsRepo: getit.get<ExamsRepo>()),
        ),
        BlocProvider(
          create: (context) => PickFileCubit(getit.get<FilePickerHelper>()),
        ),
      ],
      child: BlocBuilder<ExamCubit, ExamState>(
        builder: (context, state) {
          if (state is ExamSuccuss) {
            BlocProvider.of<FetchExamsCubit>(context)
                .fetchExams(versionID: state.id);
            Future.microtask(() {
              if (!context.mounted) return;
              context.pop();
            });
          } else if (state is ExamFailure) {
            showScaffoldMessage(context, state.errMessage);
          }
          return const AddExamBottomSheetBody();
        },
      ),
    );
  }
}
