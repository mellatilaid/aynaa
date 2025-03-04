import 'package:atm_app/core/functions/build_preview.dart';
import 'package:atm_app/core/helper/user_profile.dart';
import 'package:atm_app/core/materials/domain/entities/lesson_entity.dart';
import 'package:atm_app/core/widgets/three_dots_menu.dart';
import 'package:flutter/material.dart';

import '../../../../const/remote_db_const.dart';

class CustomLessonCard extends StatefulWidget {
  final LessonEntity item;
  final VoidCallback onDelete;
  final VoidCallback onEdit;
  final VoidCallback onTap;
  const CustomLessonCard(
      {super.key,
      required this.item,
      required this.onDelete,
      required this.onEdit,
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
              (globalUserRole != null && globalUserRole == kAdminRole)
                  ? Positioned(
                      top: 9,
                      left: 15,
                      child: ThreeDotsMenu(
                        onDelete: widget.onDelete,
                        onEdit: widget.onEdit,
                        popItems: [
                          genericPopUpMenuItem(
                            value: 'تعديل',
                            icon: const Icon(Icons.edit, color: Colors.blue),
                          ),
                          genericPopUpMenuItem(
                            value: 'حذف',
                            icon: const Icon(Icons.delete, color: Colors.red),
                          ),
                        ],
                      ),
                    )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }
}
