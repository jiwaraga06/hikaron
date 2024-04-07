import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:hikaron/source/repository/GoodsReceiptRepository.dart';
import 'package:meta/meta.dart';

part 'racking_state.dart';

class RackingCubit extends Cubit<RackingState> {
  final GoodsReceiptRepository? repository;
  RackingCubit({this.repository}) : super(RackingInitial());

  void initial(){
    emit(RackingInitial());

  }

  void getRacking(itemid, context) async {
    emit(RackingLoading());
    repository!.getRackList(itemid, context).then((value) {
      var statusCode = value.statusCode;
      var json = value.body;
      print("Rack: $json");
      print("status: $statusCode");
      if (value.statusCode == 200) {
        var json = jsonDecode(value.body);
        emit(RackingLoaded(json: json, statusCode: value.statusCode));
      } else if (value.statusCode == 401) {
        emit(RackingLoaded(json: {'message': 'Unauthorized'}, statusCode: value.statusCode));
      } else {
        var json = jsonDecode(value.body);
        emit(RackingLoaded(json: json, statusCode: value.statusCode));
      }
    });
  }
}
