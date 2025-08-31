import 'package:hikaron/source/network/api.dart';
import 'package:hikaron/source/network/network.dart';

class PutAwayRepository {
  Future getRackListPutAway(context) async {
    var json = await network(url: MyApi.getRackListPutAway(), method: "GET", context: context);
    return json;
  }

  Future getRackListByScanPutAway(rack_code, context) async {
    var json = await network(url: MyApi.getRackListByScanPutAway(rack_code), method: "GET", context: context);
    return json;
  }

  Future getDataQRRackPutAway(rack_number, qr_code, context) async {
    var json = await network(url: MyApi.getDataQRRackPutAway(rack_number, qr_code), method: "GET", context: context);
    return json;
  }

  Future insertPutAway(body, context) async {
    var json = await network(url: MyApi.insertPutAway(), method: "POST", context: context, body: body);
    return json;
  }
}
