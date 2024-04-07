part of 'getissue_code_cubit.dart';

@immutable
sealed class GetissueCodeState {}

final class GetissueCodeInitial extends GetissueCodeState {}

final class GetissueCodeLoading extends GetissueCodeState {}

final class GetissueCodeLoaded extends GetissueCodeState {
  final int? statusCode;
  dynamic json;

  GetissueCodeLoaded({required this.statusCode, required this.json});
}

final class GetissueCodeScanLoading extends GetissueCodeState {}

final class GetissueCodeScanLoaded extends GetissueCodeState {
  final int? statusCode;
  dynamic json;

  GetissueCodeScanLoaded({required this.statusCode, required this.json});
}

final class GetissueCodeEntryLoading extends GetissueCodeState {}

final class GetissueCodeEntryLoaded extends GetissueCodeState {
  final int? statusCode;
  dynamic json;

  GetissueCodeEntryLoaded({required this.statusCode, required this.json});
}
