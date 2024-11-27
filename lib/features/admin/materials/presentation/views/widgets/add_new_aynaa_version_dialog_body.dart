import 'package:atm_app/core/widgets/custom_action_button.dart';
import 'package:atm_app/features/admin/materials/presentation/manager/creata_new_aynaa_version_cubit/create_new_aynaa_version_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../../../core/widgets/dual_text_field.dart';

class AddAynaaVersionAlertDialogBody extends StatefulWidget {
  const AddAynaaVersionAlertDialogBody({super.key});

  @override
  State<AddAynaaVersionAlertDialogBody> createState() =>
      _AddAynaaVersionAlertDialogBodyState();
}

class _AddAynaaVersionAlertDialogBodyState
    extends State<AddAynaaVersionAlertDialogBody> {
  final TextEditingController _aynaaVersionNameController =
      TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  bool isButtonEnabled = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    _aynaaVersionNameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          autovalidateMode: autovalidateMode,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.close),
                    ),
                    BlocBuilder<CreateNewAynaaVersionCubit,
                        CreateNewAynaaVersionState>(
                      builder: (context, state) {
                        return CustomActionButton(
                          isLoading: state is CreateNewAynaaVersionLoading
                              ? true
                              : false,
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();
                              BlocProvider.of<CreateNewAynaaVersionCubit>(
                                      context)
                                  .createNewAynaaVersion(
                                      versionName:
                                          _aynaaVersionNameController.text);
                            } else {
                              setState(() {
                                autovalidateMode = AutovalidateMode.always;
                              });
                            }
                          },
                          icon: const FaIcon(FontAwesomeIcons.floppyDisk),
                          label: 'حفظ',
                        );
                      },
                    ),
                    /* ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          BlocProvider.of<CreateNewAynaaVersionCubit>(context)
                              .createNewAynaaVersion(
                                  versionName:
                                      _aynaaVersionNameController.text);
                        } else {
                          setState(() {
                            autovalidateMode = AutovalidateMode.always;
                          });
                        }
                      },
                      child: const Text(
                        'Save',
                        style: TextStyle(color: kPrimaryColor),
                      ),
                    ),*/
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                DualActionTextField(
                  controller: _aynaaVersionNameController,
                  hintText: 'إسسم النسخة',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
