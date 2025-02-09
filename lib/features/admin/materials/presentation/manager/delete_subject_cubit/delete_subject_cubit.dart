import 'package:atm_app/core/services/delete_items_service.dart';
import 'package:atm_app/features/admin/materials/domain/entities/deleted_itmes_entity.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'delete_subject_state.dart';

class DeleteSubjectCubit extends Cubit<DeleteSubjectState> {
  final DeleteItemsService deleteItemsService;
  DeleteSubjectCubit({required this.deleteItemsService})
      : super(DeleteSubjectInitial());

  Future<void> deleteSubject({required String id}) async {
    emit(DeleteSubjectLoading());
    final deletedItem = DeletedItmesEntity(id, false, false);
    await deleteItemsService.markItemAsDeleted(item: deletedItem);
  }
}
