import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:hikaron/source/repository/GoodsReceiptRepository.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'goods_receipt_state.dart';

class GoodsReceiptCubit extends Cubit<GoodsReceiptState> {
  final GoodsReceiptRepository? repository;
  GoodsReceiptCubit({this.repository}) : super(GoodsReceiptInitial());
  var list = [];
  void getIssueList(context) async {
    emit(GoodsReceiptLoading());
    repository!.getTransferIssueList(context).then((value) {
      print('Issue List: ${value.body}');
      print('status: ${value.statusCode}');
      if (value.statusCode == 200) {
        var json = jsonDecode(value.body);
        list = json;
        emit(GoodsReceiptLoaded(statusCode: value.statusCode, json: json));
      } else if (value.statusCode == 401) {
        emit(GoodsReceiptLoaded(statusCode: value.statusCode, json: {'message': 'Unauthorized'}));
      } else {
        var json = jsonDecode(value.body);
        emit(GoodsReceiptLoaded(statusCode: value.statusCode, json: json));
      }
    });
  }

  void searchData(value) async {
    emit(GoodsReceiptLoading());
    var result = value;
    print('Result:  $result');
    print('list');
    // print(list);
    var hasil = list.where((e) => e['transfer_code'].toLowerCase().contains(result.toLowerCase())).toList();
    print('hasil: $hasil');
    if (result == '') {
      print('Kosong');
      emit(GoodsReceiptLoaded(statusCode: 200, json: list));
    } else {
      print('ada');
      emit(GoodsReceiptLoaded(statusCode: 200, json: hasil));
    }
  }

 
}
