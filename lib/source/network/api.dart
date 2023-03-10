String baseUrl = "http://203.210.84.8:8082";

class MyApi {
  static login(username, pass) {
    return '$baseUrl/api/Login?username=$username&pass=$pass';
  }

  static getOpnameCode(qr_code) {
    return '$baseUrl/api/StockOpname/GetOpnameCode?code=$qr_code';
  }

  static getBarangCode(opname_oid, qr_code) {
    return '$baseUrl/api/StockOpname/GetDataQR?opname_oid=$opname_oid&qr_code=$qr_code';
  }
  static entryStockOpname(){
    return '$baseUrl/api/StockOpname/EntryStockOpname';
  }
}
