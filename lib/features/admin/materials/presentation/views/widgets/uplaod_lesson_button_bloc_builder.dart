import 'dart:developer';
import 'dart:io';

import 'package:atm_app/const.dart';
import 'package:atm_app/core/widgets/custom_action_button_type2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../domain/entities/lesson_entity.dart';
import '../../manager/add_lesson_cubit/add_lesson_cubit.dart';

class UploadLessonButtonBuilder extends StatelessWidget {
  final TextEditingController lessonContent;
  final File? file;
  const UploadLessonButtonBuilder({
    super.key,
    required this.lessonContent,
    this.file,
  });

  @override
  Widget build(BuildContext context) {
    log('the file path is ${file?.path}');
    return BlocBuilder<AddLessonCubit, AddLessonState>(
      builder: (context, state) {
        return CustomActionButtonType2(
            isLoading: state is AddLessonLoading ? true : false,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            onPressed: () {
              final addLessonBloc = context.read<AddLessonCubit>();
              final lesson = _toLessonEnitiy(addLessonCubit: addLessonBloc);
              BlocProvider.of<AddLessonCubit>(context)
                  .addLesson(lesson: lesson);
            },
            backGroundColor: kPrimaryColor,
            icon: const FaIcon(
              FontAwesomeIcons.upload,
              color: Colors.white,
            ),
            title: 'تحميل');
      },
    );
  }

  _toLessonEnitiy({required AddLessonCubit addLessonCubit}) {
    return LessonEntity(
      description: lessonContent.text,
      aynaaVersionId: addLessonCubit.versionID!,
      subjectId: addLessonCubit.subjectID!,
    );
  }
}
