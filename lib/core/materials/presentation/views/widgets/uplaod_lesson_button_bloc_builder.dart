import 'package:atm_app/core/materials/domain/entities/lesson_entity.dart';
import 'package:atm_app/core/widgets/custom_action_button_type2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../../../core/const/app_const.dart';
import '../../../../../features/admin/materials/presentation/manager/add_text_lesson_cubit/lesson_cubit.dart';

class UploadLessonButtonBuilder extends StatelessWidget {
  final TextEditingController lessonTitle;
  final TextEditingController lessonContent;
  final String filePath;
  final bool isButtonEnabled;
  final bool isEditMode;
  final LessonEntity? lessonEntity;
  final GlobalKey<FormState> formKey;

  const UploadLessonButtonBuilder({
    super.key,
    required this.lessonTitle,
    required this.lessonContent,
    required this.filePath,
    required this.isButtonEnabled,
    required this.isEditMode,
    this.lessonEntity,
    required this.formKey,
  });

  @override
  Widget build(BuildContext context) {
    // log('the file path is ${file?.path}');
    return BlocBuilder<LessonCubit, LessonState>(
      builder: (context, state) {
        return CustomActionButtonType2(
          isLoading: state is LessonLoading ? true : false,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          onPressed: isButtonEnabled ? () => _handleSubmission(context) : null,
          backGroundColor: kPrimaryColor,
          icon: const FaIcon(
            FontAwesomeIcons.upload,
            color: Colors.white,
          ),
          title: isEditMode ? 'تحديث المادة' : 'اضافة مادة',
        );
      },
    );
  }

  void _handleSubmission(BuildContext context) {
    if (!formKey.currentState!.validate()) return;

    final cubit = context.read<LessonCubit>();

    if (isEditMode && lessonEntity != null) {
      final updatedSubject = lessonEntity!.copyWith(
        title: lessonTitle.text.trim(),
        description: lessonContent.text.trim(),
        updatedAt: DateTime.now().toUtc().toIso8601String(),
      );
      cubit.setFilePath(filePath);

      cubit.updateLesson(
        lesson: updatedSubject,
      );
    } else {
      final addLessonBloc = context.read<LessonCubit>();
      final lesson = _toLessonEnitiy(addLessonCubit: addLessonBloc);
      cubit.setFilePath(filePath);
      cubit.addLesson(lesson: lesson);
    }
  }

  _toLessonEnitiy({required LessonCubit addLessonCubit}) {
    return LessonEntity(
      entityID: '',
      name: lessonTitle.text,
      description: lessonContent.text,
      aynaaVersionId: addLessonCubit.versionID!,
      subjectId: addLessonCubit.subjectID!,
      subjectName: addLessonCubit.subjectName!,
      versionName: addLessonCubit.versionName!,
      updatedAt: DateTime.now().toUtc().toIso8601String(),
    );
  }
}
