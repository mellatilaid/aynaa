import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../../../core/const/app_const.dart';
import '../../../../../../core/widgets/custom_rounded_button_with_title.dart';
import '../../manager/pick_file_cubit/pick_file_cubit.dart';

class UploadMediaSection extends StatelessWidget {
  const UploadMediaSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: RoundedButtonWithTitle(
        icon: const FaIcon(
          FontAwesomeIcons.fileCirclePlus,
          size: 28,
          color: kPrimaryColor,
        ),
        iconName: 'ملف',
        onTap: () async {
          BlocProvider.of<PickFileCubit>(context).pickFile();
        },
      ),
    );
    /*return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        RoundedButtonWithTitle(
          icon: Icons.file_copy,
          iconName: 'ملف',
          onTap: () async {
            BlocProvider.of<PickFileCubit>(context).pickFile();
          },
        ),
        RoundedButtonWithTitle(
          icon: Icons.image,
          iconName: 'صورة',
          onTap: () async {},
        ),
        RoundedButtonWithTitle(
          icon: Icons.video_call,
          iconName: 'فيديو',
          onTap: () async {},
        ),
      ],
    );*/
  }
}
