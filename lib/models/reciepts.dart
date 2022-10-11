class ReceiptsModel {
  static const String ReceiptsModelName = 'ReceiptsTable';
  static const String columnId = 'Id';
  static const String columnName = 'ProductName';
  static const String columnBillId = 'Bill_Id';
  static const String columnQuantity = 'Quantity';
  static const String columnUnitPrice = 'UnitPrice';
  static const String columnAmount = 'Amount';

  String? id;
  String? productName;
  String? billId;
  int? quantity;
  double? unitPrice;
  double? amount;

  ReceiptsModel(
      {this.id,
      this.productName,
      this.billId,
      this.quantity,
      this.unitPrice,
      this.amount});

  ReceiptsModel.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    productName = json['ProductName'];
    billId = json['Bill_Id'];
    quantity = json['Quantity'];
    unitPrice = json['UnitPrice'];
    amount = json['Amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['ProductName'] = this.productName;
    data['Bill_Id'] = this.billId;
    data['Quantity'] = this.quantity;
    data['UnitPrice'] = this.unitPrice;
    data['Amount'] = this.amount;
    return data;
  }
}
