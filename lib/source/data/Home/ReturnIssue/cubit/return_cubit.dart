import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:hikaron/source/env/env.dart';
import 'package:hikaron/source/repository/ReturnIssue.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'return_state.dart';

class ReturnCubit extends Cubit<ReturnState> {
  final ReturnIssue? repository;
  ReturnCubit({this.repository}) : super(ReturnInitial());

  void entry(tanggal, remark, typeList, context) async {
    emit(EntryReturnLoading());
    SharedPreferences pref = await SharedPreferences.getInstance();
    var username = pref.getString('username');
    // var format = DateFormat('yyyy-MM-dd');
    // var tanggal = format.format(DateTime.now());
    var body = {
      "gudangtran_date": tanggal,
      "gudangtran_add_by": username,
      "gudangtran_type": typeList,
      "gudangtran_remarks": remark,
      "returnIssueDetail": model
    };
    print(body);
    repository!.insert(jsonEncode(body), context).then((value) {
      var statusCode = value.statusCode;
      var json = value.body;
      print("Entry: $json");
      print("status: $statusCode");
      if (value.statusCode == 200) {
        emit(EntryReturnLoaded(json: {'message': 'Berhasil'}, statusCode: statusCode));
      } else if (value.statusCode == 401) {
        emit(EntryReturnLoaded(json: {'message': 'Unauthorized'}, statusCode: statusCode));
      } else {
        var json = jsonDecode(value.body);
        emit(EntryReturnLoaded(json: json, statusCode: statusCode));
      }
    });
  }
}
