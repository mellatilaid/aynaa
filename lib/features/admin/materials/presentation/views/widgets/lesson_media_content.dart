import 'package:atm_app/const.dart';
import 'package:flutter/material.dart';

class LessonMediaContent extends StatelessWidget {
  final String? filePath;
  const LessonMediaContent({
    super.key,
    required this.filePath,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(16),
      ),
      child: (filePath != null)
          ? Center(
              child: Text(filePath ?? 'No File Selected'),
            )
          : const Center(
              child: Icon(
              Icons.picture_as_pdf_rounded,
              color: kPrimaryColor,
              size: 32,
            )),
    );
  }
}
