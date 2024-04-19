part of "../../index.dart";

class ReturnScreem extends StatefulWidget {
  const ReturnScreem({super.key});

  @override
  State<ReturnScreem> createState() => _ReturnScreemState();
}

class _ReturnScreemState extends State<ReturnScreem> {
  final formkeyhead = GlobalKey<FormState>();
  final formkeydetail = GlobalKey<FormState>();
  TextEditingController controllerDate = TextEditingController();
  //
  TextEditingController controllerDesign = TextEditingController();
  TextEditingController controllerColor = TextEditingController();
  TextEditingController controllerQty = TextEditingController();

  void addDetail(json) {
    setState(() {
      if (model.where((e) => e.gudangtrandBarcode == json['barcode']).isEmpty) {
        ModelEntryReturnIssue data = ModelEntryReturnIssue(
            designName: json['design_name'],
            colorCode: json['color_code'],
            gudangtrandBarcode: json['barcode'],
            unitCode: json['unit_code'],
            gudangtrandPtId: json['pt_id'],
            gudangtrandWidth: json['width'],
            gudangtrandLength: json['qty']);
        model.add(data);
      } else {
        MyDialog.dialogInfo(context, "Data sudah ditambahkan", () {}, () {});
      }
    });
  }

  void delete(val) {
    setState(() {
      model.removeWhere((e) => e.gudangtrandBarcode == val);
    });
  }

  void clear() {
    setState(() {
      model.clear();
    });
  }

  void save() {
    if (model.isNotEmpty) {
      BlocProvider.of<ReturnCubit>(context).entry(controllerDate.text, context);
    } else {
      MyDialog.dialogAlert(context, "Detail masih kosong");
    }
  }

  void datepick() {
    showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime(2020), lastDate: DateTime.now()).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        print(pickedDate);
        controllerDate = TextEditingController(text: pickedDate.toString().split(' ')[0]);
      });
    });
  }

  @override
  void initState() {
    super.initState();
    var format = DateFormat('yyyy-MM-dd');
    var date = format.format(DateTime.now());
    controllerDate = TextEditingController(text: date.toString());
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        MyDialog.dialogInfo(context, 'Apakah Anda ingin keluar ? ', () {}, () {
          clear();
          Navigator.pop(context);
        });
        return true;
      },
      child: Scaffold(
        appBar: AppBar(title: const Text("Return To Production")),
        body: BlocListener<ReturnCubit, ReturnState>(
          listener: (context, state) {
            if (state is EntryReturnLoading) {
              EasyLoading.show();
            }
            if (state is EntryReturnLoaded) {
              var json = state.json;
              var statusCode = state.statusCode;
              EasyLoading.dismiss();
              if (statusCode == 200) {
                clear();
                MyDialog.dialogSuccess(context, json['message']);
              } else if (statusCode == 401) {
                MyDialog.dialogInfo(context, 'Apakah Anda Ingin Keluar ?', () {}, () {
                  BlocProvider.of<ProfileCubit>(context).logout(context);
                });
              } else {
                MyDialog.dialogAlert(context, json['message']);
              }
            }
          },
          child: BlocListener<GetdataqrCubit, GetdataqrState>(
            listener: (context, state) {
              if (state is GetdataqrLoaded) {
                var json = state.json;
                var statusCode = state.statusCode;
                if (statusCode == 200) {
                  print('insert');
                  addDetail(json);
                } else if (statusCode == 401) {
                  MyDialog.dialogInfo(context, 'Apakah Anda Ingin Keluar ?', () {}, () {
                    BlocProvider.of<ProfileCubit>(context).logout(context);
                  });
                } else {
                  MyDialog.dialogAlert(context, json['message']);
                }
              }
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                    child: ListView(
                  children: [
                    Form(
                        key: formkeyhead,
                        child: Column(
                          children: [
                            CustomFormFieldRead(
                              onTap: datepick,
                              controller: controllerDate,
                              hint: 'Masukan Tanggal',
                              label: 'Tanggal',
                              msgError: 'Kolom harus di isi',
                            ),
                            const SizedBox(height: 10),
                          ],
                        )),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CustomButtonScan(
                        onTap: () {
                          BlocProvider.of<GetdataqrCubit>(context).getDataQr(context);
                        },
                        judul: 'Scan QR',
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Padding(
                      padding: EdgeInsets.only(left: 8.0, right: 8.0),
                      child: Text("Detail Item", style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500)),
                    ),
                    const SizedBox(height: 10),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: model.length,
                      itemBuilder: (context, index) {
                        var a = model[index];
                        return Slidable(
                          key: const ValueKey(0),
                          startActionPane: ActionPane(
                            motion: const DrawerMotion(),
                            children: [
                              SlidableAction(
                                onPressed: (context) {
                                  delete(a.gudangtrandBarcode);
                                },
                                backgroundColor: Colors.red,
                                foregroundColor: Colors.white,
                                icon: Icons.delete_outline,
                                label: 'DELETE',
                              ),
                            ],
                          ),
                          child: Container(
                            margin: const EdgeInsets.all(8),
                            // padding: const EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(4.0),
                              border: Border.all(color: Colors.grey.withOpacity(0.2), width: 1),
                              boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.5), blurRadius: 1.3, spreadRadius: 1.2, offset: const Offset(1, 2))],
                            ),
                            child: ListTile(
                              title: Row(
                                children: [
                                  const Icon(Icons.qr_code_2, size: 35),
                                  const SizedBox(width: 6),
                                  Text(a.gudangtrandBarcode!, style: const TextStyle(fontSize: 20)),
                                ],
                              ),
                              subtitle: Table(
                                columnWidths: const {0: FixedColumnWidth(90), 1: FixedColumnWidth(10)},
                                children: [
                                  const TableRow(children: [SizedBox(height: 4), SizedBox(height: 4), SizedBox(height: 4)]),
                                  TableRow(children: [const Text("Design",style: const TextStyle(fontSize: 16)), const Text(":",style: const TextStyle(fontSize: 16)), Text(a.designName!,style: const TextStyle(fontSize: 16))]),
                                  const TableRow(children: [SizedBox(height: 4), SizedBox(height: 4), SizedBox(height: 4)]),
                                  TableRow(children: [const Text("Color", style: const TextStyle(fontSize: 16)), const Text(":", style: const TextStyle(fontSize: 16)), Text(a.colorCode!, style: const TextStyle(fontSize: 16))]),
                                  const TableRow(children: [SizedBox(height: 4), SizedBox(height: 4), SizedBox(height: 4)]),
                                  TableRow(children: [const Text("QTY",style: const TextStyle(fontSize: 16)), const Text(":",style: const TextStyle(fontSize: 16)), Row(
                                    children: [
                                      Text(a.gudangtrandLength.toString(), style: const TextStyle(fontSize: 16)),
                                      const SizedBox(width: 6),
                                      Text(a.unitCode!, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16))
                                    ],
                                  )]),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 10),
                  ],
                )),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(width: MediaQuery.of(context).size.width, height: 50, child: CustomButtonSave(judul: 'SAVE', onPressed: save)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
