import 'dart:developer';

import 'package:atm_app/core/shared_features/exams/domain/entities/exam_entity.dart';
import 'package:atm_app/core/shared_features/exams/presentation/manager/exam_cubit/exam_cubit.dart';
import 'package:atm_app/features/admin/materials/presentation/manager/add_text_lesson_cubit/lesson_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/const/app_const.dart';
import '../../../../../../core/widgets/custom_action_button_type2.dart';

class AddExamButtonBlocBuilder extends StatefulWidget {
  final TextEditingController titleController;
  final GlobalKey<FormState> formKey;
  final ExamEntity? exam;
  final String filePath;
  final bool isEditMode;
  final bool isButtonEnabled;
  const AddExamButtonBlocBuilder({
    super.key,
    required this.titleController,
    required this.formKey,
    required this.filePath,
    this.exam,
    required this.isEditMode,
    required this.isButtonEnabled,
  });

  @override
  State<AddExamButtonBlocBuilder> createState() =>
      _AddExamButtonBlocBuilderState();
}

class _AddExamButtonBlocBuilderState extends State<AddExamButtonBlocBuilder> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExamCubit, ExamState>(
      builder: (context, state) {
        return CustomActionButtonType2(
          isLoading: state is ExamLoading ? true : false,
          title: widget.isEditMode ? 'تحديث ' : 'اضافة ',
          onPressed:
              widget.isButtonEnabled ? () => _handleSubmission(context) : null,
          backGroundColor: kPrimaryColor,
        );
      },
    );
  }

  void _handleSubmission(BuildContext context) {
    if (!widget.formKey.currentState!.validate()) return;

    final cubit = context.read<ExamCubit>();

    if (widget.isEditMode && widget.exam != null) {
      final updatedSubject = widget.exam!.copyWith(
        title: widget.titleController.text.trim(),
        updatedAt: DateTime.now().toUtc().toIso8601String(),
      );
      cubit.setFilePath(widget.filePath);

      cubit.updateExam(
        exam: updatedSubject,
      );
    } else {
      cubit.setFilePath(widget.filePath);
      cubit.addExam(exam: _getExamModel());
    }
  }

  _getExamModel() {
    final versionInfo = _getVersioninfo();
    log(versionInfo.$1);
    log(versionInfo.$2);

    return ExamEntity(
      entityID: '0',
      title: widget.titleController.text.trim(),
      url: '',
      versionName: versionInfo.$2,
      versionID: versionInfo.$1,
      localFilePath: null,
      updatedAt: DateTime.now().toUtc().toIso8601String(),
    );
  }

  (String versionID, String versionName) _getVersioninfo() {
    final versionID = context.read<LessonCubit>().versionID;
    final versionName = context.read<LessonCubit>().versionName;
    return (versionID!, versionName!);
  }
}
