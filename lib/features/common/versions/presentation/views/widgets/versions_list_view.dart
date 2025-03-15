import 'package:atm_app/features/common/versions/domain/entities/aynaa_versions_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../../core/utils/app_route.dart';
import '../../manager/add_text_lesson_cubit/lesson_cubit.dart';
import '../../manager/delete_version_cubit/delete_version_cubit.dart';
import 'custom_version_card.dart';

class VersionListView extends StatelessWidget {
  final List<AynaaVersionsEntity> aynaaVersions;
  const VersionListView({
    super.key,
    required this.aynaaVersions,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: aynaaVersions.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              context.push(AppRouter.versionSubjectsView,
                  extra: aynaaVersions[index]);
              BlocProvider.of<LessonCubit>(context).setVersionIDAndName(
                  aynaaVersions[index].entityID, aynaaVersions[index].name);
            },
            child: CustomVersionCard(
              onEdit: () {},
              onDelete: () {
                BlocProvider.of<DeleteVersionCubit>(context).deleteVersion(
                  aynaaVersion: aynaaVersions[index],
                );
              },
              item: aynaaVersions[index],
            ),
          );
        });
  }
}
