import 'package:atm_app/core/utils/app_route.dart';
import 'package:atm_app/core/widgets/custom_action_button_type2.dart';
import 'package:cross_file/cross_file.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../../core/const/app_const.dart';
import '../../manager/add_file_lesson_cubit/add_file_lesson_cubit.dart';

class UploadFileLessonButtonBuilder extends StatelessWidget {
  final TextEditingController lessonContent;
  final XFile filePath;

  const UploadFileLessonButtonBuilder({
    super.key,
    required this.lessonContent,
    required this.filePath,
  });

  @override
  Widget build(BuildContext context) {
    // log('the file path is ${file?.path}');
    return BlocBuilder<AddFileLessonCubit, AddFileLessonState>(
      builder: (context, state) {
        return CustomActionButtonType2(
            isLoading: state is AddFileLessonLoading ? true : false,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            onPressed: () {
              context.go(AppRouter.uploadPage);
              /*final addLessonBloc = context.read<AddLessonCubit>();
              final lesson = _toLessonEnitiy(addLessonCubit: addLessonBloc);
              BlocProvider.of<AddFileLessonCubit>(context).startUpload(
                file: filePath,
                uri: projectUrl,
                lesson: lesson,
              );*/
            },
            backGroundColor: kPrimaryColor,
            icon: const FaIcon(
              FontAwesomeIcons.upload,
              color: Colors.white,
            ),
            title: 'تحميل');
      },
    );
  }
}
