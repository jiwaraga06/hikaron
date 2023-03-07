import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hikaron/source/repository/repository.dart';
import 'package:hikaron/source/router/string.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final MyRepository? myRepository;
  AuthCubit({required this.myRepository}) : super(AuthInitial());

  void splashScreen(context) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var token = pref.getString('token');
    print(token);
    await Future.delayed(const Duration(seconds: 2));
    if (token != null) {
      // Navigator.pushNamedAndRemoveUntil(context, BOTTOM_NAV, (route) => false);
      Get.offAllNamed(BOTTOM_NAV);
    } else {
      Get.offAllNamed(LOGIN);
      // Navigator.pushNamedAndRemoveUntil(context, LOGIN, (route) => false);
    }
  }

  void getSession() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var username = pref.getString('username');
    print(username);
    emit(AuthGetSession(username: username));
  }

  void login(username, pass, context) async {
    emit(AuthLoading());
    SharedPreferences pref = await SharedPreferences.getInstance();
    myRepository!.login(context, username, pass).then((value) {
      var json = jsonDecode(value.body);
      pref.setString('token', json['token']);
      pref.setString('username', json['usernama']);
      print("Login: $json");
      emit(AuthLoaded(statusCode: value.statusCode, json: json));
    });
  }
}
