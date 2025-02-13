import 'package:atm_app/core/widgets/loading_widget.dart';
import 'package:atm_app/features/admin/materials/presentation/manager/fetch_aynaa_versions_cubit/fetch_aynaa_versions_cubit.dart';
import 'package:atm_app/features/admin/materials/presentation/views/widgets/aynaa_versions_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/helper/enums.dart';
import '../../../../../../core/services/isar_storage_service.dart';
import '../../../../../../core/utils/set_up_service_locator.dart';

class AynaaVersionsViewBody extends StatefulWidget {
  const AynaaVersionsViewBody({super.key});

  @override
  State<AynaaVersionsViewBody> createState() => _AynaaVersionsViewBodyState();
}

class _AynaaVersionsViewBodyState extends State<AynaaVersionsViewBody> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //getit.get<HiveCache<AynaaVersionsEntity>>().clear(boxName: kVersionsBox);
    if (0 == 0) {
      BlocProvider.of<FetchAynaaVersionsCubit>(context).fetchAynaaVersions();
    } else {
      getit.get<IsarStorageService>().clear(
            collentionType: CollentionType.versions,
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FetchAynaaVersionsCubit, FetchAynaaVersionsState>(
      builder: (context, state) {
        if (state is FetchAynaaVersionsLoading) {
          return const LoadingWidget();
        } else if (state is FetchAynaaVersionsFailure) {
          return ErrorWidget(state.errMessage);
        } else if (state is FetchAynaaVersionsSucuss) {
          if (state.aynaaVersions.isEmpty) {
            return const Center(
              child: Text('No Aynaa Versions'),
            );
          }
          return AynaaVersionListView(
            aynaaVersions: state.aynaaVersions,
          );
        }
        return Container();
      },
    );
  }
}
