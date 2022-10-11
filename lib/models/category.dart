class CategoryModel {
  static const String CategoryModelName = 'CategoryTable';
  static const String columnId = 'Id';
  static const String columnName = 'Name';
  static const String columnDescription = 'Description';
  static const String columnIsActive = 'IsActive';
  static const String columnCompanyId = 'Company_Id';

  int? id;
  String? name;
  String? description;
  bool? isActive;
  int? companyId;

  CategoryModel(
      {this.id, this.name, this.description, this.isActive, this.companyId});

  CategoryModel.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    name = json['Name'];
    description = json['Description'];
    isActive = json['IsActive'];
    companyId = json['Company_Id'];
  }

  CategoryModel.fromJsonEdit(Map<String, dynamic> json) {
    id = json['Id'];
    name = json['Name'];
    description = json['Description'];
    isActive = json['IsActive'] == 1 ? true : false;
    companyId = json['Company_Id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['Name'] = this.name;
    data['Description'] = this.description;
    data['IsActive'] = this.isActive;
    data['Company_Id'] = this.companyId;
    return data;
  }
}
