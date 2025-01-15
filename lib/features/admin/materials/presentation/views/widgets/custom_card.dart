import 'package:atm_app/core/entities/entitiy.dart';
import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  final Entity entity;
  const CustomCard({
    super.key,
    required this.entity,
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
              Text(entity.name.toString()),
              Text(entity.id ?? 'id is null'),
            ],
          ),
        ),
      ),
    );
  }
}