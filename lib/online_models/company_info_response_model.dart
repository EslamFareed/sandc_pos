class CompanyInfoResponseModel {
  static const String CompanyModelName = 'CompanyTable';

  String? companyName;
  String? companyDescription;
  String? compPhone;
  String? compAddress;
  String? compLanguage;
  String? compTaxNumber;
  String? logo;
  String? compTaxAmount;
  String? compCurrencyName;
  bool? isTaxes;
  bool? isMustChoosePayCash;
  String? language;
  bool? isPriceIncludeTaxes;
  String? taxAmount;
  String? empName;
  String? empPhone;
  String? empEmail;
  int? branchId;
  String? branchName;
  int? compId;
  String? empId;
  bool? addClient;
  bool? isDemo;

  CompanyInfoResponseModel(
      {this.companyName,
      this.companyDescription,
      this.compPhone,
      this.compAddress,
      this.compLanguage,
      this.compTaxNumber,
      this.logo,
      this.compTaxAmount,
      this.compCurrencyName,
      this.isTaxes,
      this.isMustChoosePayCash,
      this.language,
      this.addClient,
      this.isPriceIncludeTaxes,
      this.taxAmount,
      this.empName,
      this.empPhone,
      this.empEmail,
      this.branchId,
      this.branchName,
      this.compId,
      this.isDemo,
      this.empId});

  static const String columnId = 'comp_Id';
  static const String columnCompanyName = 'companyName';
  static const String columnCompanyDescription = 'companyDescription';
  static const String columnPhone = 'compPhone';
  static const String columnAddress = 'compAddress';
  static const String columnCompLanguage = 'compLanguage';
  static const String columnLanguage = 'language';
  static const String columnCompTaxNumber = 'compTaxNumber';
  static const String columnCompTaxAmount = 'compTaxAmount';
  static const String columnTaxAmount = 'taxAmount';
  static const String columnIsTaxes = 'isTaxes';
  static const String columnAddClient = 'addClient';
  static const String columnIsMustChoosePayCash = 'isMustChoosePayCash';
  static const String columnIsPriceIncludeTaxes = 'isPriceIncludeTaxes';
  static const String columnCurrencyName = 'compCurrency_Name';
  static const String columnLogo = 'logo';
  static const String columnEmpName = 'empName';
  static const String columnEmpPhone = 'empPhone';
  static const String columnEmpEmail = 'empEmail';
  static const String columnBranchId = 'branch_Id';
  static const String columnBranchName = 'branchName';
  static const String columnEmpId = 'emp_id';
  static const String columnIsDemo = 'isDemo';

  CompanyInfoResponseModel.fromJson(Map<String, dynamic> json) {
    companyName = json['companyName'];
    companyDescription = json['companyDescription'];
    compPhone = json['compPhone'];
    compAddress = json['compAddress'];
    compLanguage = json['compLanguage'];
    compTaxNumber = json['compTaxNumber'];
    logo = json['logo'];
    compTaxAmount = json['compTaxAmount'];
    compCurrencyName = json['compCurrency_Name'];
    isTaxes = json['isTaxes'];
    isMustChoosePayCash = json['isMustChoosePayCash'];
    language = json['language'];
    isPriceIncludeTaxes = json['isPriceIncludeTaxes'];
    taxAmount = json['taxAmount'];
    empName = json['empName'];
    empPhone = json['empPhone'];
    empEmail = json['empEmail'];
    branchId = json['branch_Id'];
    branchName = json['branchName'];
    compId = json['comp_Id'];
    empId = json['emp_id'];
    addClient = json['addClient'];
    isDemo = json['isDemo'];
  }

  CompanyInfoResponseModel.fromJsonEdit(Map<String, dynamic> json) {
    companyName = json['companyName'];
    companyDescription = json['companyDescription'];
    compPhone = json['compPhone'];
    compAddress = json['compAddress'];
    compLanguage = json['compLanguage'];
    compTaxNumber = json['compTaxNumber'];
    logo = json['logo'];
    compTaxAmount = json['compTaxAmount'];
    compCurrencyName = json['compCurrency_Name'];
    isTaxes = json['isTaxes'] == 1 ? true : false;
    isMustChoosePayCash = json['isMustChoosePayCash'] == 1 ? true : false;
    language = json['language'];
    isPriceIncludeTaxes = json['isPriceIncludeTaxes'] == 1 ? true : false;
    taxAmount = json['taxAmount'];
    empName = json['empName'];
    empPhone = json['empPhone'];
    empEmail = json['empEmail'];
    branchId = json['branch_Id'];
    branchName = json['branchName'];
    compId = json['comp_Id'];
    empId = json['emp_id'];
    addClient = json['addClient'] == 1 ? true : false;
    isDemo = json['isDemo'] == 1 ? true : false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['companyName'] = this.companyName;
    data['companyDescription'] = this.companyDescription;
    data['compPhone'] = this.compPhone;
    data['compAddress'] = this.compAddress;
    data['compLanguage'] = this.compLanguage;
    data['compTaxNumber'] = this.compTaxNumber;
    data['logo'] = this.logo;
    data['compTaxAmount'] = this.compTaxAmount;
    data['compCurrency_Name'] = this.compCurrencyName;
    data['isTaxes'] = this.isTaxes;
    data['isMustChoosePayCash'] = this.isMustChoosePayCash;
    data['language'] = this.language;
    data['isPriceIncludeTaxes'] = this.isPriceIncludeTaxes;
    data['taxAmount'] = this.taxAmount;
    data['empName'] = this.empName;
    data['empPhone'] = this.empPhone;
    data['empEmail'] = this.empEmail;
    data['branch_Id'] = this.branchId;
    data['branchName'] = this.branchName;
    data['comp_Id'] = this.compId;
    data['emp_id'] = this.empId;
    data['addClient'] = this.addClient;
    data['isDemo'] = this.isDemo;
    return data;
  }
}
