import 'package:atm_app/core/shared_features/exams/presentation/views/widgets/exams_list_view.dart';
import 'package:flutter/widgets.dart';

class ExamsViewBody extends StatelessWidget {
  const ExamsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const ExamsListView(exams: []);
  }
}
