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
  void save() {}

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
          title: Text("Return"),
        ),
        body: Column(
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
                          controller: controllerDate,
                          hint: 'Masukan Tanggal',
                          label: 'Tanggal',
                          msgError: 'Kolom harus di isi',
                        ),
                        const SizedBox(height: 10),
                        CustomFormFieldRead(
                          controller: controllerDate,
                          hint: 'Masukan Location',
                          label: 'To Location',
                          msgError: 'Kolom harus di isi',
                        ),
                        const SizedBox(height: 10),
                      ],
                    )),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomButtonScan(
                    onTap: () {},
                    judul: 'Scan QR',
                  ),
                ),
                const SizedBox(height: 10),
                Form(
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
                      ],
                    )),
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
    );
  }
}
