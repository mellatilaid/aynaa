import 'package:atm_app/core/const/remote_db_const.dart';
import 'package:atm_app/core/helper/user_profile.dart';
import 'package:atm_app/core/materials/presentation/views/widgets/add_new_aynaa_version_bottom_sheet.dart';
import 'package:atm_app/core/materials/presentation/views/widgets/sign_out_button_bloc_builder.dart';
import 'package:atm_app/core/services/local_d_b_service.dart';
import 'package:atm_app/features/admin/materials/presentation/manager/delete_version_cubit/delete_version_cubit.dart';
import 'package:atm_app/features/admin/materials/presentation/manager/fetch_aynaa_versions_cubit/fetch_aynaa_versions_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/materials/domain/repos/versions_repo.dart';
import '../../../../../core/utils/set_up_service_locator.dart';
import 'widgets/aynaa_versions_view_body.dart';

class VersionsView extends StatelessWidget {
  const VersionsView({super.key});

//FetchAynaaVersionsCubit(getit.get<MaterialsRepo>())
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => FetchAynaaVersionsCubit(
            getit.get<VersionsRepo>(),
            getit.get<LocalDBService>(),
          ),
        ),
        BlocProvider(
          create: (context) => DeleteVersionCubit(
            versionsRepo: getit.get<VersionsRepo>(),
          ),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          leading: const SignOutButtonBlocBuilder(),
        ),
        body: const AynaaVersionsViewBody(),
        floatingActionButton:
            (globalUserRole != null && globalUserRole == kAdminRole)
                ? Builder(
                    builder: (fabContext) {
                      return FloatingActionButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                        onPressed: () {
                          final aynaaVersionCubit =
                              fabContext.read<FetchAynaaVersionsCubit>();
                          showModalBottomSheet(
                              isScrollControlled: true,
                              context: context,
                              builder: (context) {
                                return BlocProvider.value(
                                  value: aynaaVersionCubit,
                                  child: const AddAynaaVersionBottomSheet(),
                                );
                              });
                          /*showDialog(
                  context: context,
                  builder: (context) {
                    return BlocProvider.value(
                      value: aynaaVersionCubit,
                      child: const AddAynaaVersionAlertDialog(),
                    );
                  });*/
                        },
                        child: const Icon(Icons.add),
                      );
                    },
                  )
                : null,
      ),
    );
    return BlocProvider(
      create: (context) => FetchAynaaVersionsCubit(
        getit.get<VersionsRepo>(),
        getit.get<LocalDBService>(),
      ),
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
                      child: const AddAynaaVersionBottomSheet(),
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
