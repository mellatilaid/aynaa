import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path/path.dart' as path;

import '../../../domain/entities/lesson_entity.dart';

class CustomLessonPreviewCard extends StatefulWidget {
  final LessonEntity lesson;
  const CustomLessonPreviewCard({super.key, required this.lesson});

  @override
  State<CustomLessonPreviewCard> createState() =>
      _CustomLessonPreviewCardState();
}

class _CustomLessonPreviewCardState extends State<CustomLessonPreviewCard> {
  String? fileExtension;
  String? baseName;

  @override
  void initState() {
    super.initState();
    baseName =
        widget.lesson.url != null ? path.basename(widget.lesson.url!) : null;
    fileExtension =
        widget.lesson.url != null ? path.extension(widget.lesson.url!) : null;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Display image or placeholder
              SizedBox(
                width: double.infinity,
                child: _buildPreview(filePath: widget.lesson.localFilePath),
              ),
              const SizedBox(height: 16),
              // Display description
              if (widget.lesson.description != null)
                Text(
                  widget.lesson.description!,
                  textAlign: TextAlign.start,
                  style: const TextStyle(fontSize: 14),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

_buildPreview({String? filePath}) {
  if (filePath != null) {
    final fileExtension = path.extension(filePath);

    if (['.jpg', '.jpeg', '.png', '.gif']
        .contains(fileExtension.toLowerCase())) {
      // Preview image
      return ConstrainedBox(
        constraints: const BoxConstraints(
          maxHeight: 300, // Set maximum height
          minHeight: 150, // Set minimum height
        ),
        child: AspectRatio(
          aspectRatio: 16 / 9, // Standard aspect ratio for previews
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.file(
              File(filePath),
              fit: BoxFit.cover, // Maintain aspect ratio and fill the space
              filterQuality: FilterQuality.high, // Preserve image quality
            ),
          ),
        ),
      );
      return Image.file(
        File(filePath),
        fit: BoxFit.fill,
      );
    } else if (['.mp4', '.mov', '.avi'].contains(fileExtension.toLowerCase())) {
      // Show video thumbnail
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.image_not_supported,
              size: 40,
              color: Colors.grey[600],
            ),
            const SizedBox(height: 8),
            Text(
              'No Title',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      );
    } else {
      // Show file name for unsupported types
      return Align(
          alignment: Alignment.center,
          child: Text(
            "File: $filePath",
          ));
    }
  }
}
