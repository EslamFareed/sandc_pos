class EmployeeModel {
  static const String EmployeeModelName = 'EmployeeTable';
  static const String columnId = 'ID';
  static const String columnCompanyId = 'Company_Id';
  static const String columnName = 'Name';
  static const String columnPhone = 'Phone';
  static const String columnEmail = 'Email';
  static const String columnPassword = 'Password';
  static const String columnPasswordSalt = 'PasswordSalt';
  static const String columnCreateDate = 'CreateDate';
  static const String columnUpdateDate = 'UpdateDate';
  static const String columnIsActive = 'IsActive';
  static const String columnBranchId = 'Branch_Id';
  static const String columnEmpTypeID = 'EmpType_ID';

  int? iD;
  int? companyId;
  String? name;
  String? phone;
  String? email;
  String? password;
  String? passwordSalt;
  String? createDate;
  String? updateDate;
  bool? isActive;
  int? branchId;
  int? empTypeID;

  EmployeeModel(
      {this.iD,
      this.companyId,
      this.name,
      this.phone,
      this.email,
      this.password,
      this.passwordSalt,
      this.createDate,
      this.updateDate,
      this.isActive,
      this.branchId,
      this.empTypeID});

  EmployeeModel.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    companyId = json['Company_Id'];
    name = json['Name'];
    phone = json['Phone'];
    email = json['Email'];
    password = json['Password'];
    passwordSalt = json['PasswordSalt'];
    createDate = json['CreateDate'];
    updateDate = json['UpdateDate'];
    isActive = json['IsActive'];
    branchId = json['Branch_Id'];
    empTypeID = json['EmpType_ID'];
  }

  EmployeeModel.fromJsonEdit(Map<String, dynamic> json) {
    iD = json['ID'];
    companyId = json['Company_Id'];
    name = json['Name'];
    phone = json['Phone'];
    email = json['Email'];
    password = json['Password'];
    passwordSalt = json['PasswordSalt'];
    createDate = json['CreateDate'];
    updateDate = json['UpdateDate'];
    isActive = json['IsActive'] == 1 ? true : false;
    branchId = json['Branch_Id'];
    empTypeID = json['EmpType_ID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['Company_Id'] = this.companyId;
    data['Name'] = this.name;
    data['Phone'] = this.phone;
    data['Email'] = this.email;
    data['Password'] = this.password;
    data['PasswordSalt'] = this.passwordSalt;
    data['CreateDate'] = this.createDate;
    data['UpdateDate'] = this.updateDate;
    data['IsActive'] = this.isActive;
    data['Branch_Id'] = this.branchId;
    data['EmpType_ID'] = this.empTypeID;
    return data;
  }
}
