import 'dart:developer';

import 'package:atm_app/features/common/versions/domain/entities/subjects_entity.dart';
import 'package:atm_app/features/common/versions/presentation/views/widgets/add_new_subject_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../../core/utils/app_route.dart';
import '../../manager/add_text_lesson_cubit/lesson_cubit.dart';
import '../../manager/delete_subject_cubit/delete_subject_cubit.dart';
import '../../manager/fetch_subjects_cubit/fetch_subject_cubit.dart';
import 'custom_subject_card.dart';

class SubjectsListView extends StatelessWidget {
  final List<SubjectsEntity> subjects;
  const SubjectsListView({super.key, required this.subjects});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: subjects.length,
      itemBuilder: (context, index) {
        log('subject id is ${subjects[index].entityID}');
        return GestureDetector(
          onTap: () {
            context.push(
              AppRouter.lessonsView,
              extra: subjects[index],
            );
            log(subjects[index].entityID);
            BlocProvider.of<LessonCubit>(context).setSubjectIDAndName(
              subjects[index].entityID,
              subjects[index].name,
            );
          },
          child: CustomSubjectCard(
            onDelete: () =>
                BlocProvider.of<DeleteSubjectCubit>(context).deleteSubject(
              subject: subjects[index],
            ),
            onEdit: () {
              final fetchSucjectsCubit = context.read<FetchSubjectCubit>();
              showModalBottomSheet(
                  isScrollControlled: true,
                  context: context,
                  builder: (context) {
                    return NewSubjectBottomSheet(
                      fetchSubjectsCubit: fetchSucjectsCubit,
                      isEditMode: true,
                      subjectsEntity: subjects[index],
                    );
                  });
            },
            item: subjects[index],
          ),
        );
      },
    );
  }
}

class SubjectCard extends StatelessWidget {
  final String imageUrl; // URL of the subject image
  final String title; // Title of the subject
  final VoidCallback? onTap; // Action when the card is tapped

  const SubjectCard({
    super.key,
    required this.imageUrl,
    required this.title,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Subject Image
            ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(12)),
              child: Image.network(
                'https://www.bing.com/th?id=OIP.HW9o-gKESImEapaUq7WbIgHaJQ&w=98&h=106&c=8&rs=1&qlt=90&o=6&dpr=1.3&pid=3.1&rm=2',
                height: 120,
                width: double.infinity,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Center(
                    child: CircularProgressIndicator(
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                              (loadingProgress.expectedTotalBytes ?? 1)
                          : null,
                    ),
                  );
                },
                errorBuilder: (context, error, stackTrace) => const Icon(
                  Icons.broken_image,
                  size: 80,
                  color: Colors.grey,
                ),
              ),
            ),

            // Subject Title
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
