import 'dart:developer';

import 'package:atm_app/core/utils/app_route.dart';
import 'package:atm_app/core/widgets/loading_widget.dart';
import 'package:atm_app/features/admin/materials/domain/entities/aynaa_versions_entity.dart';
import 'package:atm_app/features/admin/materials/presentation/manager/fetch_aynaa_versions_cubit/fetch_aynaa_versions_cubit.dart';
import 'package:atm_app/features/admin/materials/presentation/views/widgets/custom_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

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
    BlocProvider.of<FetchAynaaVersionsCubit>(context).fetchAynaaVersions();
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
          log(state.aynaaVersions.last.versionName.toString());
          return AynaaVersionListView(
            aynaaVersions: state.aynaaVersions,
          );
        }
        return Container();
      },
    );
  }
}

class AynaaVersionListView extends StatelessWidget {
  final List<AynaaVersionsEntity> aynaaVersions;
  const AynaaVersionListView({
    super.key,
    required this.aynaaVersions,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: aynaaVersions.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => context.push(AdminAppRouter.versionSubjectsView,
                extra: aynaaVersions[index]),
            child: CustomCard(
              entity: aynaaVersions[index],
            ),
          );
        });
  }
}
