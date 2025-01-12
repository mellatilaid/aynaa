import 'package:atm_app/features/admin/materials/domain/entities/aynaa_versions_entity.dart';
import 'package:flutter/material.dart';

class AynaaVersionCard extends StatelessWidget {
  final AynaaVersionsEntity aynaaVersionsEntity;
  const AynaaVersionCard({
    super.key,
    required this.aynaaVersionsEntity,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.all(10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.blue,
        ),
        height: 200,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(aynaaVersionsEntity.versionName.toString()),
              Text(aynaaVersionsEntity.id),
            ],
          ),
        ),
      ),
    );
  }
}
