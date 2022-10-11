class UnitModel {
  static const String UnitModelName = 'UnitTable';
  static const String columnId = 'Id';
  static const String columnName = 'NameUnit';
  static const String columnCompanyId = 'Company_Id';
  static const String columnIsActive = 'IsActive';

  int? id;
  String? nameUnit;
  bool? isActive;
  int? companyId;

  UnitModel({this.id, this.nameUnit, this.isActive, this.companyId});

  UnitModel.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    nameUnit = json['NameUnit'];
    isActive = json['IsActive'];
    companyId = json['Company_Id'];
  }

  UnitModel.fromJsonEdit(Map<String, dynamic> json) {
    id = json['Id'];
    nameUnit = json['NameUnit'];
    isActive = json['IsActive'] == 1 ? true : false;
    companyId = json['Company_Id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['NameUnit'] = this.nameUnit;
    data['IsActive'] = this.isActive;
    data['Company_Id'] = this.companyId;
    return data;
  }
}
