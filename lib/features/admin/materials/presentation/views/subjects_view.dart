import 'package:atm_app/features/admin/materials/domain/entities/aynaa_versions_entity.dart';
import 'package:atm_app/features/admin/materials/presentation/views/widgets/add_new_subject_bottom_sheet.dart';
import 'package:flutter/material.dart';

import 'widgets/subject_view_body.dart';

class SubjectsView extends StatelessWidget {
  final AynaaVersionsEntity aynaaVersionsEntity;
  const SubjectsView({super.key, required this.aynaaVersionsEntity});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(aynaaVersionsEntity.versionName.toString()),
      ),
      body: const SubjectsViewBody(),
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        onPressed: () {
          showModalBottomSheet(
              isScrollControlled: true,
              context: context,
              builder: (context) {
                return const NewSubjectBottomSheet();
              });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
