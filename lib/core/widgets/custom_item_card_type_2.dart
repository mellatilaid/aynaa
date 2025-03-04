import 'package:atm_app/core/common/entitiy.dart';
import 'package:flutter/material.dart';

import '../functions/build_preview.dart';

class CustomItemCardType2 extends StatefulWidget {
  final Entity item;
  final VoidCallback onDelete;
  final VoidCallback onTap;
  const CustomItemCardType2(
      {super.key,
      required this.item,
      required this.onDelete,
      required this.onTap});

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
      child: GestureDetector(
        onTap: widget.onTap,
        child: Card(
          elevation: 2,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Stack(
            children: [
              Padding(
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
              Positioned(
                top: 0,
                left: 0,
                child: IconButton(
                    onPressed: widget.onDelete,
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.red,
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
