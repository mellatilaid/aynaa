import 'package:atm_app/const.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

getLessonIcon({required String fileExtension}) {
  if (['.jpg', '.jpeg', '.png', '.gif'].contains(fileExtension.toLowerCase())) {
    // Preview image
    return const FaIcon(FontAwesomeIcons.image, color: kPrimaryColor);
    return const Icon(
      Icons.image,
      color: kPrimaryColor,
    );
  } else if (['.mp4', '.mov', '.avi'].contains(fileExtension.toLowerCase())) {
    // Show video thumbnail
    return const FaIcon(FontAwesomeIcons.video, color: kPrimaryColor);
    return const Icon(
      Icons.video_call,
      color: kPrimaryColor,
    );
  } else {
    // Show file name for unsupported types
    return const FaIcon(FontAwesomeIcons.filePdf, color: kPrimaryColor);
    return const Icon(
      Icons.picture_as_pdf_outlined,
      color: kPrimaryColor,
    );
  }
}
