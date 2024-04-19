part of 'getdataqr_cubit.dart';

@immutable
sealed class GetdataqrState {}

final class GetdataqrInitial extends GetdataqrState {}

final class GetdataqrLoading extends GetdataqrState {}

final class GetdataqrLoaded extends GetdataqrState {
  final int? statusCode;
  final dynamic json;

  GetdataqrLoaded({required this.statusCode, required this.json});
}
