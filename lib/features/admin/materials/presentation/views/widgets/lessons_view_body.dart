import 'package:atm_app/core/widgets/loading_widget.dart';
import 'package:atm_app/features/admin/materials/domain/entities/subjects_entity.dart';
import 'package:atm_app/features/admin/materials/presentation/manager/fetch_lessons_cubit/fetch_lessons_cubit.dart';
import 'package:atm_app/features/admin/materials/presentation/views/widgets/lessons_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../manager/add_text_lesson_cubit/add_lesson_cubit.dart';

class LessonsViewBody extends StatefulWidget {
  final SubjectsEntity subjectsEntity;
  const LessonsViewBody({super.key, required this.subjectsEntity});

  @override
  State<LessonsViewBody> createState() => _LessonsViewBodyState();
}

class _LessonsViewBodyState extends State<LessonsViewBody> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final versionID = _getVersionID();
    //getit.get<HiveCache<LessonEntity>>().clear(boxName: kLessonsBox);
    BlocProvider.of<FetchLessonsCubit>(context).fetchLessons(
        subjectID: widget.subjectsEntity.id!, versionID: versionID);
  }

  _getVersionID() {
    final versionID = context.read<AddLessonCubit>().versionID;
    return versionID!;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FetchLessonsCubit, FetchLessonsState>(
      builder: (context, state) {
        if (state is FetchLessonsSuccess) {
          return LessonsListView(lessons: state.lessons);
        } else if (state is FetchLessonsLoading) {
          return const LoadingWidget();
        } else if (state is FetchLessonsFailure) {
          return ErrorWidget(state.errMessage);
        }
        return Container();
      },
    );
  }
}
