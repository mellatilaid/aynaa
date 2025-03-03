import 'package:atm_app/core/classes/pick_file.dart';
import 'package:atm_app/core/materials/presentation/views/widgets/add_exam_section_bottom_sheet_body.dart';
import 'package:atm_app/core/shared_features/exams/domain/entities/exam_sections_entity.dart';
import 'package:atm_app/core/shared_features/exams/domain/repos/exam_sections_repo.dart';
import 'package:atm_app/core/shared_features/exams/presentation/manager/exam_section_cubit/exam_section_cubit.dart';
import 'package:atm_app/core/shared_features/exams/presentation/manager/fetch_exam_sections_cubit/fetch_exam_sections_cubit.dart';
import 'package:atm_app/core/utils/set_up_service_locator.dart';
import 'package:atm_app/core/widgets/scaffold_message.dart';
import 'package:atm_app/features/admin/materials/presentation/manager/pick_file_cubit/pick_file_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AddExamSectionBottomSheet extends StatelessWidget {
  final bool isEditMode;
  final ExamSectionsEntity? examSection;
  final FetchExamSectionsCubit fetchExamSectionsCubit;
  const AddExamSectionBottomSheet({
    super.key,
    required this.fetchExamSectionsCubit,
    this.isEditMode = false,
    this.examSection,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              ExamSectionCubit(examSectionsRepo: getit.get<ExamSectionsRepo>()),
        ),
        BlocProvider(
          create: (context) => PickFileCubit(getit.get<FilePickerHelper>()),
        ),
      ],
      child: BlocListener<ExamSectionCubit, ExamSectionState>(
        listener: (context, state) {
          if (state is ExamSectionSuccess) {
            fetchExamSectionsCubit.fetchExamSections(id: state.id);
            Future.microtask(() {
              if (!context.mounted) return;
              context.pop();
            });
          } else if (state is ExamSectionFailure) {
            Navigator.pop(context);
            showScaffoldMessage(context, state.errMessage);
          }
        },
        child: (isEditMode)
            ? AddExamSectionBottomSheetBody.editMode(examSection!)
            : const AddExamSectionBottomSheetBody(),
      ),
    );
  }
}
