import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/widgets/custom_rounded_button_with_title.dart';
import '../../manager/pick_file_cubit/pick_file_cubit.dart';

class UploadMediaSection extends StatelessWidget {
  const UploadMediaSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        RoundedButtonWithTitle(
          iconData: Icons.file_copy,
          iconName: 'ملف',
          onTap: () async {
            BlocProvider.of<PickFileCubit>(context).pickFile();
          },
        ),
        RoundedButtonWithTitle(
          iconData: Icons.image,
          iconName: 'صورة',
          onTap: () async {},
        ),
        RoundedButtonWithTitle(
          iconData: Icons.video_call,
          iconName: 'فيديو',
          onTap: () async {},
        ),
      ],
    );
  }
}
