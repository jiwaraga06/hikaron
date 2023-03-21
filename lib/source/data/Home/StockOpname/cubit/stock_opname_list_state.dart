part of 'stock_opname_list_cubit.dart';

@immutable
abstract class StockOpnameListState {}

class StockOpnameListInitial extends StockOpnameListState {}

class StockOpnameListLoading extends StockOpnameListState {}

class StockOpnameListLoaded extends StockOpnameListState {
  final int? statusCode;
  dynamic json;

  StockOpnameListLoaded({this.statusCode, this.json});
}
