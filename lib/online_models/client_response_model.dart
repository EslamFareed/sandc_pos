class ClientResponseModel {
  static const String ClientModelName = 'ClientTable';

  String? id;
  String? name;
  String? phone;
  String? loacation;
  String? address;
  String? comment;
  String? taxNumber;
  double? ammountTobePaid;
  double? maxDebitLimit;
  int? maxLimtDebitRecietCount;
  int? companyId;
  String? empID;
  bool? updateDataBase;
  bool? offlineDatabase;
  String? createDate;
  String? updateDate;
  bool? isActive;

  ClientResponseModel(
      {this.id,
      this.name,
      this.phone,
      this.loacation,
      this.address,
      this.comment,
      this.taxNumber,
      this.ammountTobePaid,
      this.maxDebitLimit,
      this.maxLimtDebitRecietCount,
      this.companyId,
      this.empID,
      this.updateDataBase,
      this.offlineDatabase,
      this.createDate,
      this.updateDate,
      this.isActive});

  static const String columnId = 'id';
  static const String columnName = 'name';
  static const String columnPhone = 'phone';
  static const String columnLoacation = 'loacation';
  static const String columnAddress = 'address';
  static const String columnComment = 'comment';
  static const String columnTaxNumber = 'taxNumber';
  static const String columnAmmountTobePaid = 'ammountTobePaid';
  static const String columnMaxDebitLimit = 'maxDebitLimit';
  static const String columnMaxLimtDebitRecietCount = 'maxLimtDebitRecietCount';
  static const String columnCompanyId = 'company_Id';
  static const String columnEmpID = 'emp_ID';
  static const String columnUpdateDataBase = 'updateDataBase';
  static const String columnOfflineDataBase = 'offlineDatabase';
  static const String columnCreateDate = 'createDate';
  static const String columnUpdateDate = 'updateDate';
  static const String columnIsActive = 'isActive';

  ClientResponseModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    phone = json['phone'];
    loacation = json['loacation'];
    address = json['address'];
    comment = json['comment'];
    taxNumber = json['taxNumber'];
    ammountTobePaid = json['ammountTobePaid'];
    maxDebitLimit = json['maxDebitLimit'];
    maxLimtDebitRecietCount = json['maxLimtDebitRecietCount'];
    companyId = json['company_Id'];
    empID = json['emp_ID'];
    updateDataBase = json['updateDataBase'];
    offlineDatabase = json['offlineDatabase'];
    createDate = json['createDate'];
    updateDate = json['updateDate'];
    isActive = json['isActive'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['loacation'] = this.loacation;
    data['address'] = this.address;
    data['comment'] = this.comment;
    data['taxNumber'] = this.taxNumber;
    data['ammountTobePaid'] = this.ammountTobePaid;
    data['maxDebitLimit'] = this.maxDebitLimit;
    data['maxLimtDebitRecietCount'] = this.maxLimtDebitRecietCount;
    data['company_Id'] = this.companyId;
    data['emp_ID'] = this.empID;
    data['updateDataBase'] = this.updateDataBase;
    data['offlineDatabase'] = this.offlineDatabase;
    data['createDate'] = this.createDate;
    data['updateDate'] = this.updateDate;
    data['isActive'] = this.isActive;
    return data;
  }
}
