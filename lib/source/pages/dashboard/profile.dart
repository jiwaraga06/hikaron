import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hikaron/source/data/Auth/cubit/profile_cubit.dart';
import 'package:hikaron/source/widget/customDialog.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<ProfileCubit>(context).getProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF3A1078),
        elevation: 0.0,
        title: Text('Profile', style: GoogleFonts.montserrat()),
        actions: [
          IconButton(
              onPressed: () {
                MyDialog.dialogInfo(context, 'Apakah Anda Ingin Keluar ?',(){}, () {
                  BlocProvider.of<ProfileCubit>(context).logout(context);
                });
              },
              icon: Icon(Icons.logout_outlined)),
        ],
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 50),
            child: Container(
              height: 150,
              width: 150,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/image/user.png'),
                ),
              ),
            ),
          ),
          BlocBuilder<ProfileCubit, ProfileState>(
            builder: (context, state) {
              if (state is ProfileLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state is ProfileLoaded == false) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              var json = (state as ProfileLoaded).json;
              if (json.isEmpty) {
                return Center();
              }
              return Container(
                alignment: Alignment.center,
                child: Text(
                  json['username'].toString(),
                  style: GoogleFonts.montserrat(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
