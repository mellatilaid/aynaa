import 'package:atm_app/core/materials/presentation/views/widgets/custom_subject_card.dart';
import 'package:atm_app/core/shared_features/exams/presentation/manager/add_exam_cubit/exam_cubit.dart';
import 'package:atm_app/core/shared_features/exams/presentation/manager/fetch_exams_cubit/fetch_exams_cubit.dart';
import 'package:atm_app/core/shared_features/exams/presentation/views/widgets/add_exam_bottom_sheet.dart';
import 'package:atm_app/core/utils/app_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../domain/entities/exam_entity.dart';

class ExamsListView extends StatelessWidget {
  final List<ExamEntity> exams;
  const ExamsListView({super.key, required this.exams});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: exams.length,
        itemBuilder: (context, index) {
          return CustomSubjectCard(
            onTap: () => context.push(
              extra: exams[index],
              AppRouter.examSectionsView,
            ),
            onDelete: () {
              BlocProvider.of<ExamCubit>(context)
                  .deleteExam(exam: exams[index]);
            },
            onEdit: () {
              final fetchExamsCubit = context.read<FetchExamsCubit>();
              showModalBottomSheet(
                  isScrollControlled: true,
                  context: context,
                  builder: (context) {
                    return AddExamBottomSheet(
                      fetchExamsCubit: fetchExamsCubit,
                      isEditMode: true,
                      exam: exams[index],
                    );
                  });
            },
            item: exams[index],
          );
        });
  }
}
