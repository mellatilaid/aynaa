import 'package:atm_app/features/admin/materials/presentation/manager/fetch_aynaa_versions_cubit/fetch_aynaa_versions_cubit.dart';
import 'package:atm_app/features/admin/materials/presentation/views/widgets/add_new_aynaa_version_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/set_up_service_locator.dart';
import '../../domain/repos/materials_repo.dart';
import 'widgets/aynaa_versions_view_body.dart';

class AynaaVersionsView extends StatelessWidget {
  const AynaaVersionsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FetchAynaaVersionsCubit(getit.get<MaterialsRepo>()),
      child: Scaffold(
        body: const AynaaVersionsViewBody(),
        floatingActionButton: Builder(builder: (fabContext) {
          return FloatingActionButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
            onPressed: () {
              final aynaaVersionCubit =
                  fabContext.read<FetchAynaaVersionsCubit>();
              showDialog(
                  context: context,
                  builder: (context) {
                    return BlocProvider.value(
                      value: aynaaVersionCubit,
                      child: const AddAynaaVersionAlertDialog(),
                    );
                  });
            },
            child: const Icon(Icons.add),
          );
        }),
      ),
    );
  }
}
