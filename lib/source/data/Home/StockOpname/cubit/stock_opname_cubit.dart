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

  void scanQROpname(context) async {
    emit(StockOpnameLoading());
    String? barcodeScanRes;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode('#ff6666', 'Cancel', true, ScanMode.QR);
      print('Result Scan:  $barcodeScanRes');
      if (barcodeScanRes != '-1') {
        myRepository!.getOpnameCode(barcodeScanRes, context).then((value) {
          var json = jsonDecode(value.body);
          print('OPNAME: $json');
          emit(StockOpnameLoaded(statusCode: value.statusCode, json: json));
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
      MyDialog.dialogInfo(context, 'OpNamed Oid masih kosong', () {});
    } else {
      emit(StockBarangLoading());
      String? barcodeScanRes;
      try {
        barcodeScanRes = await FlutterBarcodeScanner.scanBarcode('#ff6666', 'Cancel', true, ScanMode.QR);
        print('Result Scan:  $barcodeScanRes');
        if (barcodeScanRes != '-1') {
          myRepository!.getBarangCode(opname_oid, barcodeScanRes, context).then((value) {
            var json = jsonDecode(value.body);
            print('BARANG: $json');
            emit(StockBarangLoaded(statusCode: value.statusCode, json: json));
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
    myRepository!.entryStockOpname(body, context).then((value) {
      var json = jsonDecode(value.body);
      print("Entry Stock: $json");
      emit(EntryStockLoaded(statusCode: value.statusCode, json: json));
    });
  }
}
