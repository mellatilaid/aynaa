import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

Future<Widget> generateVideoThumbnail(String filePath) async {
  try {
    final uint8list = await VideoThumbnail.thumbnailData(
      video: filePath,
      imageFormat: ImageFormat.JPEG,
      quality: 50,
    );
    if (uint8list != null) {
      return Image.memory(uint8list,
          fit: BoxFit.cover, height: 200, width: 200);
    } else {
      return const Text("Unable to generate thumbnail");
    }
  } on Exception catch (e) {
    log(e.toString());
    return Text(filePath);
  }
}
