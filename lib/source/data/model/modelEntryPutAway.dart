class ModelEntryPutAway {
  final String? barcode;
  final num? pt_id;
  final num? qty;
  final num? from_rack_id;
  final num? to_rack_id;

  ModelEntryPutAway({this.barcode, this.pt_id, this.qty, this.from_rack_id, this.to_rack_id});

  Map<String, dynamic> toJson() => {
        "barcode": barcode,
        "pt_id": pt_id,
        "qty": qty,
        "from_rack_id": from_rack_id,
        "to_rack_id": to_rack_id,
      };
  @override
  String toString() =>
      "{barcode: $barcode, pt_id: $pt_id, qty: $qty, from_rack_id: $from_rack_id, to_rack_id: $to_rack_id}";
}
