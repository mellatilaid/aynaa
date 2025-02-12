import 'package:atm_app/core/entities/entitiy.dart';
import 'package:atm_app/core/functions/build_preview.dart';
import 'package:atm_app/core/helper/user_profile.dart';
import 'package:flutter/material.dart';

import '../../../../const/remote_db_const.dart';

class CustomSubjectCard extends StatelessWidget {
  final Entity item;
  final VoidCallback? onTap; // Action when the card is tapped
  final VoidCallback? onDelete;
  const CustomSubjectCard({
    super.key,
    required this.item,
    this.onTap,
    this.onDelete,
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
            (globalUserRole != null && globalUserRole == kAdminRole)
                ? Positioned(
                    top: 0,
                    left: 0,
                    child: IconButton(
                        onPressed: onDelete,
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.red,
                        )),
                  )
                : const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
