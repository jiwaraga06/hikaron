import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:hikaron/source/data/Auth/cubit/auth_cubit.dart';
import 'package:hikaron/source/data/Auth/cubit/profile_cubit.dart';
import 'package:hikaron/source/data/Home/DoRealization/cubit/do_list_cubit.dart';
import 'package:hikaron/source/data/Home/DoRealization/cubit/do_realization_cubit.dart';
import 'package:hikaron/source/data/Home/GoodsReceipt/cubit/getissue_code_cubit.dart';
import 'package:hikaron/source/data/Home/GoodsReceipt/cubit/goods_receipt_cubit.dart';
import 'package:hikaron/source/data/Home/GoodsReceipt/cubit/racking_cubit.dart';
import 'package:hikaron/source/data/Home/ReturnIssue/cubit/getdataqr_cubit.dart';
import 'package:hikaron/source/data/Home/ReturnIssue/cubit/return_cubit.dart';
import 'package:hikaron/source/data/Home/ReturnIssue/cubit/return_type_cubit.dart';
import 'package:hikaron/source/data/Home/StockOpname/cubit/stock_opname_cubit.dart';
import 'package:hikaron/source/data/Home/StockOpname/cubit/stock_opname_list_cubit.dart';
import 'package:hikaron/source/network/network.dart';
import 'package:hikaron/source/repository/GoodsReceiptRepository.dart';
import 'package:hikaron/source/repository/ReturnIssue.dart';
import 'package:hikaron/source/repository/repository.dart';
import 'package:hikaron/source/router/router.dart';

void main() {
  runApp(MyApp(router: RouterNavigation()));
}

class MyApp extends StatelessWidget {
  final RouterNavigation? router;
  MyApp({super.key, this.router});
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) => MyRepository()),
        RepositoryProvider(create: (context) => GoodsReceiptRepository()),
        RepositoryProvider(create: (context) => ReturnIssue()),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => AuthCubit(myRepository: MyRepository())),
          BlocProvider(create: (context) => StockOpnameCubit(myRepository: MyRepository())),
          BlocProvider(create: (context) => StockOpnameListCubit(myRepository: MyRepository())),
          BlocProvider(create: (context) => ProfileCubit(myRepository: MyRepository())),
          BlocProvider(create: (context) => DoRealizationCubit(myRepository: MyRepository())),
          BlocProvider(create: (context) => DoListCubit(myRepository: MyRepository())),
          BlocProvider(create: (context) => GoodsReceiptCubit(repository: GoodsReceiptRepository())),
          BlocProvider(create: (context) => GetissueCodeCubit(repository: GoodsReceiptRepository())),
          BlocProvider(create: (context) => RackingCubit(repository: GoodsReceiptRepository())),
          BlocProvider(create: (context) => ReturnCubit(repository: ReturnIssue())),
          BlocProvider(create: (context) => GetdataqrCubit(repository: ReturnIssue())),
          BlocProvider(create: (context) => ReturnTypeCubit(repository: ReturnIssue())),
        ],
        // child: GetMaterialApp(
        //   debugShowCheckedModeBanner: false,
        //   initialRoute: SPLASH,
        //   getPages: RouterNavigation.pages,
        //   builder: EasyLoading.init(),
        // ),
        child: MaterialApp(debugShowCheckedModeBanner: false, onGenerateRoute: router!.generateRoute, builder: EasyLoading.init()),
      ),
    );
  }
}
