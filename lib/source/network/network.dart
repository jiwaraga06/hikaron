import 'dart:async';
import 'dart:io';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hikaron/source/widget/customDialog.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

Future network({String? method, String? url, body, context}) async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  var token = pref.getString('token');
  var headers = {'Authorization': 'Bearer $token', "Accept": "application/json", "Content-type": "application/json"};
  var response;
  try {
    if (method == "GET") {
      response = await http.get(Uri.parse(url!), headers: headers);
    } else if (method == "POST") {
      response = await http.post(Uri.parse(url!), headers: headers, body: body);
    }
    return response;
  } on TimeoutException {
    EasyLoading.dismiss();
    MyDialog.dialogAlert(context, 'Masalah Koneksi \n Jaringan Lemah');
  } on SocketException {
    EasyLoading.dismiss();
    MyDialog.dialogAlert(context, 'Masalah Koneksi \n Data Mati');
  } on HttpException catch (e) {
    EasyLoading.dismiss();
    MyDialog.dialogAlert(context, e.message);
  } on Error catch (e) {
    EasyLoading.dismiss();
    MyDialog.dialogAlert(context, e.toString());
  }
}
