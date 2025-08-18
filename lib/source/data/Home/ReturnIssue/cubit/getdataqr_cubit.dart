import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hikaron/source/data/model/modelEntryReturn.dart';
import 'package:hikaron/source/env/env.dart';
import 'package:hikaron/source/repository/ReturnIssue.dart';
import 'package:meta/meta.dart';

part 'getdataqr_state.dart';

class GetdataqrCubit extends Cubit<GetdataqrState> {
  final ReturnIssue? repository;
  GetdataqrCubit({this.repository}) : super(GetdataqrInitial());

  void getDataQr(context) async {
    emit(GetdataqrLoading());
    String? barcodeScanRes;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode('#ff6666', 'Cancel', true, ScanMode.QR);
      print('Result Scan:  $barcodeScanRes');
      if (barcodeScanRes != '-1') {
    repository!.getDataQr(barcodeScanRes, context).then((value) {
      var statusCode = value.statusCode;
      var json = value.body;
      print("Scan QR Code: $json");
      print("status: $statusCode");
      if (value.statusCode == 200) {
        var json = jsonDecode(value.body);
        emit(GetdataqrLoaded(json: json, statusCode: value.statusCode));
      } else if (value.statusCode == 401) {
        emit(GetdataqrLoaded(json: {'message': 'Unauthorized'}, statusCode: value.statusCode));
      } else {
        var json = jsonDecode(value.body);
        emit(GetdataqrLoaded(json: json, statusCode: value.statusCode));
      }
    });
      } else {
        EasyLoading.dismiss();
      }
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }
  }
}
