class CurrencyModel {
  static const String CurrencyModelName = 'CurrencyTable';
  static const String columnId = 'Id';
  static const String columnName = 'Name';

  int? id;
  String? name;

  CurrencyModel({this.id, this.name});

  CurrencyModel.fromJson(Map<String, dynamic> json) {
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
