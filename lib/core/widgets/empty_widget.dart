import 'package:flutter/widgets.dart';

class EmptyWidget extends StatelessWidget {
  const EmptyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('No Data'),
    );
  }
}
