class DebitPayingResponseModel {
  String? id;
  String? orderID;
  String? qrcode;
  double? payAmount;
  double? debitAmount;
  String? clientID;
  String? empID;
  String? empName;
  String? clientName;
  String? compName;
  int? compId;
  bool? updateDataBase;
  bool? offlineDatabase;
  String? createDate;
  String? updateDate;

  DebitPayingResponseModel(
      {this.id,
      this.orderID,
      this.qrcode,
      this.payAmount,
      this.debitAmount,
      this.clientID,
      this.empID,
      this.empName,
      this.clientName,
      this.compName,
      this.compId,
      this.updateDataBase,
      this.offlineDatabase,
      this.createDate,
      this.updateDate});

  DebitPayingResponseModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderID = json['order_ID'];
    qrcode = json['qrcode'];
    payAmount = json['payAmount'];
    debitAmount = json['debitAmount'];
    clientID = json['client_ID'];
    empID = json['emp_ID'];
    empName = json['empName'];
    clientName = json['clientName'];
    compName = json['compName'];
    compId = json['comp_Id'];
    updateDataBase = json['updateDataBase'];
    offlineDatabase = json['offlineDatabase'];
    createDate = json['createDate'];
    updateDate = json['updateDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['order_ID'] = this.orderID;
    data['qrcode'] = this.qrcode;
    data['payAmount'] = this.payAmount;
    data['debitAmount'] = this.debitAmount;
    data['client_ID'] = this.clientID;
    data['emp_ID'] = this.empID;
    data['empName'] = this.empName;
    data['clientName'] = this.clientName;
    data['compName'] = this.compName;
    data['comp_Id'] = this.compId;
    data['updateDataBase'] = this.updateDataBase;
    data['offlineDatabase'] = this.offlineDatabase;
    data['createDate'] = this.createDate;
    data['updateDate'] = this.updateDate;
    return data;
  }
}
