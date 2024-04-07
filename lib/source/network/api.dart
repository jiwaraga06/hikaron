String baseUrl = "http://131183204125.ip-dynamic.com:8082";

class MyApi {
  static login(username, pass) {
    return '$baseUrl/api/Login?username=$username&pass=$pass';
  }

  static getOpnameList() {
    return '$baseUrl/api/StockOpname/GetOpnameCodeList';
  }

  static getOpnameCode(qr_code) {
    return '$baseUrl/api/StockOpname/GetOpnameCode?code=$qr_code';
  }

  static getBarangCode(opname_oid, qr_code) {
    return '$baseUrl/api/StockOpname/GetDataQR?opname_oid=$opname_oid&qr_code=$qr_code';
  }

  static entryStockOpname() {
    return '$baseUrl/api/StockOpname/EntryStockOpname';
  }

  // DO Realization
  static doCode(do_code) {
    return '$baseUrl/api/DORealization/GetDeliveryOrder?do_code=$do_code';
  }

  static doBarang(do_code, qr_code) {
    return '$baseUrl/api/DORealization/GetItemData?do_code=$do_code&qr_code=$qr_code';
  }

  static entryDoOpname() {
    return '$baseUrl/api/DORealization/InsertData';
  }

  static getDOList() {
    return '$baseUrl/api/DORealization/GetDeliveryOrderList';
  }

  // GOODS RECEIPT
  static getTransferIssueCode(transfer_code) {
    return '$baseUrl/api/GoodsReceipt/GetTransferIssue?transfer_code=$transfer_code';
  }

  static getTransferIssueList() {
    return '$baseUrl/api/GoodsReceipt/GetTransferIssueList';
  }

  static getItemByQrCode(transfer_code, qr_code) {
    return '$baseUrl/api/GoodsReceipt/GetItemByQrCode?transfer_code=$transfer_code&qr_code=$qr_code';
  }

  static getRackList(item_id) {
    return '$baseUrl/api/GoodsReceipt/GetRackList?item_id=$item_id';
  }

  static insertData() {
    return '$baseUrl/api/GoodsReceipt/InsertData';
  }
}
