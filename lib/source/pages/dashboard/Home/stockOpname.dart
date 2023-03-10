import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hikaron/source/data/Home/StockOpname/cubit/stock_opname_cubit.dart';
import 'package:hikaron/source/widget/buttonSave.dart';
import 'package:hikaron/source/widget/customDialog.dart';
import 'package:hikaron/source/widget/customTextFieldRead.dart';

class StockOpname extends StatefulWidget {
  const StockOpname({super.key});

  @override
  State<StockOpname> createState() => _StockOpnameState();
}

class _StockOpnameState extends State<StockOpname> {
  final formkeyOpName = GlobalKey<FormState>();
  final formkey = GlobalKey<FormState>();
  var stockopname_code, stockopname_date, stockopname_oid;
  var opname_oid;
  var stockopnamed_oid, stockopnamed_stockopname_oid, stockopnamed_pt_id, stockopnamed_upd_by;
  TextEditingController controllerCodeOpName = TextEditingController();
  TextEditingController controllerDate = TextEditingController();
  TextEditingController controllerOid = TextEditingController();
  TextEditingController controllerCode = TextEditingController();
  TextEditingController controllerDesign = TextEditingController();
  TextEditingController controllerColor = TextEditingController();
  TextEditingController controllerQty = TextEditingController();

  void save() {
    if (formkeyOpName.currentState!.validate()) {
      if (formkey.currentState!.validate()) {
        BlocProvider.of<StockOpnameCubit>(context).entryStockOpname(
          stockopnamed_oid,
          stockopnamed_stockopname_oid,
          stockopnamed_pt_id,
          controllerCode.text,
          controllerQty.text,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF3A1078),
        elevation: 0.0,
        title: Text('Stock Opname'),
      ),
      body: BlocListener<StockOpnameCubit, StockOpnameState>(
        listener: (context, state) {
          if (state is StockOpnameLoading) {
            EasyLoading.show();
          }
          if (state is StockOpnameLoaded) {
            EasyLoading.dismiss();
            var json = state.json;
            var statusCode = state.statusCode;
            if (statusCode == 200) {
              setState(() {
                opname_oid = json['stockopname_oid'];
                controllerOid = TextEditingController(text: json['stockopname_oid']);
                controllerDate = TextEditingController(text: json['stockopname_date']);
                controllerCodeOpName = TextEditingController(text: json['stockopname_code']);
              });
            } else {
              MyDialog.dialogAlert(context, 'Code: $statusCode \n ${json['message']}');
            }
          }
          if (state is StockBarangLoading) {
            EasyLoading.show();
          }
          if (state is StockBarangLoaded) {
            EasyLoading.dismiss();
            var json = state.json;
            var statusCode = state.statusCode;
            if (statusCode == 200) {
              setState(() {
                stockopnamed_oid = json['stockopnamed_oid'];
                stockopnamed_stockopname_oid = json['stockopnamed_stockopname_oid'];
                stockopnamed_pt_id = json['stockopnamed_pt_id'];
                controllerCode = TextEditingController(text: json['stockopnamed_barcode']);
                controllerDesign = TextEditingController(text: json['design_name']);
                controllerColor = TextEditingController(text: json['color_code']);
                controllerQty = TextEditingController(text: json['stockopnamed_qty'].toString());
              });
            } else {
              MyDialog.dialogAlert(context, 'Code: $statusCode \n ${json['message']}');
            }
          }
        },
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {
                  BlocProvider.of<StockOpnameCubit>(context).scanQROpname(context);
                },
                splashColor: Colors.blue,
                child: Ink(
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(color: Colors.blue, width: 2),
                  ),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [Icon(Icons.qr_code_sharp), Text("Scan QR Opname")],
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: formkeyOpName,
                child: Column(
                  children: [
                    CustomFormFieldRead(
                      controller: controllerCodeOpName,
                      hint: 'StockOpname Code',
                      label: 'StockOpname Code',
                      msgError: 'Kolom tidak boleh kosong',
                    ),
                    const SizedBox(height: 6),
                    CustomFormFieldRead(
                      controller: controllerDate,
                      hint: 'StockOpname Date',
                      label: 'StockOpname Date',
                      msgError: 'Kolom tidak boleh kosong',
                    ),
                    const SizedBox(height: 6),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {
                  BlocProvider.of<StockOpnameCubit>(context).scanQRBarang(opname_oid, context);
                },
                splashColor: Colors.blue,
                child: Ink(
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(color: Colors.blue, width: 2),
                  ),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [Icon(Icons.qr_code_sharp), Text("Scan QR Barang")],
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: formkey,
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8.0), boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          blurRadius: 5,
                          offset: Offset(1, 2),
                        )
                      ]),
                      child: CustomFormFieldRead(
                        controller: controllerCode,
                        hint: 'Code',
                        label: 'Code',
                        msgError: 'Kolom tidak boleh kosong',
                      ),
                    ),
                    const SizedBox(height: 6),
                    Container(
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8.0), boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          blurRadius: 5,
                          offset: Offset(1, 2),
                        )
                      ]),
                      child: CustomFormFieldRead(
                        controller: controllerDesign,
                        hint: 'Design',
                        label: 'Design',
                        msgError: 'Kolom tidak boleh kosong',
                      ),
                    ),
                    const SizedBox(height: 6),
                    Container(
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8.0), boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          blurRadius: 5,
                          offset: Offset(1, 2),
                        )
                      ]),
                      child: CustomFormFieldRead(
                        controller: controllerColor,
                        hint: 'Color',
                        label: 'Color',
                        msgError: 'Kolom tidak boleh kosong',
                      ),
                    ),
                    const SizedBox(height: 6),
                    Container(
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8.0), boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          blurRadius: 5,
                          offset: Offset(1, 2),
                        )
                      ]),
                      child: CustomFormFieldRead(
                        controller: controllerQty,
                        hint: 'Qty',
                        label: 'Qty',
                        m: 'M',
                        msgError: 'Kolom tidak boleh kosong',
                      ),
                    ),
                    const SizedBox(height: 6),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                  height: 50,
                  child: CustomButtonSave(
                    judul: 'SAVE',
                    onPressed: save,
                  )),
            )
          ],
        ),
      ),
    );
  }
}
