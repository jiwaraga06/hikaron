import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:hikaron/source/data/model/modelReturnTypeList.dart';
import 'package:hikaron/source/repository/ReturnIssue.dart';
import 'package:meta/meta.dart';

part 'return_type_state.dart';

class ReturnTypeCubit extends Cubit<ReturnTypeState> {
  final ReturnIssue? repository;

  ReturnTypeCubit({this.repository}) : super(ReturnTypeInitial());

  void getReturnTypeList(context) async {
    emit(ReturnTypeLoading());
    repository!.getdataReturnTypeList(context).then((value) {
      var json = value.body;
      var statusCode = value.statusCode;
      print("Type List: $json");
      print("status: $statusCode");
      if (value.statusCode == 200) {
        // var json = jsonDecode(value.body);
        emit(ReturnTypeLoaded(statusCode: statusCode, model: modelReturnTypeListFromJson(json)));
      } else if (value.statusCode == 401) {
        emit(ReturnTypeFailed(json: {'message': 'Unauthorized'}, statusCode: value.statusCode));
      } 
    });
  }
}
