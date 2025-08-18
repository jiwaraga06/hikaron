import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hikaron/source/repository/repository.dart';
import 'package:hikaron/source/router/string.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final MyRepository? myRepository;
  ProfileCubit({required this.myRepository}) : super(ProfileInitial());

  void getProfile() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    emit(ProfileLoading());
    var username = pref.getString('username');
    print("Username: $username");
    emit(ProfileLoaded(json: {'username': username.toString()}));
  }

  void logout(context) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.clear();
    Navigator.pushNamedAndRemoveUntil(context, LOGIN, (route) => false);
    // Get.offAllNamed(LOGIN);
  }
}
