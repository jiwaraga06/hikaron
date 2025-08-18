import 'package:hikaron/source/network/api.dart';
import 'package:hikaron/source/network/network.dart';

class ReturnIssue {
  Future getDataQr(qrcode, context) async {
    var json = await network(url: MyApi.getdataReturnIssueQR(qrcode), method: "GET", context: context);
    return json;
  }

  Future getdataReturnTypeList(context) async {
    var json = await network(url: MyApi.getdataReturnTypeList(), method: "GET", context: context);
    return json;
  }

  Future insert(body, context) async {
    var json = await network(url: MyApi.insertReturnIssue(), method: "POST", context: context, body: body);
    return json;
  }
}
