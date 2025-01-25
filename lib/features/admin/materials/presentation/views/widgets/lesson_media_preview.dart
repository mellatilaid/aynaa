import 'dart:io';

import 'package:cross_file/cross_file.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as path;

import '../../../../../../core/functions/generate_video_thumbnail.dart';

class LessonMediaPreview extends StatelessWidget {
  final XFile? filePath;
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
      final fileExtension = path.extension(filePath!.path);

      if (['.jpg', '.jpeg', '.png', '.gif']
          .contains(fileExtension.toLowerCase())) {
        // Preview image
        return Center(
          child: Image.file(
            File(filePath!.path),
            fit: BoxFit.cover,
          ),
        );
      } else if (['.mp4', '.mov', '.avi']
          .contains(fileExtension.toLowerCase())) {
        // Show video thumbnail
        return FutureBuilder<Widget>(
          future: generateVideoThumbnail(filePath!.path),
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
        return Align(
            alignment: Alignment.center,
            child: Text(
              "File: ${filePath!}",
            ));
      }
    }
  }
}
