import 'dart:developer';

import 'package:atm_app/features/admin/materials/domain/entities/lesson_entity.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as path;

import '../../../../../../core/functions/get_Icon_by_extension.dart';

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
    // TODO: implement initState
    super.initState();
    baseName =
        (widget.lesson.url != null) ? path.basename(widget.lesson.url!) : null;
    log(baseName ?? 'null');
    fileExtension =
        (widget.lesson.url != null) ? path.extension(widget.lesson.url!) : null;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              (baseName != null)
                  ? ListTile(
                      leading: getLessonIcon(fileExtension: fileExtension!),
                      title: Text(baseName!),
                    )
                  : const SizedBox.shrink(),
              const SizedBox(
                height: 16,
              ),
              Text(
                widget.lesson.description ?? '',
                textAlign: TextAlign.start,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
