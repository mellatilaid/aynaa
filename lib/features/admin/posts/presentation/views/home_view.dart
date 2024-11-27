import 'package:atm_app/features/admin/posts/presentation/views/widgets/home_view_body.dart';
import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const HomeViewBody(),
      floatingActionButton: FloatingActionButton(onPressed: () {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true, // Allows it to take up the full height
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
          ),
          builder: (context) {
            return const FullScreenBottomSheet();
          },
        );
      }),
    );
  }
}

class FullScreenBottomSheet extends StatelessWidget {
  const FullScreenBottomSheet({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      heightFactor:
          0.9, // Adjust this for the height you need (e.g., 90% of the screen)
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(8.0),
            width: 40,
            height: 5,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(2.5),
            ),
          ),
          const Expanded(
            child: Center(
              child: Text('This is a full-screen bottom sheet'),
            ),
          ),
        ],
      ),
    );
  }
}
