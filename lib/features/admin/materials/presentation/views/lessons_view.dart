import 'package:atm_app/features/admin/materials/presentation/views/widgets/add_lesson_full_screen_bottom_sheet.dart';
import 'package:flutter/material.dart';

import 'widgets/lessons_view_body.dart';

class LessonsView extends StatelessWidget {
  const LessonsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
      ),
      body: const LessonsViewBody(),
      floatingActionButton: Builder(builder: (fabcontext) {
        // addLessonCubit = fabcontext.read<AddLessonCubit>();
        return FloatingActionButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          child: const Icon(Icons.add),
          onPressed: () {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true, // Allows it to take up the full height
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
              ),
              builder: (context) {
                return const AddLessonBottomSheet();
              },
            );
          },
        );
      }),
    );
  }
}
