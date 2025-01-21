import 'package:flutter/material.dart';

class CustomLessonPreviewCard extends StatelessWidget {
  const CustomLessonPreviewCard({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: [
              ListTile(
                leading: Icon(Icons.file_download),
                title: Text('File name'),
              ),
              SizedBox(
                height: 16,
              ),
              Text(
                  'في هذا الدرس الجديد، سنتعرف على أساسيات البرمجة باستخدام لغة'),
            ],
          ),
        ),
      ),
    );
  }
}
