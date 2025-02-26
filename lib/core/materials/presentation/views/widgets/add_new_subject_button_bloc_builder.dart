import 'dart:developer';

import 'package:atm_app/features/admin/materials/presentation/manager/add_text_lesson_cubit/add_lesson_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/const/app_const.dart';
import '../../../../../../core/materials/domain/entities/subjects_entity.dart';
import '../../../../../../core/widgets/custom_action_button_type2.dart';
import '../../../../../features/admin/materials/presentation/manager/subject_cubit/subject_cubit.dart';

class AddNewSubjectButtonBlocBuilder extends StatefulWidget {
  final TextEditingController subjectTitleController;
  final GlobalKey<FormState> formKey;
  final bool isEditMode;
  final SubjectsEntity? existingSubject;
  final String filePath;
  const AddNewSubjectButtonBlocBuilder({
    super.key,
    required this.subjectTitleController,
    required this.formKey,
    this.isEditMode = false,
    this.existingSubject,
    required this.filePath,
  });

  @override
  State<AddNewSubjectButtonBlocBuilder> createState() =>
      _AddNewSubjectButtonBlocBuilderState();
}

class _AddNewSubjectButtonBlocBuilderState
    extends State<AddNewSubjectButtonBlocBuilder> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SubjectCubit, SubjectState>(
      builder: (context, state) {
        return CustomActionButtonType2(
          isLoading: state is SubjectLoading ? true : false,
          title: widget.isEditMode ? 'تحديث المادة' : 'اضافة مادة',
          onPressed: () => _handleSubmission(context),
          backGroundColor: kPrimaryColor,
        );
      },
    );
  }

  void _handleSubmission(BuildContext context) {
    if (!widget.formKey.currentState!.validate()) return;

    final cubit = context.read<SubjectCubit>();

    if (widget.isEditMode && widget.existingSubject != null) {
      final updatedSubject = widget.existingSubject!.copyWith(
        title: widget.subjectTitleController.text.trim(),
        updatedAt: DateTime.now().toUtc().toIso8601String(),
      );
      cubit.setFilePath(widget.filePath);

      cubit.updateSubject(
        subject: updatedSubject,
      );
    } else {
      cubit.setFilePath(widget.filePath);
      cubit.addNewSubject(subject: _getSubjectModel());
    }
  }

  _getSubjectModel() {
    final versionInfo = _getVersioninfo();
    log(versionInfo.$1);
    log(versionInfo.$2);

    return SubjectsEntity(
      entityID: '0',
      subjectName: widget.subjectTitleController.text.trim(),
      versionName: versionInfo.$2,
      url: '',
      versionID: versionInfo.$1,
      updatedAt: DateTime.now().toUtc().toIso8601String(),
      pickedFilePath: widget.filePath,
    );
  }

  (String versionID, String versionName) _getVersioninfo() {
    final versionID = context.read<AddLessonCubit>().versionID;
    final versionName = context.read<AddLessonCubit>().versionName;
    return (versionID!, versionName!);
  }
}
