class CategoryResponseModel {
  String? id;
  String? name;
  String? description;
  bool? isActive;
  int? companyId;

  CategoryResponseModel(
      {this.id, this.name, this.description, this.isActive, this.companyId});

  CategoryResponseModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    isActive = json['isActive'];
    companyId = json['company_Id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['isActive'] = this.isActive;
    data['company_Id'] = this.companyId;
    return data;
  }
}
