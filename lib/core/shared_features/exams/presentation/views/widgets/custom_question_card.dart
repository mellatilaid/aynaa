import 'package:atm_app/core/const/remote_db_const.dart';
import 'package:atm_app/core/services/profile_storage.dart';
import 'package:atm_app/core/shared_features/exams/domain/entities/question_entity.dart';
import 'package:atm_app/core/widgets/three_dots_menu.dart';
import 'package:flutter/material.dart';

class QuestionCard extends StatelessWidget {
  final QuestionEntity question;
  final VoidCallback onDelete;
  final VoidCallback onEdit;
  const QuestionCard(
      {super.key,
      required this.question,
      required this.onDelete,
      required this.onEdit});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  question.question,
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16.0),
                ...question.options.map((choice) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: Row(
                        children: [
                          Radio<String>(
                            value: choice,
                            groupValue: question.answer,
                            onChanged: (value) {
                              // Handle choice selection
                            },
                          ),
                          Text(choice),
                        ],
                      ),
                    )),
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
