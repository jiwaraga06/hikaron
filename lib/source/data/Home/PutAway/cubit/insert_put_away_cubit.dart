import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:hikaron/source/env/env.dart';
import 'package:hikaron/source/repository/PutAwayRepository.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'insert_put_away_state.dart';

class InsertPutAwayCubit extends Cubit<InsertPutAwayState> {
  final PutAwayRepository? repository;
  InsertPutAwayCubit({this.repository}) : super(InsertPutAwayInitial());

  void insert(tanggal, remark, rack_id, rack_code, context) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var username = pref.getString('username');
    var body = {
      "putaway_date": tanggal,
      "putaway_to_rack_id": rack_id,
      "putaway_to_rack_code": rack_code,
      "putaway_remarks": remark,
      "putaway_add_by": username,
      "putawayDetail": modelPutaway,
    };
    print(body);
    emit(InsertPutAwayLoading());
    repository!.insertPutAway(jsonEncode(body), context).then((value) {
      var statusCode = value.statusCode;
      var json = value.body;
      print("Entry: $json");
      print("status: $statusCode");
      if (value.statusCode == 200) {
        emit(InsertPutAwayLoaded(json: {'message': 'Berhasil'}, statusCode: statusCode));
      } else if (value.statusCode == 401) {
        emit(InsertPutAwayLoaded(json: {'message': 'Unauthorized'}, statusCode: statusCode));
      } else {
        var json = jsonDecode(value.body);
        emit(InsertPutAwayLoaded(json: json, statusCode: statusCode));
      }
    });
  }
}
