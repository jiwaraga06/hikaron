part of 'do_list_cubit.dart';

@immutable
abstract class DoListState {}

class DoListInitial extends DoListState {}

class DoListLoading extends DoListState {}

class DoListLoaded extends DoListState {
  final int? statusCode;
  dynamic json;

  DoListLoaded({this.statusCode, this.json});
}
