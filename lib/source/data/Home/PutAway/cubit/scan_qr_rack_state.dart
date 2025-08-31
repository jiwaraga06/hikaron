part of 'scan_qr_rack_cubit.dart';

@immutable
sealed class ScanQrRackState {}

final class ScanQrRackInitial extends ScanQrRackState {}

final class ScanQrRackLoading extends ScanQrRackState {}

final class ScanQrRackLoaded extends ScanQrRackState {
  final int? statusCode;
  final dynamic json;

  ScanQrRackLoaded({required this.statusCode, required this.json});
}
