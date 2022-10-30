class ProductResponseModel {
  String? prodId;
  String? name;
  String? qrCode;
  String? description;
  String? productNumber;
  double? priceOne;
  double? priceTwo;
  double? priceThree;
  String? image;
  double? buyingPrice;
  int? stockQuantity;
  double? discount;
  bool? isPertrolGas;
  String? unitID;
  double? unitPackage;
  String? topPackaging;
  int? compID;
  String? catID;
  String? expirationDate;
  String? createDate;
  String? updateDate;
  bool? isActive;
  String? categoryName;
  String? unitName;

  ProductResponseModel(
      {this.prodId,
      this.name,
      this.qrCode,
      this.description,
      this.productNumber,
      this.priceOne,
      this.priceTwo,
      this.priceThree,
      this.image,
      this.buyingPrice,
      this.stockQuantity,
      this.discount,
      this.isPertrolGas,
      this.unitID,
      this.unitPackage,
      this.topPackaging,
      this.compID,
      this.catID,
      this.expirationDate,
      this.createDate,
      this.updateDate,
      this.isActive,
      this.categoryName,
      this.unitName});

  ProductResponseModel.fromJson(Map<String, dynamic> json) {
    prodId = json['prod_Id'];
    name = json['name'];
    qrCode = json['qrCode'];
    description = json['description'];
    productNumber = json['product_Number'];
    priceOne = json['priceOne'];
    priceTwo = json['priceTwo'];
    priceThree = json['priceThree'];
    image = json['image'];
    buyingPrice = json['buyingPrice'];
    stockQuantity = json['stockQuantity'];
    discount = json['discount'];
    isPertrolGas = json['isPertrolGas'];
    unitID = json['unit_ID'];
    unitPackage = json['unit_Package'];
    topPackaging = json['top_Packaging'];
    compID = json['comp_ID'];
    catID = json['cat_ID'];
    expirationDate = json['expiration_Date'];
    createDate = json['createDate'];
    updateDate = json['updateDate'];
    isActive = json['isActive'];
    categoryName = json['categoryName'];
    unitName = json['unitName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['prod_Id'] = this.prodId;
    data['name'] = this.name;
    data['qrCode'] = this.qrCode;
    data['description'] = this.description;
    data['product_Number'] = this.productNumber;
    data['priceOne'] = this.priceOne;
    data['priceTwo'] = this.priceTwo;
    data['priceThree'] = this.priceThree;
    data['image'] = this.image;
    data['buyingPrice'] = this.buyingPrice;
    data['stockQuantity'] = this.stockQuantity;
    data['discount'] = this.discount;
    data['isPertrolGas'] = this.isPertrolGas;
    data['unit_ID'] = this.unitID;
    data['unit_Package'] = this.unitPackage;
    data['top_Packaging'] = this.topPackaging;
    data['comp_ID'] = this.compID;
    data['cat_ID'] = this.catID;
    data['expiration_Date'] = this.expirationDate;
    data['createDate'] = this.createDate;
    data['updateDate'] = this.updateDate;
    data['isActive'] = this.isActive;
    data['categoryName'] = this.categoryName;
    data['unitName'] = this.unitName;
    return data;
  }
}
