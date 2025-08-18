part of 'stock_opname_cubit.dart';

@immutable
abstract class StockOpnameState {}

class StockOpnameInitial extends StockOpnameState {}

class StockOpnameLoading extends StockOpnameState {}

class StockOpnameLoaded extends StockOpnameState {
  final int? statusCode;
  dynamic json;

  StockOpnameLoaded({this.statusCode, this.json});
}

class StockBarangLoading extends StockOpnameState {}

class StockBarangLoaded extends StockOpnameState {
  final int? statusCode;
  dynamic json;

  StockBarangLoaded({this.statusCode, this.json});
}

class EntryStockLoading extends StockOpnameState {}

class EntryStockLoaded extends StockOpnameState {
  final int? statusCode;
  dynamic json;

  EntryStockLoaded({this.statusCode, this.json});
}
