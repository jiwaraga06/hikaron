class ModelEntryReturnIssue {
  final String? gudangtrandBarcode;
  final String? designName;
  final String? colorCode;
  final String? unitCode;
  final num? gudangtrandPtId;
  final num? gudangtrandWidth;
  final num? gudangtrandLength;

  ModelEntryReturnIssue(
      {this.gudangtrandBarcode, this.designName, this.colorCode, this.unitCode, this.gudangtrandPtId, this.gudangtrandWidth, this.gudangtrandLength});

  Map<String, dynamic> toJson() => {
        "gudangtrand_barcode": gudangtrandBarcode,
        "gudangtrand_pt_id": gudangtrandPtId,
        "gudangtrand_width": gudangtrandWidth,
        "gudangtrand_length": gudangtrandLength,
      };
  @override
  String toString() =>
      "{gudangtrand_barcode: $gudangtrandBarcode, gudangtrand_pt_id: $gudangtrandPtId, gudangtrand_width: $gudangtrandWidth,gudangtrand_length: $gudangtrandLength}";
}
