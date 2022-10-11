class ProductModel {
  static const String ProductModelName = 'ProductTable';
  static const String columnId = 'Prod_Id';
  static const String columnName = 'Name';
  static const String columnQrCode = 'QrCode';
  static const String columnDescription = 'Description';
  static const String columnProductNumber = 'Product_Number';
  static const String columnPriceOne = 'PriceOne';
  static const String columnPriceTwo = 'PriceTwo';
  static const String columnPriceThree = 'PriceThree';
  static const String columnImage = 'Image';
  static const String columnBuyingPrice = 'BuyingPrice';
  static const String columnStockQuantity = 'StockQuantity';
  static const String columnDiscount = 'Discount';
  static const String columnIsPetrolGas = 'IsPetrolGas';
  static const String columnUnitID = 'Unit_ID';
  static const String columnUnitPackage = 'Unit_Package';
  static const String columnCompID = 'Comp_ID';
  static const String columnCatID = 'Cat_ID';
  static const String columnExpirationDate = 'Expiration_Date';
  static const String columnCreateDate = 'CreateDate';
  static const String columnUpdateDate = 'UpdateDate';
  static const String columnIsActive = 'IsActive';

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
  bool? isPetrolGas;
  int? unitID;
  int? unitPackage;
  int? compID;
  int? catID;
  String? expirationDate;
  String? createDate;
  String? updateDate;
  bool? isActive;

  ProductModel(
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
      this.isPetrolGas,
      this.unitID,
      this.unitPackage,
      this.compID,
      this.catID,
      this.expirationDate,
      this.createDate,
      this.updateDate,
      this.isActive});

  ProductModel.fromJson(Map<String, dynamic> json) {
    prodId = json['Prod_Id'];
    name = json['Name'];
    qrCode = json['QrCode'];
    description = json['Description'];
    productNumber = json['Product_Number'];
    priceOne = json['PriceOne'];
    priceTwo = json['PriceTwo'];
    priceThree = json['PriceThree'];
    image = json['Image'];
    buyingPrice = json['BuyingPrice'];
    stockQuantity = json['StockQuantity'];
    discount = json['Discount'];
    isPetrolGas = json['IsPetrolGas'];
    unitID = json['Unit_ID'];
    unitPackage = json['Unit_Package'];
    compID = json['Comp_ID'];
    catID = json['Cat_ID'];
    expirationDate = json['Expiration_Date'];
    createDate = json['CreateDate'];
    updateDate = json['UpdateDate'];
    isActive = json['IsActive'];
  }

  ProductModel.fromJsonEdit(Map<String, dynamic> json) {
    prodId = json['Prod_Id'];
    name = json['Name'];
    qrCode = json['QrCode'];
    description = json['Description'];
    productNumber = json['Product_Number'];
    priceOne = json['PriceOne'];
    priceTwo = json['PriceTwo'];
    priceThree = json['PriceThree'];
    image = json['Image'];
    buyingPrice = json['BuyingPrice'];
    stockQuantity = json['StockQuantity'];
    discount = json['Discount'];
    isPetrolGas = json['IsPetrolGas'] == 1 ? true : false;
    unitID = json['Unit_ID'];
    unitPackage = json['Unit_Package'];
    compID = json['Comp_ID'];
    catID = json['Cat_ID'];
    expirationDate = json['Expiration_Date'];
    createDate = json['CreateDate'];
    updateDate = json['UpdateDate'];
    isActive = json['IsActive'] == 1 ? true : false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Prod_Id'] = this.prodId;
    data['Name'] = this.name;
    data['QrCode'] = this.qrCode;
    data['Description'] = this.description;
    data['Product_Number'] = this.productNumber;
    data['PriceOne'] = this.priceOne;
    data['PriceTwo'] = this.priceTwo;
    data['PriceThree'] = this.priceThree;
    data['Image'] = this.image;
    data['BuyingPrice'] = this.buyingPrice;
    data['StockQuantity'] = this.stockQuantity;
    data['Discount'] = this.discount;
    data['IsPetrolGas'] = this.isPetrolGas;
    data['Unit_ID'] = this.unitID;
    data['Unit_Package'] = this.unitPackage;
    data['Comp_ID'] = this.compID;
    data['Cat_ID'] = this.catID;
    data['Expiration_Date'] = this.expirationDate;
    data['CreateDate'] = this.createDate;
    data['UpdateDate'] = this.updateDate;
    data['IsActive'] = this.isActive;
    return data;
  }
}
