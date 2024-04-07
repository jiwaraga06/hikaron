import 'package:hikaron/source/network/api.dart';
import 'package:hikaron/source/network/network.dart';

class MyRepository {
  Future login(context, username, pass) async {
    var json = await network(url: MyApi.login(username, pass), method: "GET", body: null, context: context);
    return json;
  }

  Future getOpnameCode(qr_code, context) async {
    var json = await network(url: MyApi.getOpnameCode(qr_code), method: "GET", body: null, context: context);
    return json;
  }

  Future getStockOpnameList(context) async {
    var json = await network(url: MyApi.getOpnameList(), method: "GET", body: null, context: context);

    return json;
  }

  Future getBarangCode(opname_oid, qr_code, context) async {
    var json = await network(url: MyApi.getBarangCode(opname_oid, qr_code), method: "GET", body: null, context: context);
    //
    return json;
  }

  Future entryStockOpname(body, context) async {
    var json = await network(url: MyApi.entryStockOpname(), method: "POST", body: body, context: context);

    return json;
  }

  // DO REALIZATION
  Future doCode(do_code, context) async {
    var json = await network(url: MyApi.doCode(do_code), method: "GET", body: null, context: context);

    return json;
  }

  Future doBarang(do_code, qr_code, context) async {
    var json = await network(url: MyApi.doBarang(do_code, qr_code), method: "GET", body: null, context: context);
    //
    return json;
  }

  Future entryDoOpname(body, context) async {
    var json = await network(url: MyApi.entryDoOpname(), method: "POST", body: body, context: context);

    return json;
  }

  Future getDoList(context) async {
    var json = await network(url: MyApi.getDOList(), method: "GET", body: null, context: context);

    return json;
  }
}
