import 'package:bloc/bloc.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hikaron/source/repository/repository.dart';
import 'package:meta/meta.dart';

part 'do_realization_state.dart';

class DoRealizationCubit extends Cubit<DoRealizationState> {
  final MyRepository? myRepository;
  DoRealizationCubit({required this.myRepository}) : super(DoRealizationInitial());

  void scanQrDo(context) async {
    String? barcodeScanRes;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode('#ff6666', 'Cancel', true, ScanMode.QR);
      print('Result Scan:  $barcodeScanRes');
      if (barcodeScanRes != '-1') {
      } else {
        EasyLoading.dismiss();
      }
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }
  }
}
