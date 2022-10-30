class PayTypeResponseModel {
  static const String PayTypeModelName = 'PayTypeTable';
  static const String columnId = 'id';
  static const String columnName = 'name';

  int? id;
  String? name;

  PayTypeResponseModel({this.id, this.name});

  PayTypeResponseModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}
