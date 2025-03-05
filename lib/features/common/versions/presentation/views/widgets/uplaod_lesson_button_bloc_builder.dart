import 'package:atm_app/core/widgets/custom_action_button_type2.dart';
import 'package:atm_app/features/common/versions/domain/entities/lesson_entity.dart';
import 'package:atm_app/features/common/versions/domain/entities/subjects_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:path/path.dart' as path;
import 'package:provider/provider.dart';

import '../../../../../../../core/const/app_const.dart';
import '../../manager/add_text_lesson_cubit/lesson_cubit.dart';

class UploadLessonButtonBuilder extends StatefulWidget {
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
  State<UploadLessonButtonBuilder> createState() =>
      _UploadLessonButtonBuilderState();
}

class _UploadLessonButtonBuilderState extends State<UploadLessonButtonBuilder> {
  @override
  Widget build(BuildContext context) {
    // log('the file path is ${file?.path}');
    return BlocBuilder<LessonCubit, LessonState>(
      builder: (context, state) {
        return CustomActionButtonType2(
          isLoading: state is LessonLoading ? true : false,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          onPressed:
              widget.isButtonEnabled ? () => _handleSubmission(context) : null,
          backGroundColor: kPrimaryColor,
          icon: const FaIcon(
            FontAwesomeIcons.upload,
            color: Colors.white,
          ),
          title: widget.isEditMode ? 'تحديث المادة' : 'اضافة مادة',
        );
      },
    );
  }

  void _handleSubmission(BuildContext context) {
    if (!widget.formKey.currentState!.validate()) return;

    final cubit = context.read<LessonCubit>();

    if (widget.isEditMode && widget.lessonEntity != null) {
      final updatedSubject = widget.lessonEntity!.copyWith(
        title: widget.lessonTitle.text.trim(),
        description: widget.lessonContent.text.trim(),
        updatedAt: DateTime.now().toUtc().toIso8601String(),
      );
      cubit.setFilePath(widget.filePath);

      cubit.updateLesson(
        lesson: updatedSubject,
      );
    } else {
      final addLessonBloc = context.read<LessonCubit>();
      final lesson = _toLessonEnitiy(addLessonCubit: addLessonBloc);
      cubit.setFilePath(widget.filePath);
      cubit.addLesson(lesson: lesson);
    }
  }

  _toLessonEnitiy({required LessonCubit addLessonCubit}) {
    //get the subject entity from the provider
    //the new lesson takes the subject name from the url so when
    //subject name update the storage path still the same
    final entity = Provider.of<SubjectsEntity>(context, listen: false);
    final parts = path.split(entity.url);
    return LessonEntity(
      entityID: '',
      name: widget.lessonTitle.text,
      description: widget.lessonContent.text,
      aynaaVersionId: addLessonCubit.versionID!,
      subjectId: addLessonCubit.subjectID!,
      subjectName: parts[1],
      versionName: addLessonCubit.versionName!,
      updatedAt: DateTime.now().toUtc().toIso8601String(),
    );
  }
}
