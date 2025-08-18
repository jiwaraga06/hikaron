import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hikaron/source/repository/repository.dart';
import 'package:hikaron/source/widget/customDialog.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'do_realization_state.dart';

class DoRealizationCubit extends Cubit<DoRealizationState> {
  final MyRepository? myRepository;
  DoRealizationCubit({required this.myRepository}) : super(DoRealizationInitial());

  void getDo(do_code, context) async {
    emit(DoOpnameLoading());
    myRepository!.doCode(do_code, context).then((value) {
      print('Do CODE: ${value.statusCode}');
      print('Do CODE: ${value.body}');
      if (value.statusCode == 200) {
        var json = jsonDecode(value.body);
        emit(DoOpnameLoaded(json: json, statusCode: value.statusCode));
      } else if (value.statusCode == 401) {
        emit(DoOpnameLoaded(json: {'message': 'Unauthorized'}, statusCode: value.statusCode));
      } else if (value.statusCode == 400) {
        var json = jsonDecode(value.body);
        emit(DoOpnameLoaded(json: json, statusCode: value.statusCode));
      } else {
        var json = jsonDecode(value.body);
        emit(DoOpnameLoaded(json: json, statusCode: value.statusCode));
      }
    });
  }

  void scanQrDo(context) async {
    emit(DoOpnameLoading());
    String? barcodeScanRes;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode('#ff6666', 'Cancel', true, ScanMode.QR);
      print('Result Scan:  $barcodeScanRes');
      if (barcodeScanRes != '-1') {
        myRepository!.doCode(barcodeScanRes, context).then((value) {
          print('Do CODE: ${value.statusCode}');
          print('Do CODE: ${value.body}');
          if (value.statusCode == 200) {
            var json = jsonDecode(value.body);
            emit(DoOpnameLoaded(json: json, statusCode: value.statusCode));
          } else if (value.statusCode == 401) {
            emit(DoOpnameLoaded(json: {'message': 'Unauthorized'}, statusCode: value.statusCode));
          } else {
            var json = jsonDecode(value.body);
            emit(DoOpnameLoaded(json: json, statusCode: value.statusCode));
          }
        });
      } else {
        EasyLoading.dismiss();
      }
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }
  }

  void scanQrBarang(do_code, context) async {
    String? barcodeScanRes;
    if (do_code == null) {
      MyDialog.dialogInfo(context, 'Do Code masih kosong', () {}, () {});
    } else {
      emit(DoBarangLoading());
      try {
        barcodeScanRes = await FlutterBarcodeScanner.scanBarcode('#ff6666', 'Cancel', true, ScanMode.QR);
        print('Result Scan:  $barcodeScanRes');
        if (barcodeScanRes != '-1') {
          myRepository!.doBarang(do_code, barcodeScanRes, context).then((value) {
            print('Do BARANG: ${value.body}');
            print('Do BARANG: ${value.statusCode}');
            if (value.statusCode == 200) {
              var json = jsonDecode(value.body);
              emit(DoBarangLoaded(json: json, statusCode: value.statusCode));
            } else if (value.statusCode == 401) {
              emit(DoBarangLoaded(json: {'message': 'Unauthorized'}, statusCode: value.statusCode));
            } else {
              var json = jsonDecode(value.body);
              emit(DoBarangLoaded(json: json, statusCode: value.statusCode));
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

  void entryDoOpname(dod_oid, pt_id, qr_code, grade_id, roll, qty, price_mtr, is_foc, is_cons, context) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var username = pref.getString('username');
    var body = {
      "dod_oid": '$dod_oid',
      "pt_id": '$pt_id',
      "qr_code": '$qr_code',
      "grade_id": '$grade_id',
      "roll": '$roll',
      "qty": '$qty',
      "price_mtr": '$price_mtr',
      "is_foc": '$is_foc',
      "is_cons": '$is_cons',
      "add_by": '$username',
    };
    print(body);
    emit(EntryDoLoading());
    myRepository!.entryDoOpname(jsonEncode(body), context).then((value) {
      print('JSON Entry DO: ${value.body}');
      print('JSON Entry DO: ${value.statusCode}');
      if (value.statusCode == 200) {
        emit(EntryDoLoaded(statusCode: value.statusCode, json: {'message': "Berhasil"}));
      } else if (value.statusCode == 401) {
        var json = jsonDecode(value.body);
        emit(EntryDoLoaded(statusCode: value.statusCode, json: {'message': 'Unauthorized'}));
      } else {
        var json = jsonDecode(value.body);
        emit(EntryDoLoaded(statusCode: value.statusCode, json: json));
      }
    });
  }
}
