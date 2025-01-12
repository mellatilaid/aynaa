import 'package:atm_app/features/admin/materials/domain/entities/aynaa_versions_entity.dart';
import 'package:flutter/material.dart';

import 'widgets/aynaa_version_subject_view_body.dart';

class AynaaVersionSubjectsView extends StatelessWidget {
  final AynaaVersionsEntity aynaaVersionsEntity;
  const AynaaVersionSubjectsView(
      {super.key, required this.aynaaVersionsEntity});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(aynaaVersionsEntity.versionName.toString()),
        ),
        body: const AynaaVersionSubjectsViewBody());
  }
}
