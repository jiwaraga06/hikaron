import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hikaron/source/repository/GoodsReceiptRepository.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'getissue_code_state.dart';

class GetissueCodeCubit extends Cubit<GetissueCodeState> {
  final GoodsReceiptRepository? repository;
  GetissueCodeCubit({this.repository}) : super(GetissueCodeInitial());

  void getIssueCode(code, context) async {
    emit(GetissueCodeLoading());
    repository!.getTransferIssueCode(code, context).then((value) {
      var statusCode = value.statusCode;
      var json = value.body;
      print("Get issue code: $json");
      print("status: $statusCode");
      if (value.statusCode == 200) {
        var json = jsonDecode(value.body);
        emit(GetissueCodeLoaded(json: json, statusCode: value.statusCode));
      } else if (value.statusCode == 401) {
        emit(GetissueCodeLoaded(json: {'message': 'Unauthorized'}, statusCode: value.statusCode));
      } else {
        var json = jsonDecode(value.body);
        emit(GetissueCodeLoaded(json: json, statusCode: value.statusCode));
      }
    });
  }

  void scanQr(context) async {
    emit(GetissueCodeLoading());
    String? barcodeScanRes;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode('#ff6666', 'Cancel', true, ScanMode.QR);
      print('Result Scan:  $barcodeScanRes');
      if (barcodeScanRes != '-1') {
        repository!.getTransferIssueCode(barcodeScanRes, context).then((value) {
          var statusCode = value.statusCode;
          var json = value.body;
          print("Get issue code: $json");
          print("status: $statusCode");
          if (value.statusCode == 200) {
            var json = jsonDecode(value.body);
            emit(GetissueCodeLoaded(json: json, statusCode: value.statusCode));
          } else if (value.statusCode == 401) {
            emit(GetissueCodeLoaded(json: {'message': 'Unauthorized'}, statusCode: value.statusCode));
          } else {
            var json = jsonDecode(value.body);
            emit(GetissueCodeLoaded(json: json, statusCode: value.statusCode));
          }
        });
      } else {
        EasyLoading.dismiss();
      }
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }
  }

  void scanQrCode(transfercode, context) async {
    emit(GetissueCodeScanLoading());
    String? barcodeScanRes;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode('#ff6666', 'Cancel', true, ScanMode.QR);
      print('Result Scan:  $barcodeScanRes');
      if (barcodeScanRes != '-1') {
      repository!.getItemByQrCode(transfercode, barcodeScanRes, context).then((value) {
        var statusCode = value.statusCode;
        var json = value.body;
        print("Scan QR Code: $json");
        print("status: $statusCode");
        if (value.statusCode == 200) {
          var json = jsonDecode(value.body);
          emit(GetissueCodeScanLoaded(json: json, statusCode: value.statusCode));
        } else if (value.statusCode == 401) {
          emit(GetissueCodeScanLoaded(json: {'message': 'Unauthorized'}, statusCode: value.statusCode));
        } else {
          var json = jsonDecode(value.body);
          emit(GetissueCodeScanLoaded(json: json, statusCode: value.statusCode));
        }
      });
      } else {
        EasyLoading.dismiss();
      }
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }
  }

  void entry(transferid, qrcode, itemId, design, color, width, qty, rackId, context) async {
    emit(GetissueCodeEntryLoading());
    SharedPreferences pref = await SharedPreferences.getInstance();
    var username = pref.getString('username');
    var body = {
      "transfer_id": transferid,
      "qr_code": qrcode,
      "item_id": itemId,
      "design_name": design,
      "color_code": color,
      "width": width,
      "qty": qty,
      "rack_id": rackId,
      "add_by": username
    };
    print(body);
    repository!.insertData(jsonEncode(body), context).then((value) {
      var statusCode = value.statusCode;
      var json = value.body;
      print("Entry: $json");
      print("status: $statusCode");
      if (value.statusCode == 200) {
        emit(GetissueCodeEntryLoaded(json: {'message': 'Berhasil'}, statusCode: statusCode));
      } else if (value.statusCode == 401) {
        emit(GetissueCodeEntryLoaded(json: {'message': 'Unauthorized'}, statusCode: statusCode));
      } else {
        var json = jsonDecode(value.body);
        emit(GetissueCodeEntryLoaded(json: json, statusCode: statusCode));
      }
    });
  }
}
