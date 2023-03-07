import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:hikaron/source/data/Auth/cubit/auth_cubit.dart';
import 'package:hikaron/source/data/Auth/cubit/profile_cubit.dart';
import 'package:hikaron/source/data/Home/StockOpname/cubit/stock_opname_cubit.dart';
import 'package:hikaron/source/network/network.dart';
import 'package:hikaron/source/pages/dashboard/Home/DoRealitzation.dart';
import 'package:hikaron/source/repository/repository.dart';
import 'package:hikaron/source/router/router.dart';
import 'package:hikaron/source/router/string.dart';

void main() {
  runApp(MyApp(
    router: RouterNavigation(),
    myRepository: MyRepository(myNetwork: MyNetwork()),
  ));
}

class MyApp extends StatelessWidget {
  final RouterNavigation? router;
  final MyRepository? myRepository;
  MyApp({super.key, this.router, this.myRepository});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthCubit(myRepository: myRepository),
        ),
        BlocProvider(
          create: (context) => StockOpnameCubit(myRepository: myRepository),
        ),
        BlocProvider(
          create: (context) => ProfileCubit(myRepository: myRepository),
        ),
        BlocProvider(
          create: (context) => DoRealization(myRepository: myRepository),
        ),
      ],
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: SPLASH,
        getPages: RouterNavigation.pages,
        builder: EasyLoading.init(),
      ),
      // child: MaterialApp(
      //   debugShowCheckedModeBanner: false,
      //   onGenerateRoute: router!.generateRoute,
      //   builder: EasyLoading.init()
      // ),
    );
  }
}
