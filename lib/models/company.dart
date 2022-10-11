class CompanyModel {
  static const String CompanyModelName = 'CompanyTable';
  static const String columnId = 'Id';
  static const String columnCompanyName = 'CompanyName';
  static const String columnCompanyDescription = 'CompanyDescription';
  static const String columnPhone = 'Phone';
  static const String columnAddress = 'Address';
  static const String columnEmail = 'Email';
  static const String columnPassword = 'Password';
  static const String columnPasswordSalt = 'PasswordSalt';
  static const String columnVerificationToken = 'VerificationToken';
  static const String columnVerifiedAt = 'VerifiedAt';
  static const String columnPasswordResetToken = 'PasswordResetToken';
  static const String columnRestTokenExpires = 'RestTokenExpires';
  static const String columnIsConfirmed = 'IsConfirmed';
  static const String columnIsAdmin = 'IsAdmin';
  static const String columnLanguage = 'Language';
  static const String columnTaxNumber = 'TaxNumber';
  static const String columnTaxAmount = 'taxAmount';
  static const String columnIsTaxes = 'IsTaxes';
  static const String columnIsMustChoosePayCash = 'IsMustChoosePayCash';
  static const String columnCurrencyId = 'Currency_Id';
  static const String columnLogo = 'Logo';
  static const String columnCreateDate = 'CreateDate';

  int? id;
  String? companyName;
  String? companyDescription;
  String? phone;
  String? address;
  String? email;
  String? password;
  String? passwordSalt;
  String? verificationToken;
  String? verifiedAt;
  String? passwordResetToken;
  String? restTokenExpires;
  bool? isConfirmed;
  bool? isAdmin;
  String? language;
  String? taxNumber;
  bool? isTaxes;
  bool? isMustChoosePayCash;
  int? currencyId;
  String? logo;
  String? createDate;
  double? taxAmount;

  CompanyModel(
      {this.id,
      this.companyName,
      this.companyDescription,
      this.phone,
      this.address,
      this.email,
      this.password,
      this.passwordSalt,
      this.verificationToken,
      this.verifiedAt,
      this.passwordResetToken,
      this.restTokenExpires,
      this.isConfirmed,
      this.isAdmin,
      this.language,
      this.taxNumber,
      this.isTaxes,
      this.isMustChoosePayCash,
      this.currencyId,
      this.taxAmount,
      this.logo,
      this.createDate});

  CompanyModel.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    companyName = json['CompanyName'];
    companyDescription = json['CompanyDescription'];
    phone = json['Phone'];
    address = json['Address'];
    email = json['Email'];
    password = json['Password'];
    passwordSalt = json['PasswordSalt'];
    verificationToken = json['VerificationToken'];
    verifiedAt = json['VerifiedAt'];
    passwordResetToken = json['PasswordResetToken'];
    restTokenExpires = json['RestTokenExpires'];
    isConfirmed = json['IsConfirmed'];
    isAdmin = json['IsAdmin'];
    language = json['Language'];
    taxNumber = json['TaxNumber'];
    taxAmount = json['taxAmount'];
    isTaxes = json['IsTaxes'];
    isMustChoosePayCash = json['IsMustChoosePayCash'];
    currencyId = json['Currency_Id'];
    logo = json['Logo'];
    createDate = json['CreateDate'];
  }

  CompanyModel.fromJsonEdit(Map<String, dynamic> json) {
    id = json['Id'];
    companyName = json['CompanyName'];
    companyDescription = json['CompanyDescription'];
    phone = json['Phone'];
    address = json['Address'];
    email = json['Email'];
    password = json['Password'];
    passwordSalt = json['PasswordSalt'];
    verificationToken = json['VerificationToken'];
    verifiedAt = json['VerifiedAt'];
    passwordResetToken = json['PasswordResetToken'];
    restTokenExpires = json['RestTokenExpires'];
    isConfirmed = json['IsConfirmed'] == 1 ? true : false;
    isAdmin = json['IsAdmin'] == 1 ? true : false;
    language = json['Language'];
    taxNumber = json['TaxNumber'];
    taxAmount = json['taxAmount'];
    isTaxes = json['IsTaxes'] == 1 ? true : false;
    isMustChoosePayCash = json['IsMustChoosePayCash'] == 1 ? true : false;
    currencyId = json['Currency_Id'];
    logo = json['Logo'];
    createDate = json['CreateDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['CompanyName'] = this.companyName;
    data['CompanyDescription'] = this.companyDescription;
    data['Phone'] = this.phone;
    data['Address'] = this.address;
    data['Email'] = this.email;
    data['Password'] = this.password;
    data['PasswordSalt'] = this.passwordSalt;
    data['VerificationToken'] = this.verificationToken;
    data['VerifiedAt'] = this.verifiedAt;
    data['PasswordResetToken'] = this.passwordResetToken;
    data['RestTokenExpires'] = this.restTokenExpires;
    data['IsConfirmed'] = this.isConfirmed;
    data['IsAdmin'] = this.isAdmin;
    data['Language'] = this.language;
    data['TaxNumber'] = this.taxNumber;
    data['taxAmount'] = this.taxAmount;
    data['IsTaxes'] = this.isTaxes;
    data['IsMustChoosePayCash'] = this.isMustChoosePayCash;
    data['Currency_Id'] = this.currencyId;
    data['Logo'] = this.logo;
    data['CreateDate'] = this.createDate;
    return data;
  }
}
