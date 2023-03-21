import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:hikaron/source/repository/repository.dart';
import 'package:meta/meta.dart';

part 'stock_opname_list_state.dart';

class StockOpnameListCubit extends Cubit<StockOpnameListState> {
  final MyRepository? myRepository;
  StockOpnameListCubit({required this.myRepository}) : super(StockOpnameListInitial());
  var list = [];

  void getStockOpnameList(context) async {
    emit(StockOpnameListLoading());
    myRepository!.getStockOpnameList(context).then((value) {
      print('StockOpname List: ${value.body}');
      print('StockOpname List: ${value.statusCode}');
      if (value.statusCode == 200) {
        var json = jsonDecode(value.body);
        list = json;
        emit(StockOpnameListLoaded(statusCode: value.statusCode, json: json));
      } else if (value.statusCode == 401) {
        emit(StockOpnameListLoaded(statusCode: value.statusCode, json: {'message': 'Unauthorized'}));
      } else {
        var json = jsonDecode(value.body);
        emit(StockOpnameListLoaded(statusCode: value.statusCode, json: json));
      }
    });
  }

  void searchData(value) async {
    emit(StockOpnameListLoading());
    var result = value;
    print('Result:  $result');
    print('list');
    // print(list);
    var hasil = list.where((e) => e['stockopname_code'].toLowerCase().contains(result.toLowerCase())).toList();
    print('hasil: $hasil');
    if (result == '') {
      print('Kosong');
      emit(StockOpnameListLoaded(statusCode: 200, json: list));
    } else {
      print('ada');
      emit(StockOpnameListLoaded(statusCode: 200, json: hasil));
    }
  }
}
