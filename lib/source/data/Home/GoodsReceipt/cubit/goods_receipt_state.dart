part of 'goods_receipt_cubit.dart';

@immutable
sealed class GoodsReceiptState {}

final class GoodsReceiptInitial extends GoodsReceiptState {}

final class GoodsReceiptLoading extends GoodsReceiptState {}

final class GoodsReceiptLoaded extends GoodsReceiptState {
  final int? statusCode;
  dynamic json;

  GoodsReceiptLoaded({required this.statusCode, required this.json});
}
