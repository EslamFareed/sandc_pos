class BillModel {
  static const String billModelName = 'BillTable';
  static const String columnId = 'Id';
  static const String columnName = 'Name';
  static const String columnPhone = 'Phone';
  static const String columnAddress = 'Address';
  static const String columnComment = 'Comment';
  static const String columnTotal = 'Total';
  static const String columnEmail = 'Email';
  static const String columnCode = 'Code';
  static const String columnLable = 'Lable';
  static const String columnCompID = 'Comp_ID';
  static const String columnInvoiceDate = 'InvoiceDate';
  static const String columnCreateDate = 'CreateDate';

  String? id;
  String? name;
  String? phone;
  String? address;
  String? comment;
  double? total;
  String? email;
  String? code;
  String? lable;
  int? compID;
  String? createDate;
  String? invoiceDate;

  BillModel(
      {this.id,
      this.name,
      this.phone,
      this.address,
      this.comment,
      this.total,
      this.email,
      this.code,
      this.lable,
      this.compID,
      this.createDate,
      this.invoiceDate});

  BillModel.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    name = json['Name'];
    phone = json['Phone'];
    address = json['Address'];
    comment = json['Comment'];
    total = json['Total'];
    email = json['Email'];
    code = json['Code'];
    lable = json['Lable'];
    compID = json['Comp_ID'];
    createDate = json['CreateDate'];
    invoiceDate = json['InvoiceDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['Name'] = this.name;
    data['Phone'] = this.phone;
    data['Address'] = this.address;
    data['Comment'] = this.comment;
    data['Total'] = this.total;
    data['Email'] = this.email;
    data['Code'] = this.code;
    data['Lable'] = this.lable;
    data['Comp_ID'] = this.compID;
    data['CreateDate'] = this.createDate;
    data['InvoiceDate'] = this.invoiceDate;
    return data;
  }
}
