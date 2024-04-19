import 'dart:convert';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hikaron/source/data/Auth/cubit/auth_cubit.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hikaron/source/data/Auth/cubit/profile_cubit.dart';
import 'package:hikaron/source/data/Home/ReturnIssue/cubit/getdataqr_cubit.dart';
import 'package:hikaron/source/data/Home/ReturnIssue/cubit/return_cubit.dart';
import 'package:hikaron/source/data/Home/StockOpname/cubit/stock_opname_cubit.dart';
import 'package:hikaron/source/data/Home/StockOpname/cubit/stock_opname_list_cubit.dart';
import 'package:hikaron/source/data/model/modelEntryReturn.dart';
import 'package:hikaron/source/env/env.dart';
import 'package:hikaron/source/router/string.dart';
import 'package:hikaron/source/widget/customButton.dart';
import 'package:hikaron/source/widget/customDialog.dart';
import 'package:hikaron/source/widget/customTextField.dart';
import 'package:hikaron/source/data/Home/DoRealization/cubit/do_list_cubit.dart';
import 'package:hikaron/source/data/Home/DoRealization/cubit/do_realization_cubit.dart';
import 'package:hikaron/source/widget/button2.dart';
import 'package:hikaron/source/widget/buttonSave.dart';
import 'package:hikaron/source/widget/buttonScan.dart';
import 'package:hikaron/source/widget/customDialog.dart';
import 'package:hikaron/source/widget/customTextField.dart';
import 'package:hikaron/source/widget/customTextFieldRead.dart';
import 'package:intl/intl.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:hikaron/source/data/Home/GoodsReceipt/cubit/getissue_code_cubit.dart';
import 'package:hikaron/source/data/Home/GoodsReceipt/cubit/goods_receipt_cubit.dart';
import 'package:hikaron/source/data/Home/GoodsReceipt/cubit/racking_cubit.dart';
// pages
part 'Auth/login.dart';
part 'Auth/splashScreen.dart';
part 'dashboard/notifikasi.dart';
part 'dashboard/profile.dart';
part 'bottomNavBar.dart';
part 'dashboard/Home/home.dart';
part 'dashboard/Home/DoRealitzation.dart';
part 'dashboard/Home/stockOpname.dart';
part 'dashboard/Home/GoodRecipt.dart';
part 'dashboard/Home/return.dart';
