import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hikaron/source/repository/repository.dart';
import 'package:hikaron/source/widget/customDialog.dart';
import 'package:meta/meta.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:shared_preferences/shared_preferences.dart';
part 'stock_opname_state.dart';

class StockOpnameCubit extends Cubit<StockOpnameState> {
  final MyRepository? myRepository;
  StockOpnameCubit({this.myRepository}) : super(StockOpnameInitial());

  void getOpname(stockopname_code, context) async {
    emit(StockOpnameLoading());
    myRepository!.getOpnameCode(stockopname_code, context).then((value) {
      print('Opname: ${value.body}');
      print('Opname: ${value.statusCode}');
      if (value.statusCode == 200) {
        var json = jsonDecode(value.body);
        emit(StockOpnameLoaded(statusCode: value.statusCode, json: json));
      } else if (value.statusCode == 401) {
        emit(StockOpnameLoaded(statusCode: value.statusCode, json: {'message': 'Unauthorized'}));
      } else {
        var json = jsonDecode(value.body);
        emit(StockOpnameLoaded(statusCode: value.statusCode, json: json));
      }
    });
  }

  void scanQROpname(context) async {
    emit(StockOpnameLoading());
    String? barcodeScanRes;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode('#ff6666', 'Cancel', true, ScanMode.QR);
      print('Result Scan:  $barcodeScanRes');
      if (barcodeScanRes != '-1') {
        myRepository!.getOpnameCode(barcodeScanRes, context).then((value) {
          print('Opname: ${value.body}');
          print('Opname: ${value.statusCode}');
          if (value.statusCode == 200) {
            var json = jsonDecode(value.body);
            emit(StockOpnameLoaded(statusCode: value.statusCode, json: json));
          } else if (value.statusCode == 401) {
            emit(StockOpnameLoaded(statusCode: value.statusCode, json: {'message': 'Unauthorized'}));
          } else {
            var json = jsonDecode(value.body);
            emit(StockOpnameLoaded(statusCode: value.statusCode, json: json));
          }
        });
      } else {
        EasyLoading.dismiss();
      }
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }
  }

  void scanQRBarang(opname_oid, context) async {
    if (opname_oid == null) {
      MyDialog.dialogInfo(context, 'OpNamed Oid masih kosong', () {}, () {});
    } else {
      emit(StockBarangLoading());
      String? barcodeScanRes;
      try {
        barcodeScanRes = await FlutterBarcodeScanner.scanBarcode('#ff6666', 'Cancel', true, ScanMode.QR);
        print('Result Scan:  $barcodeScanRes');
        if (barcodeScanRes != '-1') {
          myRepository!.getBarangCode(opname_oid, barcodeScanRes, context).then((value) {
            print('BARANG: ${value.body}');
            print('BARANG: ${value.statusCode}');
            if (value.statusCode == 200) {
              var json = jsonDecode(value.body);
              print('BARANG: $json');
              emit(StockBarangLoaded(statusCode: value.statusCode, json: json));
            } else if (value.statusCode == 401) {
              emit(StockBarangLoaded(statusCode: value.statusCode, json: {'message': 'Unauthorized'}));
            } else {
              var json = jsonDecode(value.body);
              emit(StockBarangLoaded(statusCode: value.statusCode, json: json));
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

  void entryStockOpname(stockopnamed_oid, stockopnamed_stockopname_oid, stockopnamed_pt_id, stockopnamed_barcode, stockopnamed_qty_opname, context) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var username = pref.getString('username');
    var body = {
      "stockopnamed_oid": '$stockopnamed_oid',
      "stockopnamed_stockopname_oid": '$stockopnamed_stockopname_oid',
      "stockopnamed_pt_id": '$stockopnamed_pt_id',
      "stockopnamed_barcode": '$stockopnamed_barcode',
      "stockopnamed_qty_opname": '$stockopnamed_qty_opname',
      "stockopnamed_upd_by": '$username',
    };
    print(body);
    emit(EntryStockLoading());
    myRepository!.entryStockOpname(jsonEncode(body), context).then((value) {
      print("Entry Stock: ${value.body}");
      print("Entry Stock: ${value.statusCode}");
      if (value.statusCode == 200) {
        emit(EntryStockLoaded(statusCode: value.statusCode, json: {'message': 'Berhasil'}));
      } else if (value.statusCode == 401) {
        emit(EntryStockLoaded(statusCode: value.statusCode, json: {'message': 'Authorized'}));
      } else {
        var json = jsonDecode(value.body);
        emit(EntryStockLoaded(statusCode: value.statusCode, json: json));
      }
    });
  }
}
