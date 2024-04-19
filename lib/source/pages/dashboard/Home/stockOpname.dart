part of "../../index.dart";

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
  TextEditingController controllerCari = TextEditingController();
  //
  TextEditingController controllerCodeOpName = TextEditingController();
  TextEditingController controllerDate = TextEditingController();
  TextEditingController controllerOid = TextEditingController();
  TextEditingController controllerCode = TextEditingController();
  TextEditingController controllerDesign = TextEditingController();
  TextEditingController controllerColor = TextEditingController();
  TextEditingController controllerQty = TextEditingController();
  bool manual = false;

  void save() {
    if (formkeyOpName.currentState!.validate()) {
      if (formkey.currentState!.validate()) {
        BlocProvider.of<StockOpnameCubit>(context).entryStockOpname(
          stockopnamed_oid,
          stockopnamed_stockopname_oid,
          stockopnamed_pt_id,
          controllerCode.text,
          controllerQty.text,
          context,
        );
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
          backgroundColor: Colors.white,
          elevation: 0.0,
          title: Text('Stock Opname'),
          actions: [
            Switch(
              value: manual,
              onChanged: (value) {
                setState(() {
                  manual = !manual;
                });
              },
            )
          ],
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
                  var jam = DateFormat('dd/MM/yyyy').format(DateTime.parse(json['stockopname_date']));
                  opname_oid = json['stockopname_oid'];
                  controllerOid = TextEditingController(text: json['stockopname_oid']);
                  controllerDate = TextEditingController(text: jam);
                  controllerCodeOpName = TextEditingController(text: json['stockopname_code']);
                  controllerCode.clear();
                  controllerDesign.clear();
                  controllerColor.clear();
                  controllerQty.clear();
                });
              } else {
                MyDialog.dialogAlert(context, '${json['message']}');
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
                MyDialog.dialogAlert(context, '${json['message']}');
              }
            }
            if (state is EntryStockLoading) {
              EasyLoading.show();
            }
            if (state is EntryStockLoaded) {
              EasyLoading.dismiss();
              var json = state.json;
              var statusCode = state.statusCode;
              if (statusCode == 200) {
                MyDialog.dialogSuccess(context, json['message']);
                controllerCode.clear();
                controllerDesign.clear();
                controllerColor.clear();
                controllerQty.clear();
              } else if (statusCode == 401) {
                MyDialog.dialogInfo(context, 'Apakah Anda Ingin Keluar ?', () {}, () {
                  BlocProvider.of<ProfileCubit>(context).logout(context);
                });
              } else {
                MyDialog.dialogAlert(context, json['title']);
              }
            }
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: ListView(
                  children: [
                    manual
                        ? Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                                width: MediaQuery.of(context).size.width,
                                height: 40,
                                child: CustomButton2(
                                  onPressed: () {
                                    showModal();
                                    BlocProvider.of<StockOpnameListCubit>(context).getStockOpnameList(context);
                                  },
                                  judul: 'Pilih Opname',
                                  style: GoogleFonts.montserrat(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white),
                                )),
                          )
                        : Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CustomButtonScan(
                              onTap: () {
                                BlocProvider.of<StockOpnameCubit>(context).scanQROpname(context);
                              },
                              judul: 'Scan QR Opname',
                            )),
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
                        child: CustomButtonScan(
                          onTap: () {
                            BlocProvider.of<StockOpnameCubit>(context).scanQRBarang(opname_oid, context);
                          },
                          judul: 'Scan QR Barang',
                        )),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Form(
                        key: formkey,
                        child: Column(
                          children: [
                            CustomFormFieldRead(
                              controller: controllerCode,
                              hint: 'Code',
                              label: 'Code',
                              msgError: 'Kolom tidak boleh kosong',
                            ),
                            const SizedBox(height: 6),
                            CustomFormFieldRead(
                              controller: controllerDesign,
                              hint: 'Design',
                              label: 'Design',
                              msgError: 'Kolom tidak boleh kosong',
                            ),
                            const SizedBox(height: 6),
                            CustomFormFieldRead(
                              controller: controllerColor,
                              hint: 'Color',
                              label: 'Color',
                              msgError: 'Kolom tidak boleh kosong',
                            ),
                            const SizedBox(height: 6),
                            CustomFormFieldRead(
                              controller: controllerQty,
                              hint: 'Qty',
                              label: 'Qty',
                              m: 'M',
                              msgError: 'Kolom tidak boleh kosong',
                            ),
                            const SizedBox(height: 6),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    child: CustomButtonSave(
                      judul: 'SAVE',
                      onPressed: save,
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showModal() {
    showModalBottomSheet(
        context: context,
        builder: (context) => StatefulBuilder(
              builder: (context, setState) {
                return Column(
                  children: [
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Row(
                            children: [
                              Icon(Icons.close),
                              Text('Tutup'),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width / 1.5,
                            child: TextFormField(
                              controller: controllerCari,
                              decoration: InputDecoration(hintText: 'Cari Opname', prefixIcon: Icon(Icons.search)),
                              onChanged: (value) {
                                BlocProvider.of<StockOpnameListCubit>(context).searchData(value);
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    BlocBuilder<StockOpnameListCubit, StockOpnameListState>(
                      builder: (context, state) {
                        if (state is StockOpnameListLoading) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        if (state is StockOpnameListLoaded == false) {
                          return Container();
                        }
                        var json = (state as StockOpnameListLoaded).json;
                        var statusCode = (state as StockOpnameListLoaded).statusCode;
                        if (json.isEmpty) {
                          return Container();
                        }
                        if (statusCode == 401) {
                          return Container(
                            height: 200,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Session Habis, silahkan login kembali"),
                                const SizedBox(height: 10),
                                CustomButton(
                                  judul: "Logout",
                                  onTap: () {
                                    MyDialog.dialogInfo(context, 'Apakah Anda Ingin Keluar ?', () {}, () {
                                      BlocProvider.of<ProfileCubit>(context).logout(context);
                                    });
                                  },
                                )
                              ],
                            ),
                          );
                        }
                        return Expanded(
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: json.length,
                            itemBuilder: (context, index) {
                              var data = json[index];
                              return ListTile(
                                onTap: () {
                                  print(data);
                                  BlocProvider.of<StockOpnameCubit>(context).getOpname(data['stockopname_code'], context);
                                  Navigator.pop(context);
                                },
                                leading: Icon(Icons.format_list_bulleted),
                                title: Text(data['stockopname_code']),
                              );
                            },
                          ),
                        );
                      },
                    ),
                  ],
                );
              },
            ));
  }
}
