import 'dart:developer';

import 'package:atm_app/features/admin/materials/presentation/manager/add_text_lesson_cubit/add_lesson_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/const/app_const.dart';
import '../../../../../../core/widgets/custom_action_button_type2.dart';
import '../../../domain/entities/subjects_entity.dart';
import '../../manager/add_new_subject_cubit/add_new_subject_cubit.dart';

class AddNewSubjectButtonBlocBuilder extends StatefulWidget {
  final TextEditingController subjectTitleController;
  final GlobalKey<FormState> formKey;
  const AddNewSubjectButtonBlocBuilder({
    super.key,
    required this.subjectTitleController,
    required this.formKey,
  });

  @override
  State<AddNewSubjectButtonBlocBuilder> createState() =>
      _AddNewSubjectButtonBlocBuilderState();
}

class _AddNewSubjectButtonBlocBuilderState
    extends State<AddNewSubjectButtonBlocBuilder> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddNewSubjectCubit, AddNewSubjectState>(
      builder: (context, state) {
        return CustomActionButtonType2(
          isLoading: state is AddNewSubjectLoading ? true : false,
          title: 'create subject',
          onPressed: () {
            if (widget.formKey.currentState!.validate()) {
              final SubjectsEntity subject = _getSubjectModel();

              BlocProvider.of<AddNewSubjectCubit>(context)
                  .addNewSubject(subject: subject);
            }
          },
          backGroundColor: kPrimaryColor,
        );
      },
    );
  }

  _getSubjectModel() {
    final versionInfo = _getVersioninfo();
    log(versionInfo.$1);
    log(versionInfo.$2);

    return SubjectsEntity(
      entityID: '0',
      subjectName: widget.subjectTitleController.text.trim(),
      versionID: versionInfo.$1,
      url: '',
      versionName: versionInfo.$2,
    );
  }

  (String versionID, String versionName) _getVersioninfo() {
    final versionID = context.read<AddLessonCubit>().versionID;
    final versionName = context.read<AddLessonCubit>().versionName;
    return (versionID!, versionName!);
  }
}
