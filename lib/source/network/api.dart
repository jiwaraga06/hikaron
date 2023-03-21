String baseUrl = "http://203.210.84.8:8082";

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
}
