part of 'racklist_put_away_cubit.dart';

@immutable
sealed class RacklistPutAwayState {}

final class RacklistPutAwayInitial extends RacklistPutAwayState {}

final class RacklistPutAwayLoading extends RacklistPutAwayState {}

final class RacklistPutAwayLoaded extends RacklistPutAwayState {
  final int? statusCode;
  final dynamic? json;

  RacklistPutAwayLoaded({required this.statusCode, required this.json});
}
