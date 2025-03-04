import 'package:atm_app/core/widgets/custom_text_button.dart';
import 'package:flutter/material.dart';

class NoInternetWidget extends StatelessWidget {
  final VoidCallback onTap;
  const NoInternetWidget({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text('لا يوجد اتصال بالشبكة اتصل بالشبكة و أعد المحاولة'),
          const SizedBox(
            height: 16,
          ),
          CustomTextButton(
            title: 'أعد المحاولة',
            onPressed: onTap,
            icon: const Icon(Icons.repeat),
            width: null,
          ),
        ],
      ),
    );
  }
}
