import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hikaron/source/repository/PutAwayRepository.dart';
import 'package:meta/meta.dart';

part 'scan_qr_rack_state.dart';

class ScanQrRackCubit extends Cubit<ScanQrRackState> {
  final PutAwayRepository? repository;
  ScanQrRackCubit({this.repository}) : super(ScanQrRackInitial());

  void scanQr(rack_code, context) async {
    emit(ScanQrRackLoading());
    String? barcodeScanRes;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode('#ff6666', 'Cancel', true, ScanMode.QR);
      print('Result Scan:  $barcodeScanRes');
      // if (barcodeScanRes != '-1') {
        repository!.getDataQRRackPutAway(rack_code, barcodeScanRes, context).then((value) {
          var statusCode = value.statusCode;
          var json = value.body;
          print("RackScan: $json");
          print("status: $statusCode");
          if (value.statusCode == 200) {
            var json = jsonDecode(value.body);
            emit(ScanQrRackLoaded(json: json, statusCode: value.statusCode));
          } else if (value.statusCode == 401) {
            emit(ScanQrRackLoaded(json: {'message': 'Unauthorized'}, statusCode: value.statusCode));
          } else {
            var json = jsonDecode(value.body);
            emit(ScanQrRackLoaded(json: json, statusCode: value.statusCode));
          }
        });
      // } else {
      //   EasyLoading.dismiss();
      // }
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }
  }
}
