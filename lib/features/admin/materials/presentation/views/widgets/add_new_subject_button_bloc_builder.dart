import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../const.dart';
import '../../../../../../core/widgets/custom_action_button_type2.dart';
import '../../../data/models/subjects_model.dart';
import '../../../domain/entities/subjects_entity.dart';
import '../../manager/add_new_subject_cubit/add_new_subject_cubit.dart';

class AddNewSubjectButtonBlocBuilder extends StatelessWidget {
  final TextEditingController subjectTitleController;
  const AddNewSubjectButtonBlocBuilder({
    super.key,
    required this.subjectTitleController,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddNewSubjectCubit, AddNewSubjectState>(
      builder: (context, state) {
        return CustomActionButtonType2(
          isLoading: state is AddNewSubjectLoading ? true : false,
          title: 'create subject',
          onPressed: () {
            final SubjectsEntity subject = SubjectsModel(
                id: '0', subjectName: subjectTitleController.text.trim());
            log(subjectTitleController.text.trim());
            BlocProvider.of<AddNewSubjectCubit>(context)
                .addNewSubject(subject: subject);
          },
          backGroundColor: kPrimaryColor,
        );
      },
    );
  }
}
