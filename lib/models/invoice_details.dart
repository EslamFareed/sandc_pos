class InvoiceDetailsModel {
  static const String InvoiceDetailsModelName = 'InvoiceDetailsTable';
  static const String columnId = 'ID';
  static const String columnOrderID = 'Order_ID';
  static const String columnProdId = 'Prod_Id';
  static const String columnQuanitiy = 'Quanitiy';
  static const String columnUnitPrice = 'UnitPrice';
  static const String columnTotalCost = 'TotalCost';
  static const String columnIsReturn = 'IsReturn';
  static const String columnReasonForReturn = 'ReasonForReturn';
  static const String columnQuantReturns = 'QuantReturns';

  String? iD;
  String? orderID;
  String? prodId;
  int? quanitiy;
  double? unitPrice;
  double? totalCost;
  bool? isReturn;
  String? reasonForReturn;
  int? quantReturns;

  InvoiceDetailsModel(
      {this.iD,
      this.orderID,
      this.prodId,
      this.quanitiy,
      this.unitPrice,
      this.totalCost,
      this.isReturn,
      this.reasonForReturn,
      this.quantReturns});

  InvoiceDetailsModel.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    orderID = json['Order_ID'];
    prodId = json['Prod_Id'];
    quanitiy = json['Quanitiy'];
    unitPrice = json['UnitPrice'];
    totalCost = json['TotalCost'];
    isReturn = json['IsReturn'];
    reasonForReturn = json['ReasonForReturn'];
    quantReturns = json['QuantReturns'];
  }

  InvoiceDetailsModel.fromJsonEdit(Map<String, dynamic> json) {
    iD = json['ID'];
    orderID = json['Order_ID'];
    prodId = json['Prod_Id'];
    quanitiy = json['Quanitiy'];
    unitPrice = json['UnitPrice'];
    totalCost = json['TotalCost'];
    isReturn = json['IsReturn'] == 1 ? true : false;
    reasonForReturn = json['ReasonForReturn'];
    quantReturns = json['QuantReturns'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['Order_ID'] = this.orderID;
    data['Prod_Id'] = this.prodId;
    data['Quanitiy'] = this.quanitiy;
    data['UnitPrice'] = this.unitPrice;
    data['TotalCost'] = this.totalCost;
    data['IsReturn'] = this.isReturn;
    data['ReasonForReturn'] = this.reasonForReturn;
    data['QuantReturns'] = this.quantReturns;
    return data;
  }
}
