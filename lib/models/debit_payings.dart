class DebitPayingsModel {
  static const String DebitPayingsModelName = 'DebitPayingsTable';
  static const String columnId = 'Id';
  static const String columnOrderID = 'Order_ID';
  static const String columnCreateDate = 'CreateDate';
  static const String columnUpdateDate = 'UpdateDate';
  static const String columnQrcode = 'Qrcode';
  static const String columnPayAmount = 'PayAmount';
  static const String columnDebitAmount = 'DebitAmount';
  static const String columnClientID = 'Client_ID';
  static const String columnEmpID = 'Emp_ID';

  int? id;
  String? orderID;
  String? createDate;
  String? updateDate;
  String? qrcode;
  double? payAmount;
  double? debitAmount;
  int? clientID;
  int? empID;

  DebitPayingsModel(
      {this.id,
      this.orderID,
      this.createDate,
      this.updateDate,
      this.qrcode,
      this.payAmount,
      this.debitAmount,
      this.clientID,
      this.empID});

  DebitPayingsModel.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    orderID = json['Order_ID'];
    createDate = json['CreateDate'];
    updateDate = json['UpdateDate'];
    qrcode = json['Qrcode'];
    payAmount = json['PayAmount'];
    debitAmount = json['DebitAmount'];
    clientID = json['Client_ID'];
    empID = json['Emp_ID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['Order_ID'] = this.orderID;
    data['CreateDate'] = this.createDate;
    data['UpdateDate'] = this.updateDate;
    data['Qrcode'] = this.qrcode;
    data['PayAmount'] = this.payAmount;
    data['DebitAmount'] = this.debitAmount;
    data['Client_ID'] = this.clientID;
    data['Emp_ID'] = this.empID;
    return data;
  }
}
