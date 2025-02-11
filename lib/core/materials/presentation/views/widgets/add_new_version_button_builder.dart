import 'package:atm_app/core/materials/data/models/aynaa_versions_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../../../core/const/app_const.dart';
import '../../../../../../core/widgets/custom_action_button_type2.dart';
import '../../../../../features/admin/materials/presentation/manager/creata_new_aynaa_version_cubit/create_new_aynaa_version_cubit.dart';

class AddNewVersionButtonBuilder extends StatefulWidget {
  final TextEditingController subjectTitleController;
  final GlobalKey<FormState> formKey;
  const AddNewVersionButtonBuilder(
      {super.key, required this.subjectTitleController, required this.formKey});

  @override
  State<AddNewVersionButtonBuilder> createState() =>
      _AddNewVersionButtonBuilderState();
}

class _AddNewVersionButtonBuilderState
    extends State<AddNewVersionButtonBuilder> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateNewAynaaVersionCubit, CreateNewAynaaVersionState>(
      builder: (context, state) {
        return CustomActionButtonType2(
          isLoading: state is CreateNewAynaaVersionLoading ? true : false,
          onPressed: () {
            if (widget.formKey.currentState!.validate()) {
              widget.formKey.currentState!.save();
              BlocProvider.of<CreateNewAynaaVersionCubit>(context)
                  .createNewAynaaVersion(version: _toVersionEntity());
            }
          },
          icon: const FaIcon(FontAwesomeIcons.floppyDisk),
          title: 'حفظ',
          backGroundColor: kPrimaryColor,
        );
      },
    );
  }

  _toVersionEntity() {
    return AynaaVersionsModel(
      '0',
      aynaaVersion: widget.subjectTitleController.text,
      url: '',
    );
  }
}
