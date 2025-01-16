import 'dart:developer';

import 'package:atm_app/const.dart';
import 'package:atm_app/core/widgets/custom_action_button_type2.dart';
import 'package:atm_app/features/admin/materials/domain/entities/lesson_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../core/widgets/custom_rounded_button_with_title.dart';
import '../../manager/add_lesson_cubit/add_lesson_cubit.dart';

class UplaodLessonMediaButtonSection extends StatefulWidget {
  final TextEditingController lessonContent;
  const UplaodLessonMediaButtonSection({
    super.key,
    required this.lessonContent,
  });

  @override
  State<UplaodLessonMediaButtonSection> createState() =>
      _UplaodLessonMediaButtonSectionState();
}

class _UplaodLessonMediaButtonSectionState
    extends State<UplaodLessonMediaButtonSection> {
  bool isMediaUpladed = true;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      child: isMediaUpladed
          ? BlocBuilder<AddLessonCubit, AddLessonState>(
              builder: (context, state) {
                if (state is AddLessonSuccuss) {
                  context.pop();
                }
                return CustomActionButtonType2(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    onPressed: () {
                      final lesson = toLessonEnitiy();
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
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                RoundedButtonWithTitle(
                    iconData: Icons.file_copy, iconName: 'ملف', onTap: () {}),
                RoundedButtonWithTitle(
                    iconData: Icons.image, iconName: 'صورة', onTap: () {}),
                RoundedButtonWithTitle(
                  iconData: Icons.video_call,
                  iconName: 'فيديو',
                  onTap: () {},
                ),
              ],
            ),
    );
  }

  toLessonEnitiy() {
    final addLessonBloc = context.read<AddLessonCubit>();
    log(addLessonBloc.versionID ?? 'version id is null');
    if (addLessonBloc.versionID == null || addLessonBloc.subjectID == null) {
      log('null');
      return LessonEntity(
        description: widget.lessonContent.text,
        aynaaVersionId: '',
        subjectId: '',
      );
    }
    return LessonEntity(
      description: widget.lessonContent.text,
      aynaaVersionId: addLessonBloc.versionID!,
      subjectId: addLessonBloc.subjectID!,
    );
  }
}
