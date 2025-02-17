import 'package:flutter/material.dart';

import 'widgets/test_view_body.dart';

class TestView extends StatelessWidget {
  const TestView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
      ),
      body: const TestViewBody(),
    );
  }
}
