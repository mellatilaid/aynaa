// ignore_for_file: must_be_immutable

import 'package:atm_app/core/functions/check_text_dir.dart';
import 'package:flutter/material.dart';

import '../const/app_const.dart';

class InvisibleTextField extends StatefulWidget {
  final String? hintText;
  final int? maxLines;
  final bool isExpand;
  final FocusNode? focusNode;
  final Function(String?)? onSaved;
  final Function(String?)? onChanged;
  TextEditingController controller;
  final TextStyle? textStyle;
  final bool readOnly;
  final String errMessage;

  InvisibleTextField({
    super.key,
    this.hintText,
    this.maxLines,
    this.onSaved,
    this.onChanged,
    this.isExpand = false,
    required this.controller,
    this.textStyle,
    this.readOnly = false,
    this.focusNode,
    this.errMessage = 'يرجى إدخال الحقل',
  });

  @override
  State<InvisibleTextField> createState() => _InvisibleTextFieldState();
}

class _InvisibleTextFieldState extends State<InvisibleTextField> {
  TextDirection _textDirection = TextDirection.ltr;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    updateTextDirection(widget.controller.text);
    widget.controller.addListener(() {
      updateTextDirection(widget.controller.text);
    });
  }

  updateTextDirection(String text) {
    if (hasAnyRtl(text)) {
      setState(() {
        _textDirection = TextDirection.rtl;
      });
    } else {
      setState(() {
        _textDirection = TextDirection.ltr;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return widget.errMessage;
        }
        return null;
      },
      textDirection: _textDirection,
      focusNode: widget.focusNode,
      readOnly: widget.readOnly,
      autofocus: widget.readOnly,
      style: widget.textStyle,
      controller: widget.controller,
      onChanged: widget.onChanged,
      onSaved: widget.onSaved,
      cursorColor: kPrimaryColor,
      expands: widget.isExpand,
      textAlignVertical: TextAlignVertical.top,
      maxLines: widget.maxLines,
      minLines: null,
      decoration: InputDecoration(
        hintText: widget.hintText,
        labelStyle: const TextStyle(color: kPrimaryColor),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.transparent,
          ),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.transparent),
        ),
        errorBorder: const OutlineInputBorder(
            borderSide: BorderSide(
          color: Colors.red,
        )),
      ),
    );
  }
}
