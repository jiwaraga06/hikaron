part of 'do_realization_cubit.dart';

@immutable
abstract class DoRealizationState {}

class DoRealizationInitial extends DoRealizationState {}

class DoOpnameLoading extends DoRealizationState {}

class DoOpnameLoaded extends DoRealizationState {
  final int? statusCode;
  dynamic json;
  DoOpnameLoaded({this.statusCode, this.json});
}

class DoBarangLoading extends DoRealizationState {}

class DoBarangLoaded extends DoRealizationState {
  final int? statusCode;
  dynamic json;

  DoBarangLoaded({this.statusCode, this.json});
}

class EntryDoLoading extends DoRealizationState {}

class EntryDoLoaded extends DoRealizationState {
  final int? statusCode;
  dynamic json;

  EntryDoLoaded({this.statusCode, this.json});
}
