import 'package:atm_app/core/shared_features/exams/data/models/exam_sections_model.dart';
import 'package:atm_app/core/shared_features/exams/domain/entities/exam_entity.dart';
import 'package:atm_app/core/shared_features/exams/domain/entities/exam_sections_entity.dart';
import 'package:atm_app/core/shared_features/exams/presentation/manager/exam_section_cubit/exam_section_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:path/path.dart' as Path;
import 'package:provider/provider.dart';

import '../../../../../../core/const/app_const.dart';
import '../../../../../../core/widgets/custom_action_button_type2.dart';

class AddExamSectionButtonBuilder extends StatefulWidget {
  final bool isButtonEnabled;
  final TextEditingController titleController;
  final GlobalKey<FormState> formKey;
  final bool isEditMode;
  final String filePath;
  final ExamSectionsEntity? examSection;
  const AddExamSectionButtonBuilder({
    super.key,
    required this.isButtonEnabled,
    required this.titleController,
    required this.formKey,
    this.examSection,
    this.isEditMode = false,
    required this.filePath,
  });

  @override
  State<AddExamSectionButtonBuilder> createState() =>
      _AddExamSectionButtonBuilderState();
}

class _AddExamSectionButtonBuilderState
    extends State<AddExamSectionButtonBuilder> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExamSectionCubit, ExamSectionState>(
      builder: (context, state) {
        return CustomActionButtonType2(
          isLoading: state is ExamSectionLoading ? true : false,
          onPressed:
              widget.isButtonEnabled ? () => _handleSubmission(context) : null,
          icon: const FaIcon(FontAwesomeIcons.floppyDisk),
          title: widget.isEditMode ? 'تعديل' : 'حفظ',
          backGroundColor: kPrimaryColor,
        );
      },
    );
  }

  void _handleSubmission(BuildContext context) {
    if (!widget.formKey.currentState!.validate()) return;

    final cubit = context.read<ExamSectionCubit>();

    if (widget.isEditMode && widget.examSection != null) {
      final updatedSection = widget.examSection!.copyWith(
        title: widget.titleController.text.trim(),
        updatedAt: DateTime.now().toUtc().toIso8601String(),
      );
      cubit.setFilePath(widget.filePath);

      cubit.updateSection(
        examSection: updatedSection,
      );
    } else {
      final section = _toExamSectionEntity();
      cubit.setFilePath(widget.filePath);
      cubit.addExamSection(examSection: section);
    }
  }

  _toExamSectionEntity() {
    //get the subject entity from the provider
    //the new lesson takes the subject name from the url so when
    //subject name update the storage path still the same
    final entity = Provider.of<ExamEntity>(context, listen: false);
    final entityName = Path.split(entity.url!);
    return ExamSectionsModel(
      entityID: '0',
      title: widget.titleController.text,
      url: '',
      examID: entity.entityID,
      versionName: entity.versionName,
      examTitle: entityName[1],
      updatedAt: DateTime.now().toUtc().toIso8601String(),
    );
  }
}
