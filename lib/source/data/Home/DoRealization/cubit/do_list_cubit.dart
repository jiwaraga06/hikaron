import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:hikaron/source/repository/repository.dart';
import 'package:meta/meta.dart';

part 'do_list_state.dart';

class DoListCubit extends Cubit<DoListState> {
  final MyRepository? myRepository;
  DoListCubit({required this.myRepository}) : super(DoListInitial());
  var list = [];

  void getDoList(context) async {
    emit(DoListLoading());
    myRepository!.getDoList(context).then((value) {
      print('DO List: ${value.body}');
      print('DO List: ${value.statusCode}');
      if (value.statusCode == 200) {
        var json = jsonDecode(value.body);
        list = json;
        emit(DoListLoaded(statusCode: value.statusCode, json: json));
      } else if (value.statusCode == 401) {
        emit(DoListLoaded(statusCode: value.statusCode, json: {'message': 'Unauthorized'}));
      } else {
        var json = jsonDecode(value.body);
        emit(DoListLoaded(statusCode: value.statusCode, json: json));
      }
    });
  }

  void searchData(value) async {
    emit(DoListLoading());
    var result = value;
    print('Result:  $result');
    print('list');
    // print(list);
    var hasil = list.where((e) => e['ptnr_name'].toLowerCase().contains(result.toLowerCase())).toList();
    print('hasil: $hasil');
    if (result == '') {
      print('Kosong');
      emit(DoListLoaded(statusCode: 200, json: list));
    } else {
      print('ada');
      emit(DoListLoaded(statusCode: 200, json: hasil));
    }
  }
}
