import 'package:atm_app/features/admin/materials/domain/entities/aynaa_versions_entity.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'fetch_aynaa_versions_state.dart';

class FetchAynaaVersionsCubit extends Cubit<FetchAynaaVersionsState> {
  FetchAynaaVersionsCubit() : super(FetchAynaaVersionsInitial());
}
