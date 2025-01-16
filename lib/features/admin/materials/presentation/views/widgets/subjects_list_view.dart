import 'package:atm_app/features/admin/materials/presentation/views/widgets/custom_card.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../core/utils/app_route.dart';
import '../../../domain/entities/subjects_entity.dart';

class SubjectsListView extends StatelessWidget {
  final List<SubjectsEntity> subjects;
  const SubjectsListView({super.key, required this.subjects});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: subjects.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () => context.push(
            AdminAppRouter.lessonsView,
          ),
          child: CustomCard(entity: subjects[index]),
        );
      },
    );
  }
}
