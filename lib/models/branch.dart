class BranchModel {
  static const String BranchModelName = 'BranchTable';
  static const String columnId = 'Id';
  static const String columnName = 'Name';
  static const String columnPhone = 'phone';
  static const String columnAddress = 'Address';
  static const String columnEmail = 'Email';
  static const String columnPassword = 'Password';
  static const String columnPasswordSalt = 'PasswordSalt';
  static const String columnCompID = 'Comp_ID';
  static const String columnIsComfirmed = 'IsComfirmed';
  int? id;
  String? name;
  String? phone;
  String? address;
  String? email;
  String? password;
  String? passwordSalt;
  int? compID;
  bool? isComfirmed;

  BranchModel(
      {this.id,
      this.name,
      this.phone,
      this.address,
      this.email,
      this.password,
      this.passwordSalt,
      this.compID,
      this.isComfirmed});

  BranchModel.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    name = json['Name'];
    phone = json['phone'];
    address = json['Address'];
    email = json['Email'];
    password = json['Password'];
    passwordSalt = json['PasswordSalt'];
    compID = json['Comp_ID'];
    isComfirmed = json['IsComfirmed'];
  }

  BranchModel.fromJsonEdit(Map<String, dynamic> json) {
    id = json['Id'];
    name = json['Name'];
    phone = json['phone'];
    address = json['Address'];
    email = json['Email'];
    password = json['Password'];
    passwordSalt = json['PasswordSalt'];
    compID = json['Comp_ID'];
    isComfirmed = json['IsComfirmed'] == 1 ? true : false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['Name'] = this.name;
    data['phone'] = this.phone;
    data['Address'] = this.address;
    data['Email'] = this.email;
    data['Password'] = this.password;
    data['PasswordSalt'] = this.passwordSalt;
    data['Comp_ID'] = this.compID;
    data['IsComfirmed'] = this.isComfirmed;
    return data;
  }
}
