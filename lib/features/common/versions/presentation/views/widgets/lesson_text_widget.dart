import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:url_launcher/url_launcher.dart';

class LessonTextWidget extends StatelessWidget {
  final String lessonText;

  const LessonTextWidget({super.key, required this.lessonText});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Linkify(
        onOpen: (link) async {
          final uri = Uri.parse(link.url);
          if (await canLaunchUrl(uri)) {
            await launchUrl(uri, mode: LaunchMode.externalApplication);
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("تعذر فتح هذا الرابط ${link.url}")),
            );
          }
        },
        text: lessonText,
        style: const TextStyle(fontSize: 16.0, color: Colors.black),
        linkStyle: const TextStyle(
          color: Colors.blue,
          decoration: TextDecoration.underline,
        ),
      ),
    );
  }
}
