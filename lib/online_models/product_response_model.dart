class ProductResponseModel {
  static const String ProductModelName = 'ProductTable';

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

  static const String columnId = 'prod_Id';
  static const String columnName = 'name';
  static const String columnQrCode = 'qrCode';
  static const String columnDescription = 'description';
  static const String columnProductNumber = 'product_Number';
  static const String columnPriceOne = 'priceOne';
  static const String columnPriceTwo = 'priceTwo';
  static const String columnPriceThree = 'priceThree';
  static const String columnImage = 'image';
  static const String columnBuyingPrice = 'buyingPrice';
  static const String columnStockQuantity = 'stockQuantity';
  static const String columnDiscount = 'discount';
  static const String columnIsPetrolGas = 'isPertrolGas';
  static const String columnUnitID = 'unit_ID';
  static const String columnUnitPackage = 'unit_Package';
  static const String columnTopPackaging = 'top_Packaging';
  static const String columnCompID = 'comp_ID';
  static const String columnCatID = 'cat_ID';
  static const String columnExpirationDate = 'expiration_Date';
  static const String columnCreateDate = 'createDate';
  static const String columnUpdateDate = 'updateDate';
  static const String columnIsActive = 'isActive';
  static const String columnCategoryName = 'categoryName';
  static const String columnUnitName = 'unitName';

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

  ProductResponseModel.fromJsonEdit(Map<String, dynamic> json) {
    prodId = json['prod_Id'];
    name = json['name'];
    qrCode = json['qrCode'];
    description = json['description'];
    productNumber = json['product_Number'];
    priceOne = json['priceOne'] ?? 0;
    priceTwo = json['priceTwo'] ?? 0;
    priceThree = json['priceThree'] ?? 0;
    image = json['image'];
    buyingPrice = json['buyingPrice'] ?? 0;
    stockQuantity = json['stockQuantity'] ?? 0;
    discount = json['discount'] ?? 0;
    isPertrolGas = json['isPertrolGas'] == 1 ? true : false;
    unitID = json['unit_ID'];
    unitPackage =
        json['unit_Package'].toString().isNotEmpty ? json['unit_Package'] : 0;
    topPackaging = json['top_Packaging'];
    compID = json['comp_ID'] ?? 0;
    catID = json['cat_ID'];
    expirationDate = json['expiration_Date'];
    createDate = json['createDate'];
    updateDate = json['updateDate'];
    isActive = json['isActive'] == 1 ? true : false;
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
