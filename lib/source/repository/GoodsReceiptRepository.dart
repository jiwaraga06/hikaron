import 'package:hikaron/source/network/api.dart';
import 'package:hikaron/source/network/network.dart';

class GoodsReceiptRepository {
  Future getTransferIssueCode(transfer_code, context) async {
    var json = await network(url: MyApi.getTransferIssueCode(transfer_code), method: "GET", context: context);
    return json;
  }

  Future getTransferIssueList(context) async {
    var json = await network(url: MyApi.getTransferIssueList(), method: "GET", context: context);
    return json;
  }

  Future getItemByQrCode(transfer_code, qr_code, context) async {
    var json = await network(url: MyApi.getItemByQrCode(transfer_code, qr_code), method: "GET", context: context);
    return json;
  }

  Future getRackList(item_id, context) async {
    var json = await network(url: MyApi.getRackList(item_id), method: "GET", context: context);
    return json;
  }

  Future insertData(body, context) async {
    var json = await network(url: MyApi.insertData(), method: "POST", body: body, context: context);
    return json;
  }
}
