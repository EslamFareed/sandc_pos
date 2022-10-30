class OrderResponseModel {
  String? id;
  String? clientID;
  int? payTypeID;
  String? empID;
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
  bool? updateDataBase;
  bool? offlineDatabase;
  List<GetInVoiceDetails>? getInVoiceDetails;
  List<GetDebitPayings>? getDebitPayings;

  OrderResponseModel(
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
      this.returnDesc,
      this.updateDataBase,
      this.offlineDatabase,
      this.getInVoiceDetails,
      this.getDebitPayings});

  OrderResponseModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    clientID = json['client_ID'];
    payTypeID = json['payType_ID'];
    empID = json['emp_ID'];
    createDate = json['createDate'];
    updateDate = json['updateDate'];
    isPayCash = json['isPayCash'];
    totalCost = json['totalCost'];
    discount = json['discount'];
    taxes = json['taxes'];
    costNet = json['cost_Net'];
    debitPay = json['debitPay'];
    payAmount = json['payAmount'];
    qrcode = json['qrcode'];
    isReturn = json['isReturn'];
    returnDesc = json['returnDesc'];
    updateDataBase = json['updateDataBase'];
    offlineDatabase = json['offlineDatabase'];
    if (json['getInVoiceDetails'] != null) {
      getInVoiceDetails = <GetInVoiceDetails>[];
      json['getInVoiceDetails'].forEach((v) {
        getInVoiceDetails!.add(new GetInVoiceDetails.fromJson(v));
      });
    }
    if (json['getDebitPayings'] != null) {
      getDebitPayings = <GetDebitPayings>[];
      json['getDebitPayings'].forEach((v) {
        getDebitPayings!.add(new GetDebitPayings.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['client_ID'] = this.clientID;
    data['payType_ID'] = this.payTypeID;
    data['emp_ID'] = this.empID;
    data['createDate'] = this.createDate;
    data['updateDate'] = this.updateDate;
    data['isPayCash'] = this.isPayCash;
    data['totalCost'] = this.totalCost;
    data['discount'] = this.discount;
    data['taxes'] = this.taxes;
    data['cost_Net'] = this.costNet;
    data['debitPay'] = this.debitPay;
    data['payAmount'] = this.payAmount;
    data['qrcode'] = this.qrcode;
    data['isReturn'] = this.isReturn;
    data['returnDesc'] = this.returnDesc;
    data['updateDataBase'] = this.updateDataBase;
    data['offlineDatabase'] = this.offlineDatabase;
    if (this.getInVoiceDetails != null) {
      data['getInVoiceDetails'] =
          this.getInVoiceDetails!.map((v) => v.toJson()).toList();
    }
    if (this.getDebitPayings != null) {
      data['getDebitPayings'] =
          this.getDebitPayings!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class GetInVoiceDetails {
  String? id;
  String? orderID;
  String? prodId;
  int? quantity;
  double? unitPrice;
  double? totalCost;
  bool? isReturn;
  String? reasonForReturn;
  int? quantReturns;
  String? updateDate;
  bool? updateDataBase;
  bool? offlineDatabase;

  GetInVoiceDetails(
      {this.id,
      this.orderID,
      this.prodId,
      this.quantity,
      this.unitPrice,
      this.totalCost,
      this.isReturn,
      this.reasonForReturn,
      this.quantReturns,
      this.updateDate,
      this.updateDataBase,
      this.offlineDatabase});

  GetInVoiceDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderID = json['order_ID'];
    prodId = json['prod_Id'];
    quantity = json['quantity'];
    unitPrice = json['unitPrice'];
    totalCost = json['totalCost'];
    isReturn = json['isReturn'];
    reasonForReturn = json['reasonForReturn'];
    quantReturns = json['quantReturns'];
    updateDate = json['updateDate'];
    updateDataBase = json['updateDataBase'];
    offlineDatabase = json['offlineDatabase'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['order_ID'] = this.orderID;
    data['prod_Id'] = this.prodId;
    data['quantity'] = this.quantity;
    data['unitPrice'] = this.unitPrice;
    data['totalCost'] = this.totalCost;
    data['isReturn'] = this.isReturn;
    data['reasonForReturn'] = this.reasonForReturn;
    data['quantReturns'] = this.quantReturns;
    data['updateDate'] = this.updateDate;
    data['updateDataBase'] = this.updateDataBase;
    data['offlineDatabase'] = this.offlineDatabase;
    return data;
  }
}

class GetDebitPayings {
  String? id;
  String? orderID;
  String? createDate;
  String? updateDate;
  String? qrcode;
  double? payAmount;
  double? debitAmount;
  String? clientID;
  String? empID;
  bool? updateDataBase;
  bool? offlineDatabase;

  GetDebitPayings(
      {this.id,
      this.orderID,
      this.createDate,
      this.updateDate,
      this.qrcode,
      this.payAmount,
      this.debitAmount,
      this.clientID,
      this.empID,
      this.updateDataBase,
      this.offlineDatabase});

  GetDebitPayings.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderID = json['order_ID'];
    createDate = json['createDate'];
    updateDate = json['updateDate'];
    qrcode = json['qrcode'];
    payAmount = json['payAmount'];
    debitAmount = json['debitAmount'];
    clientID = json['client_ID'];
    empID = json['emp_ID'];
    updateDataBase = json['updateDataBase'];
    offlineDatabase = json['offlineDatabase'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['order_ID'] = this.orderID;
    data['createDate'] = this.createDate;
    data['updateDate'] = this.updateDate;
    data['qrcode'] = this.qrcode;
    data['payAmount'] = this.payAmount;
    data['debitAmount'] = this.debitAmount;
    data['client_ID'] = this.clientID;
    data['emp_ID'] = this.empID;
    data['updateDataBase'] = this.updateDataBase;
    data['offlineDatabase'] = this.offlineDatabase;
    return data;
  }
}
