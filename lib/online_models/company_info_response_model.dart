class CompanyInfoResponseModel {
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
      this.isPriceIncludeTaxes,
      this.taxAmount,
      this.empName,
      this.empPhone,
      this.empEmail,
      this.branchId,
      this.branchName,
      this.compId,
      this.empId});

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
    return data;
  }
}
