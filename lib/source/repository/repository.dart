import 'package:hikaron/source/network/network.dart';

class MyRepository {
  final MyNetwork? myNetwork;
  MyRepository({required this.myNetwork});

  Future login(context, username, pass) async {
    var json = await myNetwork!.login(username, pass, context);
    return json;
  }

  Future getOpnameCode(qr_code, context) async {
    var json = await myNetwork!.getOpnameCode(qr_code, context);
    return json;
  }

  Future getBarangCode(opname_oid, qr_code, context) async {
    var json = await myNetwork!.getBarangCode(opname_oid, qr_code, context);
    return json;
  }
  Future entryStockOpname(body, context) async {
    var json = await myNetwork!.entryStockOpname(body, context);
    return json;
  }
}
