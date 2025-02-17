import 'package:atm_app/core/classes/pick_file.dart';
import 'package:atm_app/core/materials/presentation/views/widgets/add_exam_section_bottom_sheet_body.dart';
import 'package:atm_app/core/shared_features/exams/domain/repos/exam_sections_repo.dart';
import 'package:atm_app/core/shared_features/exams/presentation/manager/add_exam_section_cubit/add_exam_section_cubit.dart';
import 'package:atm_app/core/shared_features/exams/presentation/manager/fetch_exam_sections_cubit/fetch_exam_sections_cubit.dart';
import 'package:atm_app/core/utils/set_up_service_locator.dart';
import 'package:atm_app/core/widgets/scaffold_message.dart';
import 'package:atm_app/features/admin/materials/presentation/manager/pick_file_cubit/pick_file_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AddExamSectionBottomSheet extends StatelessWidget {
  const AddExamSectionBottomSheet({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AddExamSectionCubit(
              examSectionsRepo: getit.get<ExamSectionsRepo>()),
        ),
        BlocProvider(
          create: (context) => PickFileCubit(getit.get<FilePickerHelper>()),
        ),
      ],
      child: BlocListener<AddExamSectionCubit, AddExamSectionState>(
        listener: (context, state) {
          if (state is AddExamSectionSuccess) {
            BlocProvider.of<FetchExamSectionsCubit>(context)
                .fetchExams(id: state.id);
            Future.microtask(() {
              if (!context.mounted) return;
              context.pop();
            });
          } else if (state is AddExamSectionFailure) {
            Navigator.pop(context);
            showScaffoldMessage(context, state.errMessage);
          }
        },
        child: const AddExamSectionBottomSheetBody(),
      ),
    );
  }
}
