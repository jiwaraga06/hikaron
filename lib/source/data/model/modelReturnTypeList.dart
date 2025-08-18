import 'dart:convert';

List<ModelReturnTypeList> modelReturnTypeListFromJson(String str) {
  final jsonData = json.decode(str);
  return List<ModelReturnTypeList>.from(jsonData.map((x) => ModelReturnTypeList.fromJson(x)));
}

String modelReturnTypeListToJson(List<ModelReturnTypeList> data) {
  final dyn = List<dynamic>.from(data.map((x) => x.toJson()));
  return json.encode(dyn);
}

class ModelReturnTypeList {
  String? value;
  String? display;

  ModelReturnTypeList({
    this.value,
    this.display,
  });

  factory ModelReturnTypeList.fromJson(Map<String, dynamic> json) => ModelReturnTypeList(
        value: json["value"],
        display: json["display"],
      );

  Map<String, dynamic> toJson() => {
        "value": value,
        "display": display,
      };
}
