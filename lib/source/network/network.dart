import 'dart:async';
import 'dart:io';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hikaron/source/network/api.dart';
import 'package:hikaron/source/widget/customDialog.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class MyNetwork {
  Future login(username, pass, context) async {
    try {
      var url = Uri.parse(MyApi.login(username, pass));
      var response = await http.get(url);
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

    Future getStockOpnameList(context) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var token = pref.getString('token');
    try {
      var url = Uri.parse(MyApi.getOpnameList());
      var response = await http.get(url, headers: {'Authorization': 'Bearer $token'});
      return response;
    } on TimeoutException {
      EasyLoading.dismiss();
      MyDialog.dialogAlert(context, 'Masalah Koneksi \n Jaringan Lemah \n error get data DO LIST');
    } on SocketException {
      EasyLoading.dismiss();
      MyDialog.dialogAlert(context, 'Masalah Koneksi \n Data Mati \n error get data DO LIST');
    } on HttpException catch (e) {
      EasyLoading.dismiss();
      MyDialog.dialogAlert(context, e.message);
    } on Error catch (e) {
      EasyLoading.dismiss();
      MyDialog.dialogAlert(context, e.toString());
    }
  }

  Future getOpnameCode(qr_code, context) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var token = pref.getString('token');
    try {
      var url = Uri.parse(MyApi.getOpnameCode(qr_code));
      var response = await http.get(url, headers: {
        'Authorization': 'Bearer $token',
      });
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

  Future getBarangCode(opname_oid, qr_code, context) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var token = pref.getString('token');
    try {
      var url = Uri.parse(MyApi.getBarangCode(opname_oid, qr_code));
      var response = await http.get(url, headers: {
        'Authorization': 'Bearer $token',
      });
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

  Future entryStockOpname(body, context) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var token = pref.getString('token');
    try {
      var url = Uri.parse(MyApi.entryStockOpname());
      var response = await http.post(url,
          headers: {
            'Authorization': 'Bearer $token',
            "Accept": "application/json",
            "Content-type": "application/json",
          },
          body: body);
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

  // DO REALIZATION
  Future getDoCode(do_code, context) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var token = pref.getString('token');
    try {
      var url = Uri.parse(MyApi.doCode(do_code));
      var response = await http.get(url, headers: {
        'Authorization': 'Bearer $token',
      });
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

  Future getDoBarang(do_code, qr_code, context) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var token = pref.getString('token');
    try {
      var url = Uri.parse(MyApi.doBarang(do_code, qr_code));
      var response = await http.get(url, headers: {
        'Authorization': 'Bearer $token',
      });
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

  Future entryDoOpname(body, context) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var token = pref.getString('token');
    try {
      var url = Uri.parse(MyApi.entryDoOpname());
      var response = await http.post(url,
          headers: {
            'Authorization': 'Bearer $token',
            "Accept": "application/json",
            "Content-type": "application/json",
          },
          body: body);
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

  Future getDoList(context) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var token = pref.getString('token');
    try {
      var url = Uri.parse(MyApi.getDOList());
      var response = await http.get(url, headers: {'Authorization': 'Bearer $token'});
      return response;
    } on TimeoutException {
      EasyLoading.dismiss();
      MyDialog.dialogAlert(context, 'Masalah Koneksi \n Jaringan Lemah \n error get data DO LIST');
    } on SocketException {
      EasyLoading.dismiss();
      MyDialog.dialogAlert(context, 'Masalah Koneksi \n Data Mati \n error get data DO LIST');
    } on HttpException catch (e) {
      EasyLoading.dismiss();
      MyDialog.dialogAlert(context, e.message);
    } on Error catch (e) {
      EasyLoading.dismiss();
      MyDialog.dialogAlert(context, e.toString());
    }
  }
}
