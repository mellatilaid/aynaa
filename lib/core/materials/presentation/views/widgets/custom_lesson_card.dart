import 'package:atm_app/core/functions/build_preview.dart';
import 'package:atm_app/core/materials/domain/entities/lesson_entity.dart';
import 'package:flutter/material.dart';

class CustomLessonCard extends StatefulWidget {
  final LessonEntity item;
  final VoidCallback onDelete;
  final VoidCallback onTap;
  const CustomLessonCard(
      {super.key,
      required this.item,
      required this.onDelete,
      required this.onTap});

  @override
  State<CustomLessonCard> createState() => _CustomLessonCardState();
}

class _CustomLessonCardState extends State<CustomLessonCard> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Card(
          elevation: 5,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Display image or placeholder
                    SizedBox(
                      width: double.infinity,
                      child: buildPreview(filePath: widget.item.localFilePath),
                    ),
                    const SizedBox(height: 16),
                    // Display description
                    Text(
                      widget.item.name,
                      textAlign: TextAlign.start,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 0,
                left: 0,
                child: IconButton(
                    onPressed: widget.onDelete,
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.red,
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
