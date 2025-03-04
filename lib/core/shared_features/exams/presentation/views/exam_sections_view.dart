import 'package:atm_app/core/const/remote_db_const.dart';
import 'package:atm_app/core/services/local_db_service/i_local_db_service.dart';
import 'package:atm_app/core/services/profile_storage.dart';
import 'package:atm_app/core/shared_features/exams/domain/entities/exam_entity.dart';
import 'package:atm_app/core/shared_features/exams/domain/repos/exam_sections_repo.dart';
import 'package:atm_app/core/shared_features/exams/presentation/manager/exam_section_cubit/exam_section_cubit.dart';
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
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => FetchExamSectionsCubit(
            examSectionsRepo: getit.get<ExamSectionsRepo>(),
            iLocalDBService: getit.get<ILocalDbService>(),
          ),
        ),
        BlocProvider(
          create: (context) => ExamSectionCubit(
            examSectionsRepo: getit.get<ExamSectionsRepo>(),
          ),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          leading: const BackButton(),
        ),
        body: ExamSectionsViewBody(
          examEntity: examEntity,
        ),
        floatingActionButton: (ProfileStorageImpl.userRole == kAdminRole)
            ? Builder(
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
                              child: AddExamSectionBottomSheet(
                                fetchExamSectionsCubit: fetchSectionsCubit,
                              ),
                            );
                          });
                    },
                    child: const Icon(Icons.add),
                  );
                },
              )
            : null,
      ),
    );
  }
}
