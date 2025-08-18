part of 'return_cubit.dart';

@immutable
sealed class ReturnState {}

final class ReturnInitial extends ReturnState {}

final class EntryReturnLoading extends ReturnState {}

final class EntryReturnLoaded extends ReturnState {
  final int? statusCode;
  final dynamic json;

  EntryReturnLoaded({required this.statusCode, required this.json});
}
