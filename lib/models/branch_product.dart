class BranchProductModel {
  static const String BranchProductModelName = 'BranchProductTable';
  static const String columnId = 'Id';
  static const String columnProductId = 'Product_Id';
  static const String columnBranchId = 'Branch_Id';
  static const String columnQuantity = 'Quantity';

  int? id;
  String? productId;
  int? branchId;
  int? quantity;

  BranchProductModel({this.id, this.productId, this.branchId, this.quantity});

  BranchProductModel.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    productId = json['Product_Id'];
    branchId = json['Branch_Id'];
    quantity = json['Quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['Product_Id'] = this.productId;
    data['Branch_Id'] = this.branchId;
    data['Quantity'] = this.quantity;
    return data;
  }
}
