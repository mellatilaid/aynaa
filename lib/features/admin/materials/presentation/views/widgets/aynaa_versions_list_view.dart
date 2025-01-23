import 'package:atm_app/features/admin/materials/domain/entities/aynaa_versions_entity.dart';
import 'package:atm_app/features/admin/materials/presentation/manager/add_text_lesson_cubit/add_lesson_cubit.dart';
import 'package:atm_app/features/admin/materials/presentation/views/widgets/custom_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../core/utils/app_route.dart';

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
            onTap: () {
              context.push(AdminAppRouter.versionSubjectsView,
                  extra: aynaaVersions[index]);
              BlocProvider.of<AddLessonCubit>(context).setVersionIDAndName(
                  aynaaVersions[index].id, aynaaVersions[index].name);
            },
            child: CustomCard(
              entity: aynaaVersions[index],
            ),
          );
        });
  }
}
