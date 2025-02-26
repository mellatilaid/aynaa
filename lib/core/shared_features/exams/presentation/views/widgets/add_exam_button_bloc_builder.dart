import 'dart:developer';

import 'package:atm_app/core/shared_features/exams/domain/entities/exam_entity.dart';
import 'package:atm_app/core/shared_features/exams/presentation/manager/add_exam_cubit/add_exam_cubit.dart';
import 'package:atm_app/features/admin/materials/presentation/manager/add_text_lesson_cubit/lesson_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/const/app_const.dart';
import '../../../../../../core/widgets/custom_action_button_type2.dart';

class AddExamButtonBlocBuilder extends StatefulWidget {
  final TextEditingController subjectTitleController;
  final GlobalKey<FormState> formKey;
  const AddExamButtonBlocBuilder({
    super.key,
    required this.subjectTitleController,
    required this.formKey,
  });

  @override
  State<AddExamButtonBlocBuilder> createState() =>
      _AddExamButtonBlocBuilderState();
}

class _AddExamButtonBlocBuilderState extends State<AddExamButtonBlocBuilder> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddExamCubit, AddExamState>(
      builder: (context, state) {
        return CustomActionButtonType2(
          isLoading: state is AddExamLoading ? true : false,
          title: 'حفظ',
          onPressed: () {
            if (widget.formKey.currentState!.validate()) {
              final ExamEntity exam = _getExamModel();

              BlocProvider.of<AddExamCubit>(context).addExam(exam: exam);
            }
          },
          backGroundColor: kPrimaryColor,
        );
      },
    );
  }

  _getExamModel() {
    final versionInfo = _getVersioninfo();
    log(versionInfo.$1);
    log(versionInfo.$2);

    return ExamEntity(
      entityID: '0',
      title: widget.subjectTitleController.text.trim(),
      url: '',
      versionName: versionInfo.$2,
      versionID: versionInfo.$1,
      localFilePath: null,
      updatedAt: '',
    );
  }

  (String versionID, String versionName) _getVersioninfo() {
    final versionID = context.read<LessonCubit>().versionID;
    final versionName = context.read<LessonCubit>().versionName;
    return (versionID!, versionName!);
  }
}
