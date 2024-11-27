import 'package:atm_app/const.dart';
import 'package:flutter/material.dart';

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
                    ElevatedButton(
                      onPressed: isButtonEnabled
                          ? () {
                              if (_formKey.currentState!.validate()) {
                                _formKey.currentState!.save();
                              } else {
                                setState(() {
                                  autovalidateMode = AutovalidateMode.always;
                                });
                              }
                            }
                          : null,
                      child: const Text(
                        'Save',
                        style: TextStyle(color: kPrimaryColor),
                      ),
                    ),
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

  //takes seperate parameters for reminder model
}
