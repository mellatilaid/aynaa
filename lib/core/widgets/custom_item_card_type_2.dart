import 'package:atm_app/core/entities/entitiy.dart';
import 'package:flutter/material.dart';

import '../functions/build_preview.dart';

class CustomItemCardType2 extends StatefulWidget {
  final Entity item;
  const CustomItemCardType2({super.key, required this.item});

  @override
  State<CustomItemCardType2> createState() => _CustomItemCardType2State();
}

class _CustomItemCardType2State extends State<CustomItemCardType2> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Display image or placeholder
              SizedBox(
                width: double.infinity,
                child: buildPreview(filePath: widget.item.localFilePath),
              ),
              const SizedBox(height: 16),
              // Display description
              if (widget.item.name != null)
                Text(
                  widget.item.name!,
                  textAlign: TextAlign.start,
                  style: const TextStyle(fontSize: 14),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
