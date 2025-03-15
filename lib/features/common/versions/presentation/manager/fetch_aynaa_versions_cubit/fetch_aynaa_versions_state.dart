part of 'fetch_aynaa_versions_cubit.dart';

@immutable
sealed class FetchAynaaVersionsState {}

final class FetchAynaaVersionsInitial extends FetchAynaaVersionsState {}

final class FetchNoInternetState extends FetchAynaaVersionsState {}

final class FetchAynaaVersionsLoading extends FetchAynaaVersionsState {}

final class FetchAynaaVersionsFailure extends FetchAynaaVersionsState {
  final String errMessage;
  FetchAynaaVersionsFailure({required this.errMessage});
}

final class FetchAynaaVersionsSucuss extends FetchAynaaVersionsState {
  final List<AynaaVersionsEntity> aynaaVersions;
  FetchAynaaVersionsSucuss({required this.aynaaVersions});
}
