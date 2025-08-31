part of 'insert_put_away_cubit.dart';

@immutable
sealed class InsertPutAwayState {}

final class InsertPutAwayInitial extends InsertPutAwayState {}

final class InsertPutAwayLoading extends InsertPutAwayState {}

final class InsertPutAwayLoaded extends InsertPutAwayState {
  final int? statusCode;
  final dynamic json;

  InsertPutAwayLoaded({required this.statusCode, required this.json});
}
