import 'package:atm_app/core/common/entitiy.dart';
import 'package:atm_app/core/functions/build_preview.dart';
import 'package:atm_app/core/services/profile_storage.dart';
import 'package:atm_app/core/widgets/three_dots_menu.dart';
import 'package:flutter/material.dart';

import '../../../../../../core/const/remote_db_const.dart';

class CustomSubjectCard extends StatelessWidget {
  final Entity item;
  final VoidCallback? onTap; // Action when the card is tapped
  final VoidCallback onDelete;
  final VoidCallback onEdit;
  const CustomSubjectCard({
    super.key,
    required this.item,
    this.onTap,
    required this.onDelete,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        clipBehavior: Clip.hardEdge,
        child: Stack(
          children: [
            Stack(
              children: [
                buildPreview(filePath: item.localFilePath),
                // Background image

                // Title overlay
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    color: Colors.black.withOpacity(0.6),
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                    child: Text(
                      item.name ?? '',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ],
            ),
            (ProfileStorageImpl.userRole == kAdminRole)
                ? Positioned(
                    top: 9,
                    left: 0,
                    child: ThreeDotsMenu(
                      onDelete: onDelete,
                      onEdit: onEdit,
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
                : const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
