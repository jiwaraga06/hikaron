part of 'racking_cubit.dart';

@immutable
sealed class RackingState {}

final class RackingInitial extends RackingState {}

final class RackingLoading extends RackingState {}

final class RackingLoaded extends RackingState {
  final int? statusCode;
  dynamic json;

  RackingLoaded({required this.statusCode, required this.json});
}
