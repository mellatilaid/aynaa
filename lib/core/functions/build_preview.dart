import 'dart:io';

import 'package:atm_app/core/widgets/custom_image_frame.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as path;

buildPreview({String? filePath}) {
  if (filePath != null) {
    final fileExtension = path.extension(filePath);

    if (['.jpg', '.jpeg', '.png', '.gif']
        .contains(fileExtension.toLowerCase())) {
      // Preview image
      return CustomImageFame(
        child: Image.file(
          File(filePath),
          fit: BoxFit.cover, // Maintain aspect ratio and fill the space
          filterQuality: FilterQuality.high, // Preserve image quality
        ),
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
  } else {
    return const CustomImageFame(
        child: Center(
      child: Icon(
        Icons.image,
        size: 50,
      ),
    ));
  }
}
