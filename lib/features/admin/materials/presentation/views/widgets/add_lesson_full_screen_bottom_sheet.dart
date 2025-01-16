import 'package:atm_app/features/admin/materials/presentation/views/widgets/add_lesson_button_sheet_body.dart';
import 'package:flutter/material.dart';

class AddLessonBottomSheet extends StatelessWidget {
  const AddLessonBottomSheet({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const FractionallySizedBox(
      heightFactor:
          0.8, // Adjust this for the height you need (e.g., 90% of the screen)
      child: AddLessonBottomSheetBody(),
    );
  }
}

class LessonMediaContent extends StatelessWidget {
  const LessonMediaContent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      color: Colors.grey[300],
      child: const Center(child: Text('Other Content Goes Here')),
    );
  }
}
