import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hikaron/source/data/Home/DoRealization/cubit/do_realization_cubit.dart';
import 'package:hikaron/source/widget/buttonSave.dart';
import 'package:hikaron/source/widget/buttonScan.dart';
import 'package:hikaron/source/widget/customDialog.dart';
import 'package:hikaron/source/widget/customTextFieldRead.dart';
import 'package:intl/intl.dart';

class DoRealization extends StatefulWidget {
  const DoRealization({super.key});

  @override
  State<DoRealization> createState() => _DoRealizationState();
}

class _DoRealizationState extends State<DoRealization> {
  TextEditingController controllerDoCode = TextEditingController();
  TextEditingController controllerDoDate = TextEditingController();
  TextEditingController controllerCustomer = TextEditingController();
  TextEditingController controllerRolOpenDO = TextEditingController();
  TextEditingController controllerDesign = TextEditingController();
  TextEditingController controllerColor = TextEditingController();
  TextEditingController controllerJointPeice = TextEditingController();
  TextEditingController controllerGrade = TextEditingController();
  TextEditingController controllerBatch = TextEditingController();
  TextEditingController controllerQty = TextEditingController();
  var do_code, dod_oid, pt_id, qr_code, grade_id, roll, price_mtr, is_foc, is_cons;
  final formKeyStockOpname = GlobalKey<FormState>();
  final formKeyBarang = GlobalKey<FormState>();
  void save() {
    if (formKeyStockOpname.currentState!.validate()) {
      if (formKeyBarang.currentState!.validate()) {
        BlocProvider.of<DoRealizationCubit>(context)
            .entryDoOpname(dod_oid, pt_id, qr_code, grade_id, roll, controllerQty.text, price_mtr, is_foc, is_cons, context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        MyDialog.dialogInfo(context, 'Apakah Anda ingin keluar ? ', () {}, () {
          Navigator.pop(context);
        });
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF3A1078),
          elevation: 0.0,
          title: Text('Packing List'),
        ),
        body: BlocListener<DoRealizationCubit, DoRealizationState>(
          listener: (context, state) {
            if (state is DoOpnameLoading) {
              EasyLoading.show();
            }
            if (state is DoOpnameLoaded) {
              var json = state.json;
              var statusCode = state.statusCode;
              EasyLoading.dismiss();
              if (statusCode == 200) {
                setState(() {
                  var jam = DateFormat('dd/MM/yyyy').format(DateTime.parse(json['do_date']));
                  controllerDoCode = TextEditingController(text: json['do_code'].toString());
                  controllerDoDate = TextEditingController(text: jam);
                  controllerCustomer = TextEditingController(text: json['ptnr_name']);
                  do_code = json['do_code'];
                  controllerRolOpenDO.clear();
                  controllerDesign.clear();
                  controllerColor.clear();
                  controllerJointPeice.clear();
                  controllerGrade.clear();
                  controllerBatch.clear();
                  controllerQty.clear();
                  dod_oid = null;
                  pt_id = null;
                  qr_code = null;
                  grade_id = null;
                  roll = null;
                  price_mtr = null;
                  is_foc = null;
                  is_cons = null;
                });
              } else {
                MyDialog.dialogAlert(context, json['message']);
              }
            }
            if (state is DoBarangLoading) {
              EasyLoading.show();
            }
            if (state is DoBarangLoaded) {
              EasyLoading.dismiss();
              var json = state.json;
              var statusCode = state.statusCode;
              if (statusCode == 200) {
                setState(() {
                  controllerRolOpenDO = TextEditingController(text: json['roll_open_do'].toString());
                  controllerDesign = TextEditingController(text: json['design_name']);
                  controllerColor = TextEditingController(text: json['color_code']);
                  controllerJointPeice = TextEditingController(text: json['joint_piece']);
                  controllerGrade = TextEditingController(text: json['grade']);
                  controllerBatch = TextEditingController(text: json['batch']);
                  controllerQty = TextEditingController(text: json['qty'].toString());
                  dod_oid = json['dod_oid'];
                  pt_id = json['pt_id'];
                  qr_code = json['qr_code'];
                  grade_id = json['grade_id'];
                  roll = json['roll'];
                  price_mtr = json['price_mtr'];
                  is_foc = json['is_foc'];
                  is_cons = json['is_cons'];
                });
              } else {
                MyDialog.dialogAlert(context, json['message']);
              }
            }
            if (state is EntryDoLoading) {
              EasyLoading.show();
            }
            if (state is EntryDoLoaded) {
              EasyLoading.dismiss();
              var statusCode = state.statusCode;
              var json = state.json;
              print(statusCode);
              if (statusCode == 200) {
                MyDialog.dialogSuccess(context, json['message']);
                setState(() {
                  controllerRolOpenDO.clear();
                  controllerDesign.clear();
                  controllerColor.clear();
                  controllerJointPeice.clear();
                  controllerGrade.clear();
                  controllerBatch.clear();
                  controllerQty.clear();
                });
              } else if (statusCode == 401) {
                MyDialog.dialogAlert(context, json['message']);
              } else {
                MyDialog.dialogAlert(context, json['title']);
              }
            }
          },
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CustomButtonScan(
                        onTap: () {
                          BlocProvider.of<DoRealizationCubit>(context).scanQrDo(context);
                        },
                        judul: 'Scan DO Stock Opname',
                      ),
                    ),
                    const SizedBox(height: 6),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Form(
                        key: formKeyStockOpname,
                        child: Column(
                          children: [
                            CustomFormFieldRead(
                              controller: controllerDoCode,
                              hint: 'Masukan DO Code',
                              label: 'DO Code',
                              msgError: 'Kolom harus di isi',
                            ),
                            CustomFormFieldRead(
                              controller: controllerDoDate,
                              hint: 'Masukan DO Date',
                              label: 'DO Date',
                              msgError: 'Kolom harus di isi',
                            ),
                            const SizedBox(height: 6),
                            CustomFormFieldRead(
                              controller: controllerCustomer,
                              hint: 'Masukan Customer',
                              label: 'Customer',
                              msgError: 'Kolom harus di isi',
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CustomButtonScan(
                        onTap: () {
                          BlocProvider.of<DoRealizationCubit>(context).scanQrBarang(do_code, context);
                        },
                        judul: 'Scan QR Barang',
                      ),
                    ),
                    const SizedBox(height: 6),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Form(
                        key: formKeyBarang,
                        child: Column(
                          children: [
                            CustomFormFieldRead(
                              controller: controllerRolOpenDO,
                              hint: 'Masukan Rol Open DO',
                              label: 'Rol Open DO',
                              msgError: 'Kolom harus di isi',
                            ),
                            const SizedBox(height: 6),
                            CustomFormFieldRead(
                              controller: controllerDesign,
                              hint: 'Masukan Design',
                              label: 'Design',
                              msgError: 'Kolom harus di isi',
                            ),
                            const SizedBox(height: 6),
                            CustomFormFieldRead(
                              controller: controllerColor,
                              hint: 'Masukan Color',
                              label: 'Color',
                              msgError: 'Kolom harus di isi',
                            ),
                            const SizedBox(height: 6),
                            CustomFormFieldRead(
                              controller: controllerJointPeice,
                              hint: 'Masukan Joint Piece',
                              label: 'Joint Piece',
                              msgError: 'Kolom harus di isi',
                            ),
                            const SizedBox(height: 6),
                            CustomFormFieldRead(
                              controller: controllerGrade,
                              hint: 'Masukan Grade',
                              label: 'Grade',
                              msgError: 'Kolom harus di isi',
                            ),
                            const SizedBox(height: 6),
                            CustomFormFieldRead(
                              controller: controllerBatch,
                              hint: 'Masukan Batch',
                              label: 'Batch',
                              msgError: 'Kolom harus di isi',
                            ),
                            const SizedBox(height: 6),
                            CustomFormFieldRead(
                              controller: controllerQty,
                              hint: 'Masukan Quantity',
                              label: 'Qty',
                              m: 'M',
                              msgError: 'Kolom harus di isi',
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SliverFillRemaining(
                hasScrollBody: false,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: 50,
                          child: CustomButtonSave(
                            judul: 'SAVE',
                            onPressed: save,
                          )),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
