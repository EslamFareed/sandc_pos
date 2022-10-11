class ClientModel {
  static const String ClientModelName = 'ClientTable';
  static const String columnId = 'Id';
  static const String columnName = 'Name';
  static const String columnPhone = 'Phone';
  static const String columnLoacation = 'Loacation';
  static const String columnAddress = 'Address';
  static const String columnComment = 'Comment';
  static const String columnTaxNumber = 'TaxNumber';
  static const String columnAmmountTobePaid = 'AmmountTobePaid';
  static const String columnMaxDebitLimit = 'MaxDebitLimit';
  static const String columnMaxLimtDebitRecietCount = 'MaxLimtDebitRecietCount';
  static const String columnCompanyId = 'Company_Id';
  static const String columnEmpID = 'Emp_ID';
  static const String columnCreateDate = 'CreateDate';
  static const String columnUpdateDate = 'UpdateDate';
  static const String columnIsActive = 'IsActive';

  String? id;
  String? name;
  String? phone;
  String? loacation;
  String? address;
  String? comment;
  String? taxNumber;
  double? ammountTobePaid;
  double? maxDebitLimit;
  double? maxLimtDebitRecietCount;
  int? companyId;
  int? empID;
  String? createDate;
  String? updateDate;
  bool? isActive;

  ClientModel(
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
      this.createDate,
      this.updateDate,
      this.isActive});

  ClientModel.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    name = json['Name'];
    phone = json['Phone'];
    loacation = json['Loacation'];
    address = json['Address'];
    comment = json['Comment'];
    taxNumber = json['TaxNumber'];
    ammountTobePaid = json['AmmountTobePaid'];
    maxDebitLimit = json['MaxDebitLimit'];
    maxLimtDebitRecietCount = json['MaxLimtDebitRecietCount'];
    companyId = json['Company_Id'];
    empID = json['Emp_ID'];
    createDate = json['CreateDate'];
    updateDate = json['UpdateDate'];
    isActive = json['IsActive'];
  }

  ClientModel.fromJsonEdit(Map<String, dynamic> json) {
    id = json['Id'];
    name = json['Name'];
    phone = json['Phone'];
    loacation = json['Loacation'];
    address = json['Address'];
    comment = json['Comment'];
    taxNumber = json['TaxNumber'];
    ammountTobePaid = json['AmmountTobePaid'];
    maxDebitLimit = json['MaxDebitLimit'];
    maxLimtDebitRecietCount = json['MaxLimtDebitRecietCount'];
    companyId = json['Company_Id'];
    empID = json['Emp_ID'];
    createDate = json['CreateDate'];
    updateDate = json['UpdateDate'];
    isActive = json['IsActive'] == 1 ? true : false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['Name'] = this.name;
    data['Phone'] = this.phone;
    data['Loacation'] = this.loacation;
    data['Address'] = this.address;
    data['Comment'] = this.comment;
    data['TaxNumber'] = this.taxNumber;
    data['AmmountTobePaid'] = this.ammountTobePaid;
    data['MaxDebitLimit'] = this.maxDebitLimit;
    data['MaxLimtDebitRecietCount'] = this.maxLimtDebitRecietCount;
    data['Company_Id'] = this.companyId;
    data['Emp_ID'] = this.empID;
    data['CreateDate'] = this.createDate;
    data['UpdateDate'] = this.updateDate;
    data['IsActive'] = this.isActive;
    return data;
  }
}
