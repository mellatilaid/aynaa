import 'package:atm_app/core/const/local_db_const.dart';
import 'package:atm_app/core/services/local_db_service/i_local_db_service.dart';
import 'package:atm_app/core/widgets/empty_widget.dart';
import 'package:atm_app/core/widgets/loading_widget.dart';
import 'package:atm_app/core/widgets/no_internet_widget.dart';
import 'package:atm_app/features/common/versions/domain/entities/lesson_entity.dart';
import 'package:atm_app/features/common/versions/domain/entities/subjects_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../core/utils/set_up_service_locator.dart';
import '../../manager/add_text_lesson_cubit/lesson_cubit.dart';
import '../../manager/fetch_lessons_cubit/fetch_lessons_cubit.dart';
import 'lessons_list_view.dart';

class LessonsViewBody extends StatefulWidget {
  final SubjectsEntity subjectsEntity;
  const LessonsViewBody({super.key, required this.subjectsEntity});

  @override
  State<LessonsViewBody> createState() => _LessonsViewBodyState();
}

class _LessonsViewBodyState extends State<LessonsViewBody> {
  late String versionID;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    versionID = _getVersionID();
    if (0 == 0) {
      BlocProvider.of<FetchLessonsCubit>(context).fetchLessons(
          subjectID: widget.subjectsEntity.entityID, versionID: versionID);
    } else {
      getit.get<ILocalDbService>().clear<LessonEntity>();
    }
    /* */
  }

  _getVersionID() {
    final versionID = context.read<LessonCubit>().versionID;
    return versionID!;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FetchLessonsCubit, FetchLessonsState>(
      builder: (context, state) {
        if (state is FetchLessonsSuccess) {
          if (state.lessons.isEmpty) {
            return const EmptyWidget();
          }
          return LessonsListView(lessons: state.lessons);
        } else if (state is FetchLessonsLoading) {
          return const LoadingWidget();
        } else if (state is FetchLessonsFailure) {
          if (state.errMessage == kNoInternetMessage) {
            return NoInternetWidget(
                onTap: () => BlocProvider.of<FetchLessonsCubit>(context)
                    .fetchLessons(
                        subjectID: widget.subjectsEntity.entityID,
                        versionID: versionID));
          }
          return ErrorWidget(state.errMessage);
        }
        return Container();
      },
    );
  }
}
