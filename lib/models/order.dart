class OrderModel {
  static const String OrderModelName = 'OrderTable';
  static const String columnId = 'Id';
  static const String columnClientID = 'Client_ID';
  static const String columnPayTypeID = 'PayType_ID';
  static const String columnEmpID = 'Emp_ID';
  static const String columnCreateDate = 'CreateDate';
  static const String columnUpdateDate = 'UpdateDate';
  static const String columnIsPayCash = 'IsPayCash';
  static const String columnTotalCost = 'TotalCost';
  static const String columnDiscount = 'Discount';
  static const String columnTaxes = 'Taxes';
  static const String columnCostNet = 'Cost_Net';
  static const String columnDebitPay = 'DebitPay';
  static const String columnPayAmount = 'PayAmount';
  static const String columnQrcode = 'Qrcode';
  static const String columnIsReturn = 'IsReturn';
  static const String columnReturnDesc = 'ReturnDesc';

  String? id;
  int? clientID;
  int? payTypeID;
  int? empID;
  String? createDate;
  String? updateDate;
  bool? isPayCash;
  double? totalCost;
  double? discount;
  double? taxes;
  double? costNet;
  double? debitPay;
  double? payAmount;
  String? qrcode;
  bool? isReturn;
  String? returnDesc;

  OrderModel(
      {this.id,
      this.clientID,
      this.payTypeID,
      this.empID,
      this.createDate,
      this.updateDate,
      this.isPayCash,
      this.totalCost,
      this.discount,
      this.taxes,
      this.costNet,
      this.debitPay,
      this.payAmount,
      this.qrcode,
      this.isReturn,
      this.returnDesc});

  OrderModel.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    clientID = json['Client_ID'];
    payTypeID = json['PayType_ID'];
    empID = json['Emp_ID'];
    createDate = json['CreateDate'];
    updateDate = json['UpdateDate'];
    isPayCash = json['IsPayCash'];
    totalCost = json['TotalCost'];
    discount = json['Discount'];
    taxes = json['Taxes'];
    costNet = json['Cost_Net'];
    debitPay = json['DebitPay'];
    payAmount = json['PayAmount'];
    qrcode = json['Qrcode'];
    isReturn = json['IsReturn'];
    returnDesc = json['ReturnDesc'];
  }

  OrderModel.fromJsonEdit(Map<String, dynamic> json) {
    id = json['Id'];
    clientID = json['Client_ID'];
    payTypeID = json['PayType_ID'];
    empID = json['Emp_ID'];
    createDate = json['CreateDate'];
    updateDate = json['UpdateDate'];
    isPayCash = json['IsPayCash'] == 1 ? true : false;
    totalCost = json['TotalCost'];
    discount = json['Discount'];
    taxes = json['Taxes'];
    costNet = json['Cost_Net'];
    debitPay = json['DebitPay'];
    payAmount = json['PayAmount'];
    qrcode = json['Qrcode'];
    isReturn = json['IsReturn'] == 1 ? true : false;
    returnDesc = json['ReturnDesc'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['Client_ID'] = this.clientID;
    data['PayType_ID'] = this.payTypeID;
    data['Emp_ID'] = this.empID;
    data['CreateDate'] = this.createDate;
    data['UpdateDate'] = this.updateDate;
    data['IsPayCash'] = this.isPayCash;
    data['TotalCost'] = this.totalCost;
    data['Discount'] = this.discount;
    data['Taxes'] = this.taxes;
    data['Cost_Net'] = this.costNet;
    data['DebitPay'] = this.debitPay;
    data['PayAmount'] = this.payAmount;
    data['Qrcode'] = this.qrcode;
    data['IsReturn'] = this.isReturn;
    data['ReturnDesc'] = this.returnDesc;
    return data;
  }
}
