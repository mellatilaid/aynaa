import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path/path.dart' as path;

import '../../../../../../core/functions/generate_video_thumbnail.dart';

class LessonMediaPreview extends StatelessWidget {
  final String? filePath;
  const LessonMediaPreview({
    super.key,
    this.filePath,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(16),
      ),
      child: _buildPreview(),
    );
  }

  _buildPreview() {
    if (filePath != null) {
      final fileExtension = path.extension(filePath!);

      if (['.jpg', '.jpeg', '.png', '.gif']
          .contains(fileExtension.toLowerCase())) {
        // Preview image
        return Image.file(
          File(filePath!),
          fit: BoxFit.cover,
          height: 250,
          width: double.infinity,
        );
      } else if (['.mp4', '.mov', '.avi']
          .contains(fileExtension.toLowerCase())) {
        // Show video thumbnail
        return FutureBuilder<Widget>(
          future: generateVideoThumbnail(filePath!),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return snapshot.data!;
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        );
      } else {
        // Show file name for unsupported types
        return Text("File: ${filePath!}");
      }
    }
  }
}
