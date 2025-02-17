import 'package:atm_app/core/services/isar_storage_service.dart';
import 'package:atm_app/core/shared_features/exams/domain/entities/exam_entity.dart';
import 'package:atm_app/core/shared_features/exams/domain/repos/exam_sections_repo.dart';
import 'package:atm_app/core/shared_features/exams/presentation/manager/fetch_exam_sections_cubit/fetch_exam_sections_cubit.dart';
import 'package:atm_app/core/shared_features/exams/presentation/views/widgets/add_section_bottom_sheet.dart';
import 'package:atm_app/core/shared_features/exams/presentation/views/widgets/exam_sections_view_body.dart';
import 'package:atm_app/core/utils/set_up_service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class ExamSectionsView extends StatelessWidget {
  final ExamEntity examEntity;
  const ExamSectionsView({super.key, required this.examEntity});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FetchExamSectionsCubit(
        examSectionsRepo: getit.get<ExamSectionsRepo>(),
        isarStorageService: getit.get<IsarStorageService>(),
      )..fetchExams(
          id: examEntity.entityID,
        ),
      child: Scaffold(
        appBar: AppBar(
          leading: const BackButton(),
        ),
        body: const ExamSectionsViewBody(),
        floatingActionButton: Builder(
          builder: (fabContext) {
            return FloatingActionButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
              onPressed: () {
                showModalBottomSheet(
                    isScrollControlled: true,
                    context: context,
                    builder: (context) {
                      final fetchSectionsCubit =
                          fabContext.read<FetchExamSectionsCubit>();
                      return Provider<ExamEntity>(
                        create: (context) => examEntity,
                        child: Provider.value(
                            value: fetchSectionsCubit,
                            child: const AddExamSectionBottomSheet()),
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
        ),
      ),
    );
  }
}


/* showGeneralDialog(
                context: context,
                barrierDismissible: true,
                barrierLabel: "Full Screen Dialog",
                pageBuilder: (context, animation, secondaryAnimation) {
                  return const FullScreenDialog();
                },
                transitionBuilder:
                    (context, animation, secondaryAnimation, child) {
                  return SlideTransition(
                    position: Tween<Offset>(
                            begin: const Offset(0, 1), end: const Offset(0, 0))
                        .animate(animation),
                    child: child,
                  );
                },
              );*/