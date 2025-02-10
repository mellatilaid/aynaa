import 'package:atm_app/core/classes/pick_file.dart';
import 'package:atm_app/core/utils/set_up_service_locator.dart';
import 'package:atm_app/core/widgets/scaffold_message.dart';
import 'package:atm_app/features/admin/materials/domain/repos/versions_repo.dart';
import 'package:atm_app/features/admin/materials/presentation/manager/creata_new_aynaa_version_cubit/create_new_aynaa_version_cubit.dart';
import 'package:atm_app/features/admin/materials/presentation/manager/fetch_aynaa_versions_cubit/fetch_aynaa_versions_cubit.dart';
import 'package:atm_app/features/admin/materials/presentation/manager/pick_file_cubit/pick_file_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'add_new_aynaa_version_bottom_sheet_body.dart';

class AddAynaaVersionBottomSheet extends StatelessWidget {
  const AddAynaaVersionBottomSheet({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              CreateNewAynaaVersionCubit(getit.get<VersionsRepo>()),
        ),
        BlocProvider(
          create: (context) => PickFileCubit(getit.get<FilePickerHelper>()),
        ),
      ],
      child:
          BlocListener<CreateNewAynaaVersionCubit, CreateNewAynaaVersionState>(
        listener: (context, state) {
          if (state is CreateNewAynaaVersionSuccess) {
            BlocProvider.of<FetchAynaaVersionsCubit>(context)
                .fetchAynaaVersions();
            Future.microtask(() {
              if (!context.mounted) return;
              context.pop();
            });
          } else if (state is CreateNewAynaaVersionFailure) {
            Navigator.pop(context);
            showScaffoldMessage(context, state.errMessage);
          }
        },
        child: const AddVersionBottomSheetBody(),
      ),
    );
  }
}
