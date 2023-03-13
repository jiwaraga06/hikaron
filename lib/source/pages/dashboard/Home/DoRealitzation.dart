import 'package:flutter/material.dart';
import 'package:hikaron/source/widget/buttonSave.dart';
import 'package:hikaron/source/widget/buttonScan.dart';
import 'package:hikaron/source/widget/customTextFieldRead.dart';

class DoRealization extends StatefulWidget {
  const DoRealization({super.key});

  @override
  State<DoRealization> createState() => _DoRealizationState();
}

class _DoRealizationState extends State<DoRealization> {
  TextEditingController controllerDoDate = TextEditingController();
  TextEditingController controllerCustomer = TextEditingController();
  TextEditingController controllerDesign = TextEditingController();
  TextEditingController controllerColor = TextEditingController();
  TextEditingController controllerJointPeice = TextEditingController();
  TextEditingController controllerGrade = TextEditingController();
  TextEditingController controllerBatch = TextEditingController();
  TextEditingController controllerQty = TextEditingController();
  final formKeyStockOpname = GlobalKey<FormState>();
  final formKeyBarang = GlobalKey<FormState>();
  void save() {
    if (formKeyStockOpname.currentState!.validate()) {
      if (formKeyBarang.currentState!.validate()) {}
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF3A1078),
        elevation: 0.0,
        title: Text('DO Realization'),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CustomButtonScan(
              onTap: () {},
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
                    controller: controllerDoDate,
                    hint: 'Masukan Do Date',
                    label: 'Do Date',
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
              onTap: () {},
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
                    hint: 'Masukan Joint Peice',
                    label: 'Joint Peice',
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
    );
  }
}
