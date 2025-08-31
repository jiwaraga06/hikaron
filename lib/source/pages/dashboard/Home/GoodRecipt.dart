part of "../../index.dart";

class GoodsReceipt extends StatefulWidget {
  const GoodsReceipt({super.key});

  @override
  State<GoodsReceipt> createState() => _GoodsReceiptState();
}

class _GoodsReceiptState extends State<GoodsReceipt> {
  final formkeyhead = GlobalKey<FormState>();
  final formkeydetail = GlobalKey<FormState>();
  TextEditingController controllerCari = TextEditingController();
  TextEditingController controllerReceiptDate = TextEditingController();
  TextEditingController controllerFromLocation = TextEditingController();
  TextEditingController controllerTransfercode = TextEditingController();
  //
  TextEditingController controllerDesign = TextEditingController();
  TextEditingController controllerColor = TextEditingController();
  TextEditingController controllerQty = TextEditingController();
  var namarack = "*";
  var transfercode, transferid, qrcode, itemId, width;
  var rackId = 0;
  bool manual = false;
  void changeManual(bool? value){
    setState(() {
      manual = !manual;
    });
  }

  void save() {
    if (formkeyhead.currentState!.validate()) {
      if (formkeydetail.currentState!.validate()) {
        // if (rackId == 0) {
        //   MyDialog.dialogAlert(context, "Rack belum dipilih");
        //   return;
        // }
        BlocProvider.of<GetissueCodeCubit>(context)
            .entry(transferid, qrcode, itemId, controllerDesign.text, controllerColor.text, width, controllerQty.text, rackId, context);
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
          backgroundColor: const Color(0XFFFF894F),
          elevation: 2,
          title: Text("Receipt", style: GoogleFonts.inter(fontWeight: FontWeight.w500)),
          actions: [
            Switch(
              value: manual,
              onChanged: changeManual
            )
          ],
        ),
        body: BlocListener<GetissueCodeCubit, GetissueCodeState>(
          listener: (context, state) {
            if (state is GetissueCodeLoading) {
              EasyLoading.show();
            }
            if (state is GetissueCodeLoaded) {
              var json = state.json;
              var statusCode = state.statusCode;
              EasyLoading.dismiss();
              if (statusCode == 200) {
                setState(() {
                  var jam = DateFormat('dd/MM/yyyy').format(DateTime.now());
                  controllerFromLocation = TextEditingController(text: json['location_from']);
                  controllerReceiptDate = TextEditingController(text: jam);
                  controllerTransfercode = TextEditingController(text: json['transfer_code']);
                  controllerDesign.clear();
                  controllerColor.clear();
                  controllerQty.clear();
                  BlocProvider.of<RackingCubit>(context).initial();
                  transfercode = json['transfer_code'];
                  transferid = null;
                  qrcode = null;
                  itemId = null;
                  width = null;
                  rackId = 0;
                });
              } else {
                MyDialog.dialogAlert(context, json['message']);
              }
            }
            if (state is GetissueCodeScanLoading) {
              EasyLoading.show();
            }
            if (state is GetissueCodeScanLoaded) {
              EasyLoading.dismiss();
              var json = state.json;
              var statusCode = state.statusCode;
              if (statusCode == 200) {
                setState(() {
                  transferid = json['transfer_id'];
                  qrcode = json['qr_code'];
                  itemId = json['item_id'];
                  width = json['width'];
                  controllerDesign = TextEditingController(text: json['design_name']);
                  controllerColor = TextEditingController(text: json['color_code']);
                  controllerQty = TextEditingController(text: json['qty'].toString());
                  BlocProvider.of<RackingCubit>(context).getRacking(itemId, context);
                });
              } else {
                MyDialog.dialogAlert(context, json['message']);
              }
            }
            if (state is GetissueCodeEntryLoading) {
              EasyLoading.show();
            }
            if (state is GetissueCodeEntryLoaded) {
              EasyLoading.dismiss();
              var statusCode = state.statusCode;
              var json = state.json;
              print(statusCode);
              if (statusCode == 200) {
                MyDialog.dialogSuccess(context, json['message']);
                setState(() {
                  controllerDesign.clear();
                  controllerColor.clear();
                  controllerQty.clear();
                  BlocProvider.of<RackingCubit>(context).initial();
                });
              } else if (statusCode == 401) {
                MyDialog.dialogInfo(context, 'Session Habis, login kembali', () {}, () {
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
                    const SizedBox(height: 6),
                    if (manual == true)
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: 40,
                            child: CustomButton2(
                              onPressed: () {
                                showModal();
                                BlocProvider.of<GoodsReceiptCubit>(context).getIssueList(context);
                              },
                              judul: 'Pilih GR',
                              style: GoogleFonts.montserrat(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white),
                            )),
                      ),
                    if (manual == false)
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CustomButtonScan(
                          onTap: () {
                            BlocProvider.of<GetissueCodeCubit>(context).scanQr(context);
                          },
                          judul: 'Scan QR',
                        ),
                      ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Form(
                          key: formkeyhead,
                          child: Column(
                            children: [
                              CustomFormFieldRead(
                                controller: controllerTransfercode,
                                hint: 'Transfer Code',
                                label: 'Transfer Code',
                                msgError: 'Kolom harus di isi',
                              ),
                              const SizedBox(height: 10),
                              CustomFormFieldRead(
                                controller: controllerFromLocation,
                                hint: 'Masukan Location',
                                label: 'From Location',
                                msgError: 'Kolom harus di isi',
                              ),
                              const SizedBox(height: 10),
                              CustomFormFieldRead(
                                controller: controllerReceiptDate,
                                hint: 'Masukan Receipt Date',
                                label: 'Receipt Date',
                                msgError: 'Kolom harus di isi',
                              ),
                            ],
                          )),
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CustomButtonScan(
                        onTap: () {
                          BlocProvider.of<GetissueCodeCubit>(context).scanQrCode(transfercode, context);
                        },
                        judul: 'Scan QR',
                      ),
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Form(
                          key: formkeydetail,
                          child: Column(
                            children: [
                              CustomFormFieldRead(
                                controller: controllerDesign,
                                hint: 'Masukan Design',
                                label: 'Design',
                                msgError: 'Kolom harus di isi',
                              ),
                              const SizedBox(height: 10),
                              CustomFormFieldRead(
                                controller: controllerColor,
                                hint: 'Masukan Color',
                                label: 'Color',
                                msgError: 'Kolom harus di isi',
                              ),
                              const SizedBox(height: 10),
                              CustomFormFieldRead(
                                controller: controllerQty,
                                hint: 'Masukan Qty',
                                label: 'Qty',
                                msgError: 'Kolom harus di isi',
                              ),
                              const SizedBox(height: 10),
                              BlocBuilder<RackingCubit, RackingState>(
                                builder: (context, state) {
                                  if (state is RackingLoading) {
                                    return DropdownSearch(
                                      popupProps: const PopupProps.menu(showSearchBox: true, fit: FlexFit.loose),
                                      items: [
                                        {"rack_id": 0, "rack_code": "*"},
                                      ].map((e) => e['rack_code']).toList(),
                                      dropdownDecoratorProps: const DropDownDecoratorProps(
                                        dropdownSearchDecoration: InputDecoration(
                                            border: OutlineInputBorder(),
                                            contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                                            hintText: "Rack Code",
                                            labelText: "Rack Code",
                                            labelStyle: TextStyle(color: Colors.black),
                                            hintStyle: TextStyle(color: Colors.black)),
                                      ),
                                      onChanged: (value) {},
                                      selectedItem: namarack,
                                    );
                                  }
                                  if (state is RackingLoaded == false) {
                                    // return CustomFormFieldRead(
                                    //   hint: 'Pilih Racking',
                                    //   label: 'Racking',
                                    // );
                                    return DropdownSearch(
                                      popupProps: const PopupProps.menu(showSearchBox: true, fit: FlexFit.loose),
                                      items: [
                                        {"rack_id": 0, "rack_code": "*"},
                                      ].map((e) => e['rack_code']).toList(),
                                      dropdownDecoratorProps: const DropDownDecoratorProps(
                                        dropdownSearchDecoration: InputDecoration(
                                            border: OutlineInputBorder(),
                                            contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                                            hintText: "Rack Code",
                                            labelText: "Rack Code",
                                            labelStyle: TextStyle(color: Colors.black),
                                            hintStyle: TextStyle(color: Colors.black)),
                                      ),
                                      onChanged: (value) {},
                                      selectedItem: namarack,
                                    );
                                  }
                                  var data = (state as RackingLoaded).json;
                                  return Container(
                                    padding: const EdgeInsets.only(left: 2, right: 2),
                                    child: DropdownSearch(
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
                                      onChanged: (value) {
                                        print(value);
                                        setState(() {
                                          data.where((e) => e['rack_code'] == value).forEach((a) {
                                            rackId = a['rack_id'];
                                            namarack = a['rack_code'];
                                          });
                                        });
                                      },
                                      selectedItem: namarack,
                                    ),
                                  );
                                },
                              )
                            ],
                          )),
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(width: MediaQuery.of(context).size.width, height: 50, child: CustomButtonSave(judul: 'SAVE', onPressed: save)),
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
                              decoration: InputDecoration(hintText: 'Cari Code', prefixIcon: Icon(Icons.search)),
                              onChanged: (value) {
                                BlocProvider.of<GoodsReceiptCubit>(context).searchData(value);
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    BlocBuilder<GoodsReceiptCubit, GoodsReceiptState>(
                      builder: (context, state) {
                        if (state is GoodsReceiptLoading) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        if (state is GoodsReceiptLoaded == false) {
                          return Container();
                        }
                        var json = (state as GoodsReceiptLoaded).json;
                        var statusCode = (state as GoodsReceiptLoaded).statusCode;
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
                                  title: "Logout",
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
                                  BlocProvider.of<GetissueCodeCubit>(context).getIssueCode(data['transfer_code'], context);
                                  Navigator.pop(context);
                                },
                                leading: Icon(Icons.format_list_bulleted),
                                title: Text(data['transfer_code']),
                                subtitle: Text(data['location_from']),
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
