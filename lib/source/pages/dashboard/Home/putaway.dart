part of "../../index.dart";

class PutAwayScreen extends StatefulWidget {
  const PutAwayScreen({super.key});

  @override
  State<PutAwayScreen> createState() => _PutAwayScreenState();
}

class _PutAwayScreenState extends State<PutAwayScreen> {
  final formkeyhead = GlobalKey<FormState>();
  TextEditingController controllerDate = TextEditingController();
  TextEditingController controllerRemarks = TextEditingController();
  TextEditingController controllerRackCode = TextEditingController();
  var putaway_to_rack_id, putaway_to_rack_code;
  bool manual = false;
  void changeManual(bool? value) {
    setState(() {
      manual = !manual;
      if (manual) {
        BlocProvider.of<RacklistPutAwayCubit>(context).getRackList(context);
      }
    });
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

  void addDetail(json) {
    setState(() {
      if (modelPutaway.where((e) => e.barcode == json['barcode']).isEmpty) {
        ModelEntryPutAway data = ModelEntryPutAway(
          barcode: json['barcode'],
          pt_id: json['pt_id'],
          qty: json['qty'],
          from_rack_id: json['from_rack_id'],
          to_rack_id: putaway_to_rack_id,
        );
        modelPutaway.add(data);
      } else {
        MyDialog.dialogInfo(context, "Data sudah ditambahkan", () {}, () {});
      }
    });
  }

  void delete(val) {
    setState(() {
      modelPutaway.removeWhere((e) => e.barcode == val);
    });
  }

  void clear() {
    setState(() {
      modelPutaway.clear();
      controllerRemarks.clear();
      controllerRackCode.clear();
      putaway_to_rack_id = null;
      putaway_to_rack_code = null;
    });
  }

  void insert() {
    if (modelPutaway.isEmpty) {
      MyDialog.dialogAlert(context, "Detail masih kosong");
      return;
    }
    if (putaway_to_rack_id == "*") {
      MyDialog.dialogAlert(context, "Rack List belum dipilih");
      return;
    }

    BlocProvider.of<InsertPutAwayCubit>(context).insert(controllerDate.text, controllerRemarks.text, putaway_to_rack_id, putaway_to_rack_code, context);
  }

  @override
  void initState() {
    super.initState();
    var format = DateFormat('yyyy-MM-dd');
    var date = format.format(DateTime.now());
    controllerDate = TextEditingController(text: date.toString());
    BlocProvider.of<RacklistPutAwayCubit>(context).getRackList(context);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        MyDialog.dialogInfo(context, 'Apakah Anda ingin keluar ? ', () {}, () {
          Navigator.pop(context);
          clear();
        });
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0XFFFF894F),
          elevation: 2,
          title: Text("Put Away", style: GoogleFonts.inter(fontWeight: FontWeight.w500)),
          actions: [Switch(value: manual, onChanged: changeManual)],
        ),
        body: BlocListener<InsertPutAwayCubit, InsertPutAwayState>(
          listener: (context, state) {
            if (state is InsertPutAwayLoading) {
              EasyLoading.show();
            }
            if (state is InsertPutAwayLoaded) {
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                  child: ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Form(
                      key: formkeyhead,
                      child: Column(
                        children: [
                          const SizedBox(height: 10),
                          CustomFormFieldRead(
                            onTap: datepick,
                            controller: controllerDate,
                            hint: 'Masukan Tanggal',
                            label: 'Tanggal',
                            msgError: 'Kolom harus di isi',
                          ),
                          const SizedBox(height: 10),
                          if (manual == true)
                            BlocBuilder<RacklistPutAwayCubit, RacklistPutAwayState>(
                              builder: (context, state) {
                                if (state is RacklistPutAwayLoading) {
                                  return DropdownSearch(
                                    popupProps: const PopupProps.menu(showSearchBox: true, fit: FlexFit.loose),
                                    items: [].map((e) => e).toList(),
                                    dropdownDecoratorProps: const DropDownDecoratorProps(
                                      dropdownSearchDecoration: InputDecoration(
                                          border: OutlineInputBorder(),
                                          contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                                          hintText: "Rack Code",
                                          labelText: "Rack Lisode",
                                          labelStyle: TextStyle(color: Colors.black),
                                          hintStyle: TextStyle(color: Colors.black)),
                                    ),
                                  );
                                }
                                if (state is RacklistPutAwayLoaded == false) {
                                  return DropdownSearch(
                                    popupProps: const PopupProps.menu(showSearchBox: true, fit: FlexFit.loose),
                                    items: [].map((e) => e).toList(),
                                    dropdownDecoratorProps: const DropDownDecoratorProps(
                                      dropdownSearchDecoration: InputDecoration(
                                          border: OutlineInputBorder(),
                                          contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                                          hintText: "Rack Code",
                                          labelText: "Rack Code",
                                          labelStyle: TextStyle(color: Colors.black),
                                          hintStyle: TextStyle(color: Colors.black)),
                                    ),
                                  );
                                }
                                var data = (state as RacklistPutAwayLoaded).json;
                                return DropdownSearch(
                                  popupProps: const PopupProps.menu(showSearchBox: true, fit: FlexFit.loose),
                                  items: data.map((e) => e['rack_code']).toList(),
                                  dropdownDecoratorProps: const DropDownDecoratorProps(
                                    dropdownSearchDecoration: InputDecoration(
                                        border: OutlineInputBorder(),
                                        contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                                        hintText: "Rack Code",
                                        labelText: "Rack Code",
                                        labelStyle: TextStyle(color: Colors.black),
                                        hintStyle: TextStyle(color: Colors.black)),
                                  ),
                                  selectedItem: putaway_to_rack_code,
                                  onChanged: (value) {
                                    setState(() {
                                      print("disana");
                                      data.where((e) => e['rack_code'] == value).forEach((a) {
                                        putaway_to_rack_code = a['rack_code'];
                                        putaway_to_rack_id = a['rack_id'];
                                        controllerRackCode = TextEditingController(text: a['rack_code']);
                                      });
                                    });
                                  },
                                );
                              },
                            ),
                          if (manual == false)
                            BlocListener<RacklistPutAwayCubit, RacklistPutAwayState>(
                              listener: (context, state) {
                                if (state is RacklistPutAwayLoaded) {
                                  var json = state.json;
                                  var statusCode = state.statusCode;
                                  if (statusCode == 200) {
                                    print('insert');
                                    setState(() {
                                      controllerRackCode = TextEditingController(text: json['rack_code']);
                                      putaway_to_rack_code = json['rack_code'];
                                      putaway_to_rack_id = json['rack_id'];
                                    });
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
                                children: [
                                  CustomButtonScan(
                                    onTap: () {
                                      BlocProvider.of<RacklistPutAwayCubit>(context).scanQr(context);
                                    },
                                    judul: 'Scan QR Rack',
                                  ),
                                  const SizedBox(height: 10),
                                  CustomFormFieldRead(
                                    controller: controllerRackCode,
                                    hint: 'Rack Code',
                                    label: 'Rack Code',
                                    msgError: 'Kolom harus di isi',
                                  ),
                                ],
                              ),
                            ),
                          const SizedBox(height: 10),
                          CustomFormField(
                            readOnly: false,
                            obSecureText: false,
                            controller: controllerRemarks,
                            hint: 'Remarks',
                            label: 'Remarks',
                            msgError: 'Kolom harus di isi',
                          ),
                          const SizedBox(height: 10),
                          BlocListener<ScanQrRackCubit, ScanQrRackState>(
                            listener: (context, state) {
                              if (state is ScanQrRackLoaded) {
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
                            child: CustomButtonScan(
                              onTap: () {
                                BlocProvider.of<ScanQrRackCubit>(context).scanQr(putaway_to_rack_code, context);
                              },
                              judul: 'Scan QR Barang',
                            ),
                          ),
                        ],
                      ),
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
                    itemCount: modelPutaway.length,
                    itemBuilder: (context, index) {
                      var a = modelPutaway[index];
                      return Slidable(
                        key: const ValueKey(0),
                        startActionPane: ActionPane(
                          motion: const DrawerMotion(),
                          children: [
                            SlidableAction(
                              onPressed: (context) {
                                delete(a.barcode);
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
                                Text(a.barcode!, style: const TextStyle(fontSize: 20)),
                              ],
                            ),
                            subtitle: Table(
                              columnWidths: const {0: FixedColumnWidth(90), 1: FixedColumnWidth(10)},
                              children: [
                                const TableRow(children: [SizedBox(height: 4), SizedBox(height: 4), SizedBox(height: 4)]),
                                TableRow(children: [
                                  const Text("PT ID", style: const TextStyle(fontSize: 16)),
                                  const Text(":", style: const TextStyle(fontSize: 16)),
                                  Text(a.pt_id.toString(), style: const TextStyle(fontSize: 16))
                                ]),
                                const TableRow(children: [SizedBox(height: 4), SizedBox(height: 4), SizedBox(height: 4)]),
                                TableRow(children: [
                                  const Text("QTY", style: const TextStyle(fontSize: 16)),
                                  const Text(":", style: const TextStyle(fontSize: 16)),
                                  Text(a.qty.toString(), style: const TextStyle(fontSize: 16))
                                ]),
                                const TableRow(children: [SizedBox(height: 4), SizedBox(height: 4), SizedBox(height: 4)]),
                                TableRow(children: [
                                  const Text("From Rack", style: const TextStyle(fontSize: 16)),
                                  const Text(":", style: const TextStyle(fontSize: 16)),
                                  Text(a.from_rack_id.toString(), style: const TextStyle(fontSize: 16))
                                ]),
                                const TableRow(children: [SizedBox(height: 4), SizedBox(height: 4), SizedBox(height: 4)]),
                                TableRow(children: [
                                  const Text("To Rack", style: const TextStyle(fontSize: 16)),
                                  const Text(":", style: const TextStyle(fontSize: 16)),
                                  Text(a.to_rack_id.toString(), style: const TextStyle(fontSize: 16))
                                ]),
                                const TableRow(children: [SizedBox(height: 4), SizedBox(height: 4), SizedBox(height: 4)]),
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
                child: SizedBox(width: MediaQuery.of(context).size.width, height: 50, child: CustomButtonSave(judul: 'SAVE', onPressed: insert)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
