part of 'return_type_cubit.dart';

@immutable
sealed class ReturnTypeState {}

final class ReturnTypeInitial extends ReturnTypeState {}

final class ReturnTypeLoading extends ReturnTypeState {}

final class ReturnTypeFailed extends ReturnTypeState {
  final int? statusCode;
  final dynamic json;

  ReturnTypeFailed({required this.statusCode, required this.json});
}

final class ReturnTypeLoaded extends ReturnTypeState {
  final int? statusCode;
  final List<ModelReturnTypeList>? model;

  ReturnTypeLoaded({required this.statusCode, required this.model});
}
