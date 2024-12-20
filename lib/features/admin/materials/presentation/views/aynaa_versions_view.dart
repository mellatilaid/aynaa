import 'package:atm_app/features/admin/materials/domain/repos/materials_repo.dart';
import 'package:atm_app/features/admin/materials/presentation/manager/creata_new_aynaa_version_cubit/create_new_aynaa_version_cubit.dart';
import 'package:atm_app/features/admin/materials/presentation/views/widgets/add_new_aynaa_version_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/set_up_service_locator.dart';
import 'widgets/aynaa_versions_view_body.dart';

class AynaaVersionsView extends StatelessWidget {
  const AynaaVersionsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          CreateNewAynaaVersionCubit(getit.get<MaterialsRepo>()),
      child: Scaffold(
        body: const AynaaVersionsViewBody(),
        floatingActionButton: FloatingActionButton.small(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          onPressed: () {
            showDialog(
                context: context,
                builder: (context) {
                  return const AddAynaaVersionAlertDialog();
                });
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
