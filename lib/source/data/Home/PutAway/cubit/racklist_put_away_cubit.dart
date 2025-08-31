import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hikaron/source/repository/PutAwayRepository.dart';
import 'package:meta/meta.dart';

part 'racklist_put_away_state.dart';

class RacklistPutAwayCubit extends Cubit<RacklistPutAwayState> {
  final PutAwayRepository? repository;
  RacklistPutAwayCubit({this.repository}) : super(RacklistPutAwayInitial());

  var list = [];

  void getRackList(context) async {
    emit(RacklistPutAwayLoading());
    repository!.getRackListPutAway(context).then((value) {
      print('Issue List: ${value.body}');
      print('status: ${value.statusCode}');
      if (value.statusCode == 200) {
        var json = jsonDecode(value.body);
        list = json;
        emit(RacklistPutAwayLoaded(statusCode: value.statusCode, json: json));
      } else if (value.statusCode == 401) {
        emit(RacklistPutAwayLoaded(statusCode: value.statusCode, json: {'message': 'Unauthorized'}));
        
      } else {
        var json = jsonDecode(value.body);
        emit(RacklistPutAwayLoaded(statusCode: value.statusCode, json: json));
      }
    });
  }

  void scanQr(context) async {
    emit(RacklistPutAwayLoading());
    String? barcodeScanRes;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode('#ff6666', 'Cancel', true, ScanMode.QR);
      print('Result Scan:  $barcodeScanRes');
      // if (barcodeScanRes != '-1') {
        repository!.getRackListByScanPutAway(barcodeScanRes, context).then((value) {
          var statusCode = value.statusCode;
          var json = value.body;
          print("Single Rack code: $json");
          print("status: $statusCode");
          if (value.statusCode == 200) {
            var json = jsonDecode(value.body);
            emit(RacklistPutAwayLoaded(json: json, statusCode: value.statusCode));
          } else if (value.statusCode == 401) {
            emit(RacklistPutAwayLoaded(json: {'message': 'Unauthorized'}, statusCode: value.statusCode));
          } else {
            var json = jsonDecode(value.body);
            emit(RacklistPutAwayLoaded(json: json, statusCode: value.statusCode));
          }
        });
      // } else {
      //   EasyLoading.dismiss();
      // }
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }
  }

  void searchData(value) async {
    emit(RacklistPutAwayLoading());
    var result = value;
    print('Result:  $result');
    print('list');
    // print(list);
    var hasil = list.where((e) => e['rack_code'].toLowerCase().contains(result.toLowerCase())).toList();
    print('hasil: $hasil');
    if (result == '') {
      print('Kosong');
      emit(RacklistPutAwayLoaded(statusCode: 200, json: list));
    } else {
      print('ada');
      emit(RacklistPutAwayLoaded(statusCode: 200, json: hasil));
    }
  }
}
