import 'package:atm_app/core/utils/set_up_service_locator.dart';
import 'package:atm_app/core/widgets/scaffold_message.dart';
import 'package:atm_app/features/admin/materials/domain/repos/versions_repo.dart';
import 'package:atm_app/features/admin/materials/presentation/manager/creata_new_aynaa_version_cubit/create_new_aynaa_version_cubit.dart';
import 'package:atm_app/features/admin/materials/presentation/manager/fetch_aynaa_versions_cubit/fetch_aynaa_versions_cubit.dart';
import 'package:atm_app/features/admin/materials/presentation/views/widgets/add_new_aynaa_version_dialog_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddAynaaVersionAlertDialog extends StatelessWidget {
  const AddAynaaVersionAlertDialog({
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
      ],
      child:
          BlocListener<CreateNewAynaaVersionCubit, CreateNewAynaaVersionState>(
        listener: (context, state) {
          if (state is CreateNewAynaaVersionSuccess) {
            Navigator.pop(context);
            BlocProvider.of<FetchAynaaVersionsCubit>(context)
                .fetchAynaaVersions();
          } else if (state is CreateNewAynaaVersionFailure) {
            Navigator.pop(context);
            showScaffoldMessage(context, state.errMessage);
          }
        },
        child: const AddAynaaVersionAlertDialogBody(),
      ),
    );
  }
}
