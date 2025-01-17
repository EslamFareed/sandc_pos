class OrderResponseModel {
  static const String OrderModelName = 'OrderTable';

  String? id;
  String? clientID;
  int? payTypeID;
  int? countID;
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
      this.countID,
      this.isReturn,
      this.returnDesc,
      this.updateDataBase,
      this.offlineDatabase,
      this.getInVoiceDetails,
      this.getDebitPayings});

  static const String columnId = 'id';
  static const String columnClientID = 'client_ID';
  static const String columnPayTypeID = 'payType_ID';
  static const String columnEmpID = 'emp_ID';
  static const String columnCountID = 'countID';
  static const String columnCreateDate = 'createDate';
  static const String columnUpdateDate = 'updateDate';
  static const String columnIsPayCash = 'isPayCash';
  static const String columnTotalCost = 'totalCost';
  static const String columnDiscount = 'discount';
  static const String columnTaxes = 'taxes';
  static const String columnCostNet = 'cost_Net';
  static const String columnDebitPay = 'debitPay';
  static const String columnPayAmount = 'payAmount';
  static const String columnQrcode = 'qrcode';
  static const String columnIsReturn = 'isReturn';
  static const String columnReturnDesc = 'returnDesc';
  static const String columnUpdateDataBase = 'updateDataBase';
  static const String columnOfflineDatabase = 'offlineDatabase';

  OrderResponseModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    clientID = json['client_ID'];
    payTypeID = json['payType_ID'];
    empID = json['emp_ID'];
    countID = json['countID'];
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

  OrderResponseModel.fromJsonEdit(Map<String, dynamic> json) {
    id = json['id'];
    clientID = json['client_ID'];
    payTypeID = json['payType_ID'];
    empID = json['emp_ID'];
    countID = json['countID'] == "null" ? 0 : json['countID'];
    createDate = json['createDate'];
    updateDate = json['updateDate'];
    isPayCash = json['isPayCash'] == 1 ? true : false;
    totalCost = json['totalCost'];
    discount = json['discount'];
    taxes = json['taxes'];
    costNet = json['cost_Net'];
    debitPay = json['debitPay'];
    payAmount = json['payAmount'];
    qrcode = json['qrcode'];
    isReturn = json['isReturn'] == 1 ? true : false;
    returnDesc = json['returnDesc'];
    updateDataBase = json['updateDataBase'] == 1 ? true : false;
    offlineDatabase = json['offlineDatabase'] == 1 ? true : false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['client_ID'] = this.clientID;
    data['payType_ID'] = this.payTypeID;
    data['emp_ID'] = this.empID;
    data['countID'] = this.countID;
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

  Map<String, dynamic> toJsonEdit() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['client_ID'] = this.clientID;
    data['payType_ID'] = this.payTypeID;
    data['emp_ID'] = this.empID;
    data['countID'] = this.countID;
    data['createDate'] = this.createDate;
    data['updateDate'] = this.updateDate;
    data['isPayCash'] = this.isPayCash! ? 1 : 0;
    data['totalCost'] = this.totalCost;
    data['discount'] = this.discount;
    data['taxes'] = this.taxes;
    data['cost_Net'] = this.costNet;
    data['debitPay'] = this.debitPay;
    data['payAmount'] = this.payAmount;
    data['qrcode'] = this.qrcode;
    data['isReturn'] = this.isReturn! ? 1 : 0;
    data['returnDesc'] = this.returnDesc;
    data['updateDataBase'] = this.updateDataBase! ? 1 : 0;
    data['offlineDatabase'] = this.offlineDatabase! ? 1 : 0;
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
  static const String InvoiceDetailsModelName = 'InvoiceDetailsTable';

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

  static const String columnId = 'id';
  static const String columnOrderID = 'order_ID';
  static const String columnProdId = 'prod_Id';
  static const String columnQuanitiy = 'quantity';
  static const String columnUnitPrice = 'unitPrice';
  static const String columnTotalCost = 'totalCost';
  static const String columnIsReturn = 'isReturn';
  static const String columnReasonForReturn = 'reasonForReturn';
  static const String columnQuantReturns = 'quantReturns';
  static const String columnUpdateDate = 'updateDate';
  static const String columnUpdateDatabase = 'updateDataBase';
  static const String columnOfflineDatabase = 'offlineDatabase';

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

  GetInVoiceDetails.fromJsonEdit(Map<String, dynamic> json) {
    id = json['id'];
    orderID = json['order_ID'];
    prodId = json['prod_Id'];
    quantity = json['quantity'];
    unitPrice = json['unitPrice'];
    totalCost = json['totalCost'];
    isReturn = json['isReturn'] == 1 ? true : false;
    reasonForReturn = json['reasonForReturn'];
    quantReturns = json['quantReturns'];
    updateDate = json['updateDate'];
    updateDataBase = json['updateDataBase'] == 1 ? true : false;
    offlineDatabase = json['offlineDatabase'] == 1 ? true : false;
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

  Map<String, dynamic> toJsonEdit() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['order_ID'] = this.orderID;
    data['prod_Id'] = this.prodId;
    data['quantity'] = this.quantity;
    data['unitPrice'] = this.unitPrice;
    data['totalCost'] = this.totalCost;
    data['isReturn'] = this.isReturn! ? 1 : 0;
    data['reasonForReturn'] = this.reasonForReturn;
    data['quantReturns'] = this.quantReturns;
    data['updateDate'] = this.updateDate;
    data['updateDataBase'] = this.updateDataBase! ? 1 : 0;
    data['offlineDatabase'] = this.offlineDatabase! ? 1 : 0;
    return data;
  }
}

class GetDebitPayings {
  static const String GetDebitPayingsModelName = 'GetDebitPayingsTable';

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

  static const String columnId = 'id';
  static const String columnOrderID = 'order_ID';
  static const String columnCreateDate = 'createDate';
  static const String columnUpdateDate = 'updateDate';
  static const String columnQrcode = 'qrcode';
  static const String columnPayAmount = 'payAmount';
  static const String columnDebitAmount = 'debitAmount';
  static const String columnClientID = 'client_ID';
  static const String columnEmpID = 'emp_ID';
  static const String columnUpdateDataBase = 'updateDataBase';
  static const String columnOfflineDatabase = 'offlineDatabase';

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

  GetDebitPayings.fromJsonEdit(Map<String, dynamic> json) {
    id = json['id'];
    orderID = json['order_ID'];
    createDate = json['createDate'];
    updateDate = json['updateDate'];
    qrcode = json['qrcode'];
    payAmount = json['payAmount'];
    debitAmount = json['debitAmount'];
    clientID = json['client_ID'];
    empID = json['emp_ID'];
    updateDataBase = json['updateDataBase'] == 1 ? true : false;
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
