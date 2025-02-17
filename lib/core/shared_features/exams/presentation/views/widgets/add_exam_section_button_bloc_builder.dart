import 'package:atm_app/core/shared_features/exams/data/models/exam_sections_model.dart';
import 'package:atm_app/core/shared_features/exams/domain/entities/exam_entity.dart';
import 'package:atm_app/core/shared_features/exams/presentation/manager/add_exam_section_cubit/add_exam_section_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../../../../../../core/const/app_const.dart';
import '../../../../../../core/widgets/custom_action_button_type2.dart';

class AddExamSectionButtonBuilder extends StatefulWidget {
  final TextEditingController titleController;
  final GlobalKey<FormState> formKey;
  const AddExamSectionButtonBuilder(
      {super.key, required this.titleController, required this.formKey});

  @override
  State<AddExamSectionButtonBuilder> createState() =>
      _AddExamSectionButtonBuilderState();
}

class _AddExamSectionButtonBuilderState
    extends State<AddExamSectionButtonBuilder> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddExamSectionCubit, AddExamSectionState>(
      builder: (context, state) {
        return CustomActionButtonType2(
          isLoading: state is AddExamSectionLoading ? true : false,
          onPressed: () {
            if (widget.formKey.currentState!.validate()) {
              widget.formKey.currentState!.save();

              BlocProvider.of<AddExamSectionCubit>(context)
                  .addExamSection(examSection: _toExamSectionEntity());
            }
          },
          icon: const FaIcon(FontAwesomeIcons.floppyDisk),
          title: 'حفظ',
          backGroundColor: kPrimaryColor,
        );
      },
    );
  }

  _toExamSectionEntity() {
    final entity = Provider.of<ExamEntity>(context, listen: false);

    return ExamSectionsModel(
      entityID: '0',
      title: widget.titleController.text,
      url: '',
      examID: entity.entityID,
      versionName: entity.versionName,
      examTitle: entity.title,
    );
  }
}
