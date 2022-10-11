class EmpTypesModel {
  static const String EmpTypesModelName = 'EmpTypesTable';
  static const String columnId = 'Id';
  static const String columnName = 'Name';

  int? id;
  String? name;

  EmpTypesModel({this.id, this.name});

  EmpTypesModel.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    name = json['Name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['Name'] = this.name;
    return data;
  }
}
