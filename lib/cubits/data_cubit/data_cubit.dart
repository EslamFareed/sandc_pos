import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:sandc_pos/online_models/category_response_model.dart';
import 'package:sandc_pos/online_models/company_info_response_model.dart';
import 'package:sandc_pos/online_models/debit_paying_response_model.dart';
import 'package:sandc_pos/online_models/order_response_model.dart';
import 'package:sandc_pos/online_models/pay_type_response_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:uuid/uuid.dart';

import '../../online_models/client_response_model.dart';
import '../../online_models/product_response_model.dart';
part 'data_state.dart';

class DataCubit extends Cubit<DataState> {
  DataCubit() : super(DataInitial());
  static DataCubit get(context) => BlocProvider.of(context);

  static Database? _db;

  Future<Database?> get db async {
    if (_db == null) {
      _db = await initalDb();
      return _db;
    } else {
      return _db;
    }
  }

  initalDb() async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, "sandc.db");
    Database mydb = await openDatabase(path,
        onCreate: _onCreate, version: 1, onUpgrade: _onUpgrade);
    return mydb;
  }

  _onUpgrade(Database db, int oldVersion, int newVersion) {
    print("on upgrade ==============================");
  }

  _onCreate(Database db, int version) async {
    await createClientTable(db);
    await createProductTable(db);
    await createPayTypeTable(db);
    await createCategoryTable(db);
    await createOrderTable(db);
    await createInvoiceDetailsTable(db);
    await createDebitPayingsTable(db);
    await createCompanyTable(db);

    print("on Create ===================");
  }

  readData(String sql) async {
    Database? mydb = await db;
    List<Map> response = await mydb!.rawQuery(sql);
    return response;
  }

  insertData(String sql) async {
    Database? mydb = await db;
    int response = await mydb!.rawInsert(sql);
    return response;
  }

  updateData(String sql) async {
    Database? mydb = await db;
    int response = await mydb!.rawUpdate(sql);
    return response;
  }

  deleteData(String sql) async {
    Database? mydb = await db;
    int response = await mydb!.rawDelete(sql);
    return response;
  }

  //! clients offline
  createClientTable(Database db) async {
    print("createClientTable-----------------------------------------------");
    await db.execute('''
    CREATE TABLE "${ClientResponseModel.ClientModelName}" (
      "${ClientResponseModel.columnId}" TEXT NOT NULL PRIMARY KEY , 
      "${ClientResponseModel.columnName}" TEXT ,
      "${ClientResponseModel.columnPhone}" TEXT ,
      "${ClientResponseModel.columnAddress}" TEXT ,
      "${ClientResponseModel.columnLocation}" TEXT ,
      "${ClientResponseModel.columnComment}" TEXT ,
      "${ClientResponseModel.columnTaxNumber}" TEXT ,
      "${ClientResponseModel.columnCreateDate}" TEXT ,
      "${ClientResponseModel.columnUpdateDate}" TEXT ,
      "${ClientResponseModel.columnAmmountTobePaid}" REAL ,
      "${ClientResponseModel.columnMaxDebitLimit}" REAL ,
      "${ClientResponseModel.columnMaxLimtDebitRecietCount}" INTEGER ,
      "${ClientResponseModel.columnCompanyId}" INTEGER ,
      "${ClientResponseModel.columnEmpID}" TEXT ,
      "${ClientResponseModel.columnIsActive}" INTEGER , 
      "${ClientResponseModel.columnOfflineDataBase}" INTEGER , 
      "${ClientResponseModel.columnUpdateDataBase}" INTEGER
    )
    ''');
  }

  insertClientsByList(List<ClientResponseModel> items) async {
    try {
      for (var element in items) {
        await insertClientTable(element);
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  insertClientTable(ClientResponseModel item) async {
    try {
      await insertData('''
          INSERT INTO 
          '${ClientResponseModel.ClientModelName}'
          ('${ClientResponseModel.columnId}',
          '${ClientResponseModel.columnName}',
          '${ClientResponseModel.columnPhone}',
          '${ClientResponseModel.columnLocation}',
          '${ClientResponseModel.columnComment}',
          '${ClientResponseModel.columnTaxNumber}',
          '${ClientResponseModel.columnCreateDate}',
          '${ClientResponseModel.columnUpdateDate}',          
          '${ClientResponseModel.columnAmmountTobePaid}',          
          '${ClientResponseModel.columnMaxDebitLimit}',          
          '${ClientResponseModel.columnMaxLimtDebitRecietCount}',          
          '${ClientResponseModel.columnEmpID}',          
          '${ClientResponseModel.columnCompanyId}',          
          '${ClientResponseModel.columnIsActive}',
          '${ClientResponseModel.columnUpdateDataBase}',
          '${ClientResponseModel.columnOfflineDataBase}',
          '${ClientResponseModel.columnAddress}')
          VALUES (
            '${item.id}',
          '${item.name}',
          '${item.phone}',
          '${item.loacation}',
          '${item.comment}',
          '${item.taxNumber}',
          '${item.createDate}',
          '${item.updateDate}',
          '${item.ammountTobePaid}',
          '${item.maxDebitLimit}',
          '${item.maxLimtDebitRecietCount}',
          '${item.empID}',
          '${item.companyId}',
          '${item.isActive! ? 1 : 0}',
          '${item.updateDataBase! ? 1 : 0}',
          '${item.offlineDatabase! ? 1 : 0}',
          '${item.address}'
          ) 
          ''');
      print(
          "insert client----------------------------------------------- ${item.toJson()}");
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  insertClientInSaleScreen(ClientResponseModel item) async {
    try {
      await insertData('''
          INSERT INTO 
          '${ClientResponseModel.ClientModelName}'
          ('${ClientResponseModel.columnId}',
          '${ClientResponseModel.columnName}',
          '${ClientResponseModel.columnPhone}',
          '${ClientResponseModel.columnLocation}',
          '${ClientResponseModel.columnComment}',
          '${ClientResponseModel.columnTaxNumber}',
          '${ClientResponseModel.columnCreateDate}',
          '${ClientResponseModel.columnUpdateDate}',          
          '${ClientResponseModel.columnAmmountTobePaid}',          
          '${ClientResponseModel.columnMaxDebitLimit}',          
          '${ClientResponseModel.columnMaxLimtDebitRecietCount}',          
          '${ClientResponseModel.columnEmpID}',          
          '${ClientResponseModel.columnCompanyId}',          
          '${ClientResponseModel.columnIsActive}',
          '${ClientResponseModel.columnUpdateDataBase}',
          '${ClientResponseModel.columnOfflineDataBase}',
          '${ClientResponseModel.columnAddress}')
          VALUES (
            '${item.id}',
          '${item.name}',
          '${item.phone}',
          '${item.loacation}',
          '${item.comment}',
          '${item.taxNumber}',
          '${item.createDate}',
          '${item.updateDate}',
          '${item.ammountTobePaid}',
          '${item.maxDebitLimit}',
          '${item.maxLimtDebitRecietCount}',
          '${item.empID}',
          '${item.companyId}',
          '${item.isActive! ? 1 : 0}',
          '${item.updateDataBase! ? 1 : 0}',
          '${item.offlineDatabase! ? 1 : 0}',
          '${item.address}'
          ) 
          ''');
      print(
          "insert client in sale screen----------------------------------------------- ${item.toJson()}");

      emit(InsertClientInSaleScreenState());
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  List<ClientResponseModel> clientModels = [];
  getAllClientTable() async {
    try {
      clientModels = [];
      List<Map<String, dynamic>> data = await readData(
          "SELECT * FROM '${ClientResponseModel.ClientModelName}' ");

      for (var element in data) {
        clientModels.add(ClientResponseModel.fromJsonEdit(element));
      }
      if (kDebugMode) {
        print("clients offline : ${clientModels.length}");
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  deleteAllClients() async {
    try {
      Database? mydb = await db;

      for (var element in clientModels) {
        mydb!.delete(ClientResponseModel.ClientModelName,
            where: '${ClientResponseModel.columnId} = ?',
            whereArgs: [element.id]);
      }
      print(
          "delete all clients-----------------------------------------------");
    } catch (e) {
      print(e);
    }
  }

  updateClientModel(ClientResponseModel item) async {
    try {
      Database? mydb = await db;

      return await mydb!
          .update(ClientResponseModel.ClientModelName, item.toJson(),
              where: '${ClientResponseModel.columnId} = ?',
              whereArgs: [item.id])
          .then((value) => print(
              "updateClientModel-----------------------------------------------"))
          .catchError((onError) {
            print(onError);
          });
    } catch (e) {
      print(e);
    }
  }

  //////////////////////////////////////////////////////////////////
  //! Products Offline
  createProductTable(Database db) async {
    print("createProductTable-----------------------------------------------");

    await db.execute('''
    CREATE TABLE "${ProductResponseModel.ProductModelName}" (
      "${ProductResponseModel.columnId}" TEXT NOT NULL PRIMARY KEY , 
      "${ProductResponseModel.columnName}" TEXT ,
      "${ProductResponseModel.columnBuyingPrice}" REAL ,
      "${ProductResponseModel.columnUnitPackage}" REAL ,
      "${ProductResponseModel.columnUnitID}" TEXT ,
      "${ProductResponseModel.columnStockQuantity}" INTEGER ,
      "${ProductResponseModel.columnQrCode}" TEXT ,
      "${ProductResponseModel.columnCreateDate}" TEXT ,
      "${ProductResponseModel.columnUpdateDate}" TEXT ,
      "${ProductResponseModel.columnImage}" TEXT ,
      "${ProductResponseModel.columnDiscount}" REAL ,
      "${ProductResponseModel.columnExpirationDate}" TEXT ,
      "${ProductResponseModel.columnProductNumber}" TEXT ,
      "${ProductResponseModel.columnTopPackaging}" TEXT ,
      "${ProductResponseModel.columnCatID}" TEXT ,
      "${ProductResponseModel.columnCompID}" INTEGER ,
      "${ProductResponseModel.columnIsPetrolGas}" INTEGER ,
      "${ProductResponseModel.columnPriceOne}" REAL ,
      "${ProductResponseModel.columnPriceThree}" REAL ,
      "${ProductResponseModel.columnPriceTwo}" REAL ,
      "${ProductResponseModel.columnDescription}" TEXT ,
      "${ProductResponseModel.columnUnitName}" TEXT ,
      "${ProductResponseModel.columnCategoryName}" TEXT ,
      "${ProductResponseModel.columnIsActive}" INTEGER
    )
    ''');
  }

  insertProductsByList(List<ProductResponseModel> items) async {
    try {
      for (var element in items) {
        await insertProductTable(element);
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  insertProductTable(ProductResponseModel item) async {
    try {
      await insertData('''
          INSERT INTO
          '${ProductResponseModel.ProductModelName}'
          ('${ProductResponseModel.columnId}',
          '${ProductResponseModel.columnName}',
          '${ProductResponseModel.columnBuyingPrice}',
          '${ProductResponseModel.columnUnitPackage}',
          '${ProductResponseModel.columnUnitID}',
          '${ProductResponseModel.columnCreateDate}',
          '${ProductResponseModel.columnUpdateDate}',
          '${ProductResponseModel.columnDiscount}',
          '${ProductResponseModel.columnStockQuantity}',
          '${ProductResponseModel.columnQrCode}',
          '${ProductResponseModel.columnImage}',
          '${ProductResponseModel.columnExpirationDate}',
          '${ProductResponseModel.columnProductNumber}',
          '${ProductResponseModel.columnCatID}',
          '${ProductResponseModel.columnCompID}',
          '${ProductResponseModel.columnPriceOne}',
          '${ProductResponseModel.columnPriceThree}',
          '${ProductResponseModel.columnPriceTwo}',
          '${ProductResponseModel.columnDescription}',
          '${ProductResponseModel.columnIsActive}',
          '${ProductResponseModel.columnIsPetrolGas}',
          '${ProductResponseModel.columnCategoryName}',
          '${ProductResponseModel.columnUnitName}',
          '${ProductResponseModel.columnTopPackaging}')
          VALUES (
            '${item.prodId}',
          '${item.name}',
          '${item.buyingPrice}',
          '${item.unitPackage ?? 0}',
          '${item.unitID}',
          '${item.createDate}',
          '${item.updateDate}',
          '${item.discount}',
          '${item.stockQuantity}',
          '${item.qrCode}',
          '${item.image}',
          '${item.expirationDate}',
          '${item.productNumber}',
          '${item.catID}',
          '${item.compID}',
          '${item.priceOne}',
          '${item.priceThree}',
          '${item.priceTwo}',
          '${item.description}',
          '${item.isActive! ? 1 : 0}',
          '${item.isPertrolGas! ? 1 : 0}',
          '${item.categoryName!}',
          '${item.unitName!}',
          '${item.topPackaging!}'
          )
          ''');
      print(
          "insert product----------------------------------------------- ${item.toJson()}");
    } catch (e) {
      print(e);
    }
  }

  List<ProductResponseModel> productModels = [];
  getAllProductTable() async {
    try {
      productModels = [];
      List<Map<String, dynamic>> data = await readData(
          "SELECT * FROM '${ProductResponseModel.ProductModelName}' ");

      for (var element in data) {
        productModels.add(ProductResponseModel.fromJsonEdit(element));
      }
      if (kDebugMode) {
        print("productModels offline : ${productModels.length}");
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  deleteAllProducts() async {
    try {
      Database? mydb = await db;

      for (var element in productModels) {
        mydb!.delete(ProductResponseModel.ProductModelName,
            where: '${ProductResponseModel.columnId} = ?',
            whereArgs: [element.prodId]);
      }
      print(
          "delete all products-----------------------------------------------");
    } catch (e) {
      print(e);
    }
  }

  updateListProduct(List<ProductResponseModel> items) async {
    try {
      Database? mydb = await db;

      for (var element in items) {
        await mydb!.update(
            ProductResponseModel.ProductModelName, element.toJsonEdit(),
            where: '${ProductResponseModel.columnId} = ?',
            whereArgs: [element.prodId]);
        print(
            "update product-----------------------------------------------${element.toJson()}");
      }
    } catch (e) {
      print(e);
    }
  }

  //////////////////////////////////////////////////////////////////
  //! Pay Types Offline
  createPayTypeTable(Database db) async {
    await db.execute('''
    CREATE TABLE "${PayTypeResponseModel.PayTypeModelName}" (
      "${PayTypeResponseModel.columnId}" INTEGER NOT NULL PRIMARY KEY ,
      "${PayTypeResponseModel.columnName}" TEXT
    )
    ''');
  }

  insertPayTypesByList(List<PayTypeResponseModel> items) async {
    try {
      for (var element in items) {
        await insertPayTypeTable(element);
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  insertPayTypeTable(PayTypeResponseModel item) async {
    try {
      await insertData(
          "INSERT INTO '${PayTypeResponseModel.PayTypeModelName}' ('${PayTypeResponseModel.columnId}','${PayTypeResponseModel.columnName}') VALUES ('${item.id}','${item.name}') ");
    } catch (e) {
      print(e);
    }
  }

  List<PayTypeResponseModel> payTypeModels = [];
  getAllPayTypeTable() async {
    try {
      payTypeModels = [];
      List<Map<String, dynamic>> data = await readData(
          "SELECT * FROM '${PayTypeResponseModel.PayTypeModelName}' ");

      for (var element in data) {
        payTypeModels.add(PayTypeResponseModel.fromJson(element));
      }
      if (kDebugMode) {
        print("payTypeModels offline : ${payTypeModels.length}");
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  deleteAllPayTypes() async {
    try {
      Database? mydb = await db;

      for (var element in payTypeModels) {
        mydb!.delete(PayTypeResponseModel.PayTypeModelName,
            where: '${PayTypeResponseModel.columnId} = ?',
            whereArgs: [element.id]);
      }
    } catch (e) {
      print(e);
    }
  }

  //////////////////////////////////////////////////////////////////
  //! Categories Offline
  createCategoryTable(Database db) async {
    await db.execute('''
    CREATE TABLE "${CategoryResponseModel.CategoryModelName}" (
      "${CategoryResponseModel.columnId}" TEXT NOT NULL PRIMARY KEY ,
      "${CategoryResponseModel.columnCompanyId}" INTEGER ,
      "${CategoryResponseModel.columnIsActive}" INTEGER ,
      "${CategoryResponseModel.columnName}" TEXT ,
      "${CategoryResponseModel.columnDescription}" TEXT
    )
    ''');
  }

  insertCategoriesByList(List<CategoryResponseModel> items) async {
    try {
      for (var element in items) {
        await insertCategoryTable(element);
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  insertCategoryTable(CategoryResponseModel item) async {
    try {
      await insertData('''
          INSERT INTO
          '${CategoryResponseModel.CategoryModelName}'
          ('${CategoryResponseModel.columnId}',
          '${CategoryResponseModel.columnCompanyId}',
          '${CategoryResponseModel.columnIsActive}',
          '${CategoryResponseModel.columnDescription}',
          '${CategoryResponseModel.columnName}')
          VALUES (
            '${item.id}',
          '${item.companyId}',
          '${item.isActive! ? 1 : 0}',
          '${item.description}',
          '${item.name}'
          )
          ''');
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  List<CategoryResponseModel> categoryModels = [];
  getAllCategoryTable() async {
    try {
      categoryModels = [];
      List<Map<String, dynamic>> data = await readData(
          "SELECT * FROM '${CategoryResponseModel.CategoryModelName}' ");

      for (var element in data) {
        categoryModels.add(CategoryResponseModel.fromJsonEdit(element));
      }
      if (kDebugMode) {
        print("categoryModels offline : ${categoryModels.length}");
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  deleteAllCategories() async {
    try {
      Database? mydb = await db;

      for (var element in categoryModels) {
        mydb!.delete(CategoryResponseModel.CategoryModelName,
            where: '${CategoryResponseModel.columnId} = ?',
            whereArgs: [element.id]);
      }
    } catch (e) {
      print(e);
    }
  }

  //////////////////////////////////////////////////////////////////
  //! Orders Offline
  createOrderTable(Database db) async {
    print("createOrderTable-----------------------------------------------");

    await db.execute('''
    CREATE TABLE "${OrderResponseModel.OrderModelName}" (
      "${OrderResponseModel.columnId}" TEXT NOT NULL PRIMARY KEY ,
      "${OrderResponseModel.columnClientID}" TEXT ,
      "${OrderResponseModel.columnPayTypeID}" INTEGER ,
      "${OrderResponseModel.columnCountID}" INTEGER ,
      "${OrderResponseModel.columnEmpID}" TEXT ,
      "${OrderResponseModel.columnIsPayCash}" INTEGER ,
      "${OrderResponseModel.columnCreateDate}" TEXT ,
      "${OrderResponseModel.columnUpdateDate}" TEXT ,
      "${OrderResponseModel.columnDiscount}" REAL ,
      "${OrderResponseModel.columnTotalCost}" REAL ,
      "${OrderResponseModel.columnTaxes}" REAL ,
      "${OrderResponseModel.columnCostNet}" REAL ,
      "${OrderResponseModel.columnDebitPay}" REAL ,
      "${OrderResponseModel.columnPayAmount}" REAL ,
      "${OrderResponseModel.columnQrcode}" TEXT ,
      "${OrderResponseModel.columnIsReturn}" INTEGER ,
      "${OrderResponseModel.columnUpdateDataBase}" INTEGER ,
      "${OrderResponseModel.columnOfflineDatabase}" INTEGER ,
      "${OrderResponseModel.columnReturnDesc}" TEXT
    )
    ''');
  }

  insertOrdersByList(List<OrderResponseModel> items) async {
    try {
      for (var element in items) {
        await insertOrderTable(element);
        await insertInvoiceDetailsByList(element.getInVoiceDetails!);
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  insertOrderTable(OrderResponseModel item) async {
    try {
      await insertData('''
          INSERT INTO
          '${OrderResponseModel.OrderModelName}'
          ('${OrderResponseModel.columnId}',
          '${OrderResponseModel.columnClientID}',
          '${OrderResponseModel.columnPayTypeID}',
          '${OrderResponseModel.columnCountID}',
          '${OrderResponseModel.columnEmpID}',
          '${OrderResponseModel.columnIsPayCash}',
          '${OrderResponseModel.columnCreateDate}',
          '${OrderResponseModel.columnUpdateDate}',
          '${OrderResponseModel.columnDiscount}',
          '${OrderResponseModel.columnTotalCost}',
          '${OrderResponseModel.columnTaxes}',
          '${OrderResponseModel.columnCostNet}',
          '${OrderResponseModel.columnDebitPay}',
          '${OrderResponseModel.columnPayAmount}',
          '${OrderResponseModel.columnQrcode}',
          '${OrderResponseModel.columnIsReturn}',
          '${OrderResponseModel.columnUpdateDataBase}',
          '${OrderResponseModel.columnOfflineDatabase}',
          '${OrderResponseModel.columnReturnDesc}')
          VALUES (
            '${item.id}',
          '${item.clientID}',
          '${item.payTypeID}',
          '${item.countID}',
          '${item.empID}',
          '${item.isPayCash! ? 1 : 0}',
          '${item.createDate}',
          '${item.updateDate}',
          '${item.discount}',
          '${item.totalCost}',
          '${item.taxes}',
          '${item.costNet}',
          '${item.debitPay}',
          '${item.payAmount}',
          '${item.qrcode}',
          '${item.isReturn! ? 1 : 0}',
          '${item.updateDataBase! ? 1 : 0}',
          '${item.offlineDatabase! ? 1 : 0}',
          '${item.returnDesc}'
          )
          ''');
      print(
          "insert order-----------------------------------------------${item.toJsonEdit()}");
    } catch (e) {
      print(e.toString());
    }
  }

  List<OrderResponseModel> orderModels = [];
  getAllOrderTable() async {
    try {
      orderModels = [];
      List<Map<String, dynamic>> data = await readData(
          "SELECT * FROM '${OrderResponseModel.OrderModelName}' ");

      for (var element in data) {
        orderModels.add(OrderResponseModel.fromJsonEdit(element));
      }
      if (kDebugMode) {
        print("orderModels offline : ${orderModels.length}");
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  deleteAllOrders() async {
    try {
      Database? mydb = await db;

      for (var element in orderModels) {
        mydb!.delete(OrderResponseModel.OrderModelName,
            where: '${OrderResponseModel.columnId} = ?',
            whereArgs: [element.id]);
      }
    } catch (e) {
      print(e);
    }
  }

  updateOrderModel(OrderResponseModel item) async {
    try {
      Database? mydb = await db;

      return await mydb!
          .update(OrderResponseModel.OrderModelName, item.toJson(),
              where: '${OrderResponseModel.columnId} = ?', whereArgs: [item.id])
          .then((value) => print(
              "updateOrderResponseModel----------------------------------------------- ${item.toJson()}"))
          .catchError((onError) {
            print(onError);
          });
    } catch (e) {
      print(e);
    }
  }

  //////////////////////////////////////////////////////////////////
  //! Invoice Details Offline
  createInvoiceDetailsTable(Database db) async {
    await db.execute('''
    CREATE TABLE "${GetInVoiceDetails.InvoiceDetailsModelName}" (
      "${GetInVoiceDetails.columnId}" TEXT NOT NULL PRIMARY KEY ,
      "${GetInVoiceDetails.columnProdId}" TEXT ,
      "${GetInVoiceDetails.columnQuanitiy}" INTEGER ,
      "${GetInVoiceDetails.columnUnitPrice}" REAL ,
      "${GetInVoiceDetails.columnTotalCost}" REAL ,
      "${GetInVoiceDetails.columnIsReturn}" INTEGER ,
      "${GetInVoiceDetails.columnReasonForReturn}" TEXT ,
      "${GetInVoiceDetails.columnUpdateDate}" TEXT ,
      "${GetInVoiceDetails.columnQuantReturns}" INTEGER ,
      "${GetInVoiceDetails.columnUpdateDatabase}" INTEGER ,
      "${GetInVoiceDetails.columnOfflineDatabase}" INTEGER ,
      "${GetInVoiceDetails.columnOrderID}" TEXT
    )
    ''');
  }

  insertInvoiceDetailsByList(List<GetInVoiceDetails> items) async {
    try {
      for (var element in items) {
        await insertInvoiceDetailsTable(element);
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  insertInvoiceDetailsTable(GetInVoiceDetails item) async {
    try {
      await insertData('''
          INSERT INTO
          '${GetInVoiceDetails.InvoiceDetailsModelName}'
          ('${GetInVoiceDetails.columnId}',
          '${GetInVoiceDetails.columnIsReturn}',
          '${GetInVoiceDetails.columnUpdateDatabase}',
          '${GetInVoiceDetails.columnOfflineDatabase}',
          '${GetInVoiceDetails.columnOrderID}',
          '${GetInVoiceDetails.columnProdId}',
          '${GetInVoiceDetails.columnQuanitiy}',
          '${GetInVoiceDetails.columnQuantReturns}',
          '${GetInVoiceDetails.columnReasonForReturn}',
          '${GetInVoiceDetails.columnTotalCost}',
          '${GetInVoiceDetails.columnUpdateDate}',
          '${GetInVoiceDetails.columnUnitPrice}')
          VALUES (
            '${item.id}',
          '${item.isReturn! ? 1 : 0}',
          '${item.updateDataBase! ? 1 : 0}',
          '${item.offlineDatabase! ? 1 : 0}',
          '${item.orderID}',
          '${item.prodId}',
          '${item.quantity}',
          '${item.quantReturns}',
          '${item.reasonForReturn}',
          '${item.totalCost}',
          '${item.updateDate}',
          '${item.unitPrice}'
          )
          ''');

      print(
          "invoice details -------------------------------------------------------------${item.toJson()}");
    } catch (e) {
      print(e);
    }
  }

  List<GetInVoiceDetails> invoiceDetailsModels = [];
  getAllInvoiceDetailsTable() async {
    try {
      invoiceDetailsModels = [];
      List<Map<String, dynamic>> data = await readData(
          "SELECT * FROM '${GetInVoiceDetails.InvoiceDetailsModelName}' ");

      for (var element in data) {
        invoiceDetailsModels.add(GetInVoiceDetails.fromJsonEdit(element));
        // print(element);
      }
      if (kDebugMode) {
        print("invoiceDetailsModels offline : ${invoiceDetailsModels.length}");
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  deleteAllInvoiceDetails() async {
    try {
      Database? mydb = await db;

      for (var element in invoiceDetailsModels) {
        mydb!.delete(GetInVoiceDetails.InvoiceDetailsModelName,
            where: '${GetInVoiceDetails.columnId} = ?',
            whereArgs: [element.id]);
      }
    } catch (e) {
      print(e);
    }
  }

  updateInvoiceDetailsModel(GetInVoiceDetails item) async {
    try {
      Database? mydb = await db;

      return await mydb!
          .update(GetInVoiceDetails.InvoiceDetailsModelName, item.toJsonEdit(),
              where: '${GetInVoiceDetails.columnId} = ?', whereArgs: [item.id])
          .then((value) => print(
              "updateGetInVoiceDetails----------------------------------------------- ${item.toJson()}"))
          .catchError((onError) {
            print(onError);
          });
    } catch (e) {
      print(e);
    }
  }

  //////////////////////////////////////////////////////////////////
  //! Debit Payings Offline
  createDebitPayingsTable(Database db) async {
    await db.execute('''
    CREATE TABLE "${DebitPayingResponseModel.DebitPayingsModelName}" (
      "${DebitPayingResponseModel.columnId}" TEXT NOT NULL PRIMARY KEY ,
      "${DebitPayingResponseModel.columnClientID}" TEXT ,
      "${DebitPayingResponseModel.columnCreateDate}" TEXT ,
      "${DebitPayingResponseModel.columnDebitAmount}" REAL ,
      "${DebitPayingResponseModel.columnEmpID}" TEXT ,
      "${DebitPayingResponseModel.columnEmpName}" TEXT ,
      "${DebitPayingResponseModel.columnClientName}" TEXT ,
      "${DebitPayingResponseModel.columnCompName}" TEXT ,
      "${DebitPayingResponseModel.columnCompId}" INTEGER ,
      "${DebitPayingResponseModel.columnUpdateDataBase}" INTEGER ,
      "${DebitPayingResponseModel.columnOfflineDatabase}" INTEGER ,
      "${DebitPayingResponseModel.columnUpdateDate}" TEXT ,
      "${DebitPayingResponseModel.columnQrcode}" TEXT ,
      "${DebitPayingResponseModel.columnPayAmount}" REAL ,
      "${DebitPayingResponseModel.columnOrderID}" TEXT
    )
    ''');
  }

  insertDebitPayingsByList(List<DebitPayingResponseModel> items) async {
    try {
      for (var element in items) {
        await insertDebitPayingsTable(element);
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  insertDebitPayingsTable(DebitPayingResponseModel item) async {
    try {
      await insertData('''
          INSERT INTO
          '${DebitPayingResponseModel.DebitPayingsModelName}'
          ('${DebitPayingResponseModel.columnId}',
          '${DebitPayingResponseModel.columnClientID}',
          '${DebitPayingResponseModel.columnCompId}',
          '${DebitPayingResponseModel.columnCompName}',
          '${DebitPayingResponseModel.columnClientName}',
          '${DebitPayingResponseModel.columnEmpName}',
          '${DebitPayingResponseModel.columnUpdateDataBase}',
          '${DebitPayingResponseModel.columnOfflineDatabase}',
          '${DebitPayingResponseModel.columnOrderID}',
          '${DebitPayingResponseModel.columnCreateDate}',
          '${DebitPayingResponseModel.columnDebitAmount}',
          '${DebitPayingResponseModel.columnEmpID}',
          '${DebitPayingResponseModel.columnPayAmount}',
          '${DebitPayingResponseModel.columnQrcode}',
          '${DebitPayingResponseModel.columnUpdateDate}')
          VALUES (
            '${item.id}',
          '${item.clientID}',
          '${item.compId}',
          '${item.compName}',
          '${item.clientName}',
          '${item.empName}',
          '${item.updateDataBase! ? 1 : 0}',
          '${item.offlineDatabase! ? 1 : 0}',
          '${item.orderID}',
          '${item.createDate}',
          '${item.debitAmount}',
          '${item.empID}}',
          '${item.payAmount}',
          '${item.qrcode}',
          '${item.updateDate}'
          )
          ''');
    } catch (e) {
      print(e);
    }
  }

  List<DebitPayingResponseModel> debitPayingsModels = [];
  getAllDebitPayingsTable() async {
    try {
      debitPayingsModels = [];
      List<Map<String, dynamic>> data = await readData(
          "SELECT * FROM '${DebitPayingResponseModel.DebitPayingsModelName}' ");

      for (var element in data) {
        debitPayingsModels.add(DebitPayingResponseModel.fromJson(element));
      }
      if (kDebugMode) {
        print("debitPayingsModels offline : ${debitPayingsModels.length}");
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  deleteAllDebitPayings() async {
    try {
      Database? mydb = await db;

      for (var element in debitPayingsModels) {
        mydb!.delete(DebitPayingResponseModel.DebitPayingsModelName,
            where: '${DebitPayingResponseModel.columnId} = ?',
            whereArgs: [element.id]);
      }
    } catch (e) {
      print(e);
    }
  }

  //////////////////////////////////////////////////////////////////
  //! Company Offline
  createCompanyTable(Database db) async {
    await db.execute('''
    CREATE TABLE "${CompanyInfoResponseModel.CompanyModelName}" (
      "${CompanyInfoResponseModel.columnId}" INTEGER NOT NULL PRIMARY KEY ,
      "${CompanyInfoResponseModel.columnIsMustChoosePayCash}" INTEGER ,
      "${CompanyInfoResponseModel.columnIsPriceIncludeTaxes}" INTEGER ,
      "${CompanyInfoResponseModel.columnIsTaxes}" INTEGER ,
      "${CompanyInfoResponseModel.columnAddClient}" INTEGER ,
      "${CompanyInfoResponseModel.columnBranchId}" INTEGER ,
      "${CompanyInfoResponseModel.columnBranchName}" TEXT ,
      "${CompanyInfoResponseModel.columnCompanyName}" TEXT ,
      "${CompanyInfoResponseModel.columnEmpName}" TEXT ,
      "${CompanyInfoResponseModel.columnEmpId}" TEXT ,
      "${CompanyInfoResponseModel.columnEmpPhone}" TEXT ,
      "${CompanyInfoResponseModel.columnEmpEmail}" TEXT ,
      "${CompanyInfoResponseModel.columnCompanyDescription}" TEXT ,
      "${CompanyInfoResponseModel.columnAddress}" TEXT ,
      "${CompanyInfoResponseModel.columnPhone}" TEXT ,
      "${CompanyInfoResponseModel.columnLogo}" TEXT ,
      "${CompanyInfoResponseModel.columnLanguage}" TEXT ,
      "${CompanyInfoResponseModel.columnCompLanguage}" TEXT ,
      "${CompanyInfoResponseModel.columnCompTaxNumber}" TEXT ,
      "${CompanyInfoResponseModel.columnCompTaxAmount}" TEXT ,
      "${CompanyInfoResponseModel.columnCurrencyName}" TEXT ,
      "${CompanyInfoResponseModel.columnTaxAmount}" TEXT ,
      "${CompanyInfoResponseModel.columnIsDemo}" INTEGER
    )
    ''');
  }

  insertCompanyTable(CompanyInfoResponseModel item) async {
    try {
      await insertData('''
          INSERT INTO
          '${CompanyInfoResponseModel.CompanyModelName}'
          ("${CompanyInfoResponseModel.columnId}",
      "${CompanyInfoResponseModel.columnIsMustChoosePayCash}",
      "${CompanyInfoResponseModel.columnIsPriceIncludeTaxes}",
      "${CompanyInfoResponseModel.columnIsTaxes}",
      "${CompanyInfoResponseModel.columnAddClient}",
      "${CompanyInfoResponseModel.columnBranchId}",
      "${CompanyInfoResponseModel.columnBranchName}",
      "${CompanyInfoResponseModel.columnCompanyName}",
      "${CompanyInfoResponseModel.columnEmpName}",
      "${CompanyInfoResponseModel.columnEmpId}",
      "${CompanyInfoResponseModel.columnEmpPhone}",
      "${CompanyInfoResponseModel.columnEmpEmail}",
      "${CompanyInfoResponseModel.columnCompanyDescription}",
      "${CompanyInfoResponseModel.columnAddress}",
      "${CompanyInfoResponseModel.columnPhone}",
      "${CompanyInfoResponseModel.columnLogo}",
      "${CompanyInfoResponseModel.columnLanguage}",
      "${CompanyInfoResponseModel.columnCompLanguage}",
      "${CompanyInfoResponseModel.columnCompTaxNumber}",
      "${CompanyInfoResponseModel.columnCompTaxAmount}",
      "${CompanyInfoResponseModel.columnCurrencyName}",
      "${CompanyInfoResponseModel.columnTaxAmount}",
      "${CompanyInfoResponseModel.columnIsDemo}")
          VALUES (
            '${item.compId}',
          '${item.isMustChoosePayCash! ? 1 : 0}',
          '${item.isPriceIncludeTaxes! ? 1 : 0}',
          '${item.isTaxes! ? 1 : 0}',
          '${item.addClient! ? 1 : 0}',
          '${item.branchId}',
          '${item.branchName}',
          '${item.companyName}',
          '${item.empName}',
          '${item.empId}',
          '${item.empPhone}',
          '${item.empEmail}',
          '${item.companyDescription}',
          '${item.compAddress}',
          '${item.compPhone}',
          '${item.logo}',
          '${item.language}',
          '${item.compLanguage}',
          '${item.compTaxNumber}',
          '${item.compTaxAmount}',
          '${item.compCurrencyName}',
          '${item.taxAmount}',
          '${item.isDemo! ? 1 : 0}'
          )
          ''');
    } catch (e) {
      print(e);
    }
  }

  List<CompanyInfoResponseModel> companyModels = [];
  getAllCompanyTable() async {
    try {
      companyModels = [];
      List<Map<String, dynamic>> data = await readData(
          "SELECT * FROM '${CompanyInfoResponseModel.CompanyModelName}' ");

      for (var element in data) {
        companyModels.add(CompanyInfoResponseModel.fromJsonEdit(element));
      }
      if (kDebugMode) {
        print("companyModels offline : ${companyModels.length}");
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  deleteAllCompanies() async {
    try {
      Database? mydb = await db;

      for (var element in companyModels) {
        mydb!.delete(CompanyInfoResponseModel.CompanyModelName,
            where: '${CompanyInfoResponseModel.columnId} = ?',
            whereArgs: [element.compId]);
      }
    } catch (e) {
      print(e);
    }
  }

  //!---------------------------------------------------------------------

  finishCurrentOrder() async {
    currentOrder!.empID = companyModels[0].empId;
    currentOrder!.isReturn = false;
    currentOrder!.offlineDatabase = false;
    currentOrder!.updateDataBase = false;
    currentOrder!.returnDesc = "no";
    currentOrder!.qrcode = "no";
    currentOrder!.updateDate = "no";
    currentOrder!.createDate = DateTime.now().toString();
    if (!companyModels[0].isMustChoosePayCash! && chosenClient == null) {
      currentOrder!.clientID = null;
    }

    await insertOrderTable(currentOrder!);
    await insertInvoiceDetailsByList(itemsCurrentOrder);
    await updateListProduct(productsCurrentOrder);

    await getAllProductTable();
    await getAllInvoiceDetailsTable();
    await getAllOrderTable();

    // itemsCurrentOrder = [];
    // productsCurrentOrder = [];
    // currentOrder = OrderResponseModel(id: Uuid().v4());
    // total = 0;
    // afterDiscount = 0;
    // afterTaxes = 0;
    // discount = 0;
    print(orderModels.length);

    emit(OrderFinishedState());
  }

  clearCurrentOrder() {
    itemsCurrentOrder = [];
    productsCurrentOrder = [];
    int lastId = 0;
    orderModels.forEach((element) {
      if (element.countID! > lastId) {
        lastId = element.countID!;
      }
    });
    lastId++;
    currentOrder = OrderResponseModel(
        id: "${companyModels[0].branchId}${companyModels[0].empId}$lastId",
        countID: lastId);
    // currentOrder = OrderResponseModel(id: Uuid().v4());
    total = 0;
    afterDiscount = 0;
    afterTaxes = 0;
    discount = 0;
    emit(OrderFinishedState());
  }

  //!---------------------------------------------------------------------

  ClientResponseModel? chosenClient;
  void chooseClient(ClientResponseModel? client) {
    chosenClient = client;
    emit(ChangeClientChosenState());
  }

  String? payingType = "";
  void changePayingType(String? payType) {
    payingType = payType;
    emit(ChangePayTypeState());
  }

  String? isPayingCash = "Cash";
  void changeIsPayingCash(String? isCash) {
    isPayingCash = isCash;
    emit(ChangeIsPayingCashState());
  }

  String? chosenSale = "precentage";
  void chooseSale(String sale) {
    chosenSale = sale;
    emit(ChangeSaleChosenState());

    calcDiscount();
  }

  List<ProductResponseModel> products = [];
  List<ProductResponseModel> productsOfCategories = [];

  void searchProducts(String query, BuildContext context) {
    final productsSearched =
        DataCubit.get(context).productModels.where((element) {
      final productName = element.name!.toLowerCase();
      final input = query.toLowerCase();

      return productName.contains(input);
    });
    products = productsSearched.toList();
    emit(SearchProdcutLoading());
  }

  void searchProductsOfCategories(String query, BuildContext context) {
    final productsSearched =
        DataCubit.get(context).productModels.where((element) {
      final productName = element.categoryName!.toLowerCase();
      final input = query.toLowerCase();

      return productName.contains(input);
    });
    products = productsSearched.toList();
    emit(SearchProdcutLoading());
  }

  OrderResponseModel? currentOrder;
  List<ProductResponseModel> productsCurrentOrder = [];
  List<GetInVoiceDetails> itemsCurrentOrder = [];

  double total = 0;
  double afterDiscount = 0;
  double afterTaxes = 0;
  double discount = 0;

  setDiscount(double dis) {
    discount = dis;
    emit(ChangeSaleAmountState());
  }

  void calcDiscount() {
    afterDiscount = chosenSale == "precentage"
        ? total - (total * (discount * .01))
        : total - discount;
    if (companyModels[0].isTaxes!) {
      afterTaxes = ((afterDiscount *
              (double.parse(companyModels[0].compTaxAmount!) * .01)) +
          afterDiscount);
    }

    emit(ChangeSaleAmountState());
  }

  deleteProdcutFromCart(ProductResponseModel product, BuildContext context) {
    emit(DeleteProductFromHomeLoading());

    productsCurrentOrder.remove(product);

    product.stockQuantity = product.stockQuantity! +
        itemsCurrentOrder
            .where((element) => element.prodId == product.prodId)
            .first
            .quantity!;
    itemsCurrentOrder
        .removeWhere((element) => element.prodId == product.prodId);
    total = 0;
    itemsCurrentOrder.forEach((element) {
      total += element.totalCost!;
    });
    calcDiscount();
    // InvoiceDetailsModel currentItem = DataCubit.get(context).itemsCurrentOrder[
    //     DataCubit.get(context)
    //         .itemsCurrentOrder
    //         .indexWhere((element) => element.prodId == product.prodId)];

    // currentItem.quanitiy = currentItem.quanitiy! - 1;
    // currentItem.totalCost = currentItem.quanitiy! * currentItem.unitPrice!;

    // DataCubit.get(context).itemsCurrentOrder[DataCubit.get(context)
    //         .itemsCurrentOrder
    //         .indexWhere((element) => element.prodId == product.prodId)] =
    //     currentItem;
    emit(DeleteProductFromHomeSuccess());
  }

  mineseQuantityProdcutFromHome(
      ProductResponseModel product, BuildContext context) {
    emit(AddQuantityProdcutLoading());

    GetInVoiceDetails currentItem = itemsCurrentOrder[itemsCurrentOrder
        .indexWhere((element) => element.prodId == product.prodId)];

    currentItem.quantity = currentItem.quantity! - 1;
    currentItem.totalCost = currentItem.quantity! * currentItem.unitPrice!;
    // (currentItem.unitPrice! +
    //     (currentItem.unitPrice! *
    //         (double.parse(companyModels[0].taxAmount!) / 100)));

    itemsCurrentOrder[itemsCurrentOrder.indexWhere(
        (element) => element.prodId == product.prodId)] = currentItem;
    product.stockQuantity = product.stockQuantity! + 1;

    total = 0;
    itemsCurrentOrder.forEach((element) {
      total += element.totalCost!;
    });
    calcDiscount();

    emit(AddQuantityProdcutSuccess());
  }

  addQuantityProdcutFromHome(
      ProductResponseModel product, BuildContext context) {
    emit(AddQuantityProdcutLoading());

    GetInVoiceDetails currentItem = itemsCurrentOrder[itemsCurrentOrder
        .indexWhere((element) => element.prodId == product.prodId)];

    currentItem.quantity = currentItem.quantity! + 1;
    currentItem.totalCost = currentItem.quantity! * currentItem.unitPrice!;
    // (currentItem.unitPrice! +
    //     (currentItem.unitPrice! *
    //         (double.parse(companyModels[0].taxAmount!) / 100)));

    itemsCurrentOrder[itemsCurrentOrder.indexWhere(
        (element) => element.prodId == product.prodId)] = currentItem;
    product.stockQuantity = product.stockQuantity! - 1;

    total = 0;
    itemsCurrentOrder.forEach((element) {
      total += element.totalCost!;
    });
    calcDiscount();

    emit(AddQuantityProdcutSuccess());
  }

  changeProductDesc(
      {required int quantity, required double price, required int index}) {
    changeQuantity(index, quantity);
    changePrice(index, price);
  }

  changeQuantity(int index, int quan) {
    itemsCurrentOrder[index].quantity = quan;
    itemsCurrentOrder[index].totalCost = itemsCurrentOrder[index].quantity! *
        itemsCurrentOrder[index].unitPrice!;

    productModels[productModels.indexWhere(
            (element) => element.prodId == itemsCurrentOrder[index].prodId)]
        .stockQuantity = productModels[productModels.indexWhere(
                (element) => element.prodId == itemsCurrentOrder[index].prodId)]
            .stockQuantity! -
        quan;

    total = 0;
    itemsCurrentOrder.forEach((element) {
      total += element.totalCost!;
    });

    calcDiscount();

    emit(ChangePriceChosen());
  }

  String? chosenPrice = "";
  //! Todo
  changePrice(int index, double price) {
    chosenPrice = price.toString();
    itemsCurrentOrder[index].unitPrice = price;
    itemsCurrentOrder[index].totalCost = itemsCurrentOrder[index].quantity! *
        itemsCurrentOrder[index].unitPrice!;

    // productModels[productModels.indexWhere(
    //         (element) => element.prodId == itemsCurrentOrder[index].prodId)]
    //     .stockQuantity = productModels[productModels.indexWhere(
    //             (element) => element.prodId == itemsCurrentOrder[index].prodId)]
    //         .stockQuantity! -
    //     quan;

    total = 0;
    itemsCurrentOrder.forEach((element) {
      total += element.totalCost!;
    });

    calcDiscount();
    emit(ChangePriceChosen());
  }

  addQuantityProdcut(ProductResponseModel product, BuildContext context) {
    emit(AddQuantityProdcutLoading());
    Get.showSnackbar(const GetSnackBar(
      message: "Product added quantity successfully",
      duration: Duration(milliseconds: 1000),
      animationDuration: Duration(milliseconds: 100),
    ));

    GetInVoiceDetails currentItem = itemsCurrentOrder[itemsCurrentOrder
        .indexWhere((element) => element.prodId == product.prodId)];

    currentItem.quantity = currentItem.quantity! + 1;
    currentItem.totalCost = currentItem.quantity! * currentItem.unitPrice!;
    // (currentItem.unitPrice! +
    //     (currentItem.unitPrice! *
    //         (double.parse(companyModels[0].taxAmount!) / 100)));

    product.stockQuantity = product.stockQuantity! - 1;

    itemsCurrentOrder[itemsCurrentOrder.indexWhere(
        (element) => element.prodId == product.prodId)] = currentItem;

    total = 0;
    itemsCurrentOrder.forEach((element) {
      total += element.totalCost!;
    });
    calcDiscount();

    emit(AddQuantityProdcutSuccess());
  }

  addNewProduct(ProductResponseModel product, BuildContext context) {
    emit(AddNewProductLoading());

    Get.showSnackbar(const GetSnackBar(
      message: "Product added successfully",
      duration: Duration(milliseconds: 500),
      animationDuration: Duration(milliseconds: 100),
    ));

    productsCurrentOrder.add(product);

    itemsCurrentOrder.add(
      GetInVoiceDetails(
          id: Uuid().v4(),
          isReturn: false,
          orderID: currentOrder!.id,
          prodId: product.prodId,
          quantity: 1,
          quantReturns: 0,
          reasonForReturn: "no",
          totalCost: product.priceOne!,
          // (product.priceOne! *
          //     (double.parse(companyModels[0].taxAmount!) / 100)),
          unitPrice: product.priceOne,
          updateDate: "no",
          offlineDatabase: false,
          updateDataBase: false),
    );
    product.stockQuantity = product.stockQuantity! - 1;

    total = 0;
    itemsCurrentOrder.forEach((element) {
      total += element.totalCost!;
    });
    calcDiscount();

    emit(AddNewProductSuccess());
  }
}

// OrderModel? currentOrder;
// List<ProductModel> productsCurrentOrder = [];
// List<InvoiceDetailsModel> itemsCurrentOrder = [];

// deleteProdcutFromCart(ProductModel product, BuildContext context) {
//   emit(DeleteProductFromHomeLoading());

//   productsCurrentOrder.remove(product);
//   itemsCurrentOrder
//       .removeWhere((element) => element.prodId == product.prodId);

//   // InvoiceDetailsModel currentItem = DataCubit.get(context).itemsCurrentOrder[
//   //     DataCubit.get(context)
//   //         .itemsCurrentOrder
//   //         .indexWhere((element) => element.prodId == product.prodId)];

//   // currentItem.quanitiy = currentItem.quanitiy! - 1;
//   // currentItem.totalCost = currentItem.quanitiy! * currentItem.unitPrice!;

//   // DataCubit.get(context).itemsCurrentOrder[DataCubit.get(context)
//   //         .itemsCurrentOrder
//   //         .indexWhere((element) => element.prodId == product.prodId)] =
//   //     currentItem;
//   emit(DeleteProductFromHomeSuccess());
// }

// mineseQuantityProdcutFromHome(ProductModel product, BuildContext context) {
//   emit(AddQuantityProdcutLoading());

//   InvoiceDetailsModel currentItem = itemsCurrentOrder[itemsCurrentOrder
//       .indexWhere((element) => element.prodId == product.prodId)];

//   currentItem.quanitiy = currentItem.quanitiy! - 1;
//   currentItem.totalCost = currentItem.quanitiy! * currentItem.unitPrice!;

//   itemsCurrentOrder[itemsCurrentOrder.indexWhere(
//       (element) => element.prodId == product.prodId)] = currentItem;
//   emit(AddQuantityProdcutSuccess());
// }

// addQuantityProdcutFromHome(ProductModel product, BuildContext context) {
//   emit(AddQuantityProdcutLoading());

//   InvoiceDetailsModel currentItem = itemsCurrentOrder[itemsCurrentOrder
//       .indexWhere((element) => element.prodId == product.prodId)];

//   currentItem.quanitiy = currentItem.quanitiy! + 1;
//   currentItem.totalCost = currentItem.quanitiy! * currentItem.unitPrice!;

//   itemsCurrentOrder[itemsCurrentOrder.indexWhere(
//       (element) => element.prodId == product.prodId)] = currentItem;
//   emit(AddQuantityProdcutSuccess());
// }

// addQuantityProdcut(ProductModel product, BuildContext context) {
//   emit(AddQuantityProdcutLoading());
//   Get.showSnackbar(const GetSnackBar(
//     message: "Product added quantity successfully",
//     duration: Duration(milliseconds: 1000),
//     animationDuration: Duration(milliseconds: 100),
//   ));

//   InvoiceDetailsModel currentItem = itemsCurrentOrder[itemsCurrentOrder
//       .indexWhere((element) => element.prodId == product.prodId)];

//   currentItem.quanitiy = currentItem.quanitiy! + 1;
//   currentItem.totalCost = currentItem.quanitiy! * currentItem.unitPrice!;

//   itemsCurrentOrder[itemsCurrentOrder.indexWhere(
//       (element) => element.prodId == product.prodId)] = currentItem;
//   emit(AddQuantityProdcutSuccess());
// }

// addNewProduct(ProductModel product, BuildContext context) {
//   emit(AddNewProductLoading());

//   Get.showSnackbar(const GetSnackBar(
//     message: "Product added successfully",
//     duration: Duration(milliseconds: 500),
//     animationDuration: Duration(milliseconds: 100),
//   ));

//   productsCurrentOrder.add(product);

//   itemsCurrentOrder.add(
//     InvoiceDetailsModel(
//       iD: Uuid().v1(),
//       isReturn: false,
//       orderID: currentOrder!.id,
//       prodId: product.prodId,
//       quanitiy: 1,
//       quantReturns: 0,
//       reasonForReturn: "",
//       totalCost: product.priceOne,
//       unitPrice: product.priceOne,
//     ),
//   );
//   emit(AddNewProductSuccess());
// }

//------------------------------------------------------------------
//   CompanyModel? companyModel;
//   getCurrentCompany() async {
//     companyModel = await getCompanyModelById(1);
//   }

//   //------------------------------------------------------------------
//   // Todo Currency Table
//   insertCurrencyTable(CurrencyModel item) async {
//     try {
//       await insertData(
//           "INSERT INTO '${CurrencyModel.CurrencyModelName}' ('${CurrencyModel.columnId}','${CurrencyModel.columnName}') VALUES ('${item.id}','${item.name}') ");
//     } catch (e) {
//       print(e);
//     }
//   }

//   List<CurrencyModel> currencyModels = [];
//   getAllCurrencyTable() async {
//     try {
//       currencyModels = [];
//       List<Map<String, dynamic>> data =
//           await readData("SELECT * FROM '${CurrencyModel.CurrencyModelName}' ");

//       for (var element in data) {
//         currencyModels.add(CurrencyModel.fromJson(element));
//       }
//     } catch (e) {
//       print(e);
//     }
//   }

//   getCurrencyModelById(var id) async {
//     try {
//       Database? mydb = await db;

//       List<Map<String, dynamic>> maps =
//           await mydb!.query(CurrencyModel.CurrencyModelName,
//               columns: [
//                 CurrencyModel.columnId,
//                 CurrencyModel.columnName,
//               ],
//               where: '${CurrencyModel.columnId} = ?',
//               whereArgs: [id]);
//       if (maps.isNotEmpty) {
//         return CurrencyModel.fromJson(maps.first);
//       }
//     } catch (e) {
//       print(e);
//     }
//   }

//   deleteCurrencyModel(var id) async {
//     try {
//       Database? mydb = await db;

//       return await mydb!.delete(CurrencyModel.CurrencyModelName,
//           where: '${CurrencyModel.columnId} = ?', whereArgs: [id]);
//     } catch (e) {
//       print(e);
//     }
//     return 0;
//   }

//   deleteAllCurrencyModel() async {
//     try {
//       Database? mydb = await db;

//       for (var element in currencyModels) {
//         mydb!.delete(CurrencyModel.CurrencyModelName,
//             where: '${CurrencyModel.columnId} = ?', whereArgs: [element.id]);
//       }
//     } catch (e) {
//       print(e);
//     }
//   }

//   updateCurrencyModel(CurrencyModel item) async {
//     try {
//       Database? mydb = await db;

//       return await mydb!.update(CurrencyModel.CurrencyModelName, item.toJson(),
//           where: '${CurrencyModel.columnId} = ?', whereArgs: [item.id]);
//     } catch (e) {
//       print(e);
//     }
//   }

//   createCurrencyTable(Database db) async {
//     await db.execute('''
//     CREATE TABLE "${CurrencyModel.CurrencyModelName}" (
//       "${CurrencyModel.columnId}" INTEGER NOT NULL PRIMARY KEY ,
//       "${CurrencyModel.columnName}" TEXT
//     )
//     ''');
//   }

//   //------------------------------------------------------------------
//   // Todo Emp Types Table
//   insertEmpTypesTable(EmpTypesModel item) async {
//     try {
//       await insertData(
//           "INSERT INTO '${EmpTypesModel.EmpTypesModelName}' ('${EmpTypesModel.columnId}','${EmpTypesModel.columnName}') VALUES ('${item.id}','${item.name}') ");
//     } catch (e) {
//       print(e);
//     }
//   }

//   getEmpTypesModelById(var id) async {
//     try {
//       Database? mydb = await db;

//       List<Map<String, dynamic>> maps =
//           await mydb!.query(EmpTypesModel.EmpTypesModelName,
//               columns: [
//                 EmpTypesModel.columnId,
//                 EmpTypesModel.columnName,
//               ],
//               where: '${EmpTypesModel.columnId} = ?',
//               whereArgs: [id]);
//       if (maps.isNotEmpty) {
//         return EmpTypesModel.fromJson(maps.first);
//       }
//     } catch (e) {
//       print(e);
//     }
//   }

//   deleteEmpTypesModel(var id) async {
//     try {
//       Database? mydb = await db;

//       return await mydb!.delete(EmpTypesModel.EmpTypesModelName,
//           where: '${EmpTypesModel.columnId} = ?', whereArgs: [id]);
//     } catch (e) {
//       print(e);
//     }
//   }

  // deleteAllEmpTypesModel() async {
  //   try {
  //     Database? mydb = await db;

  //     for (var element in empTypesModels) {
  //       mydb!.delete(EmpTypesModel.EmpTypesModelName,
  //           where: '${EmpTypesModel.columnId} = ?', whereArgs: [element.id]);
  //     }
  //   } catch (e) {
  //     print(e);
  //   }
  // }

//   updateEmpTypesModel(EmpTypesModel item) async {
//     try {
//       Database? mydb = await db;

//       return await mydb!.update(EmpTypesModel.EmpTypesModelName, item.toJson(),
//           where: '${EmpTypesModel.columnId} = ?', whereArgs: [item.id]);
//     } catch (e) {
//       print(e);
//     }
//   }

//   List<EmpTypesModel> empTypesModels = [];
//   getAllEmpTypesTable() async {
//     try {
//       empTypesModels = [];
//       List<Map<String, dynamic>> data =
//           await readData("SELECT * FROM '${EmpTypesModel.EmpTypesModelName}' ");

//       for (var element in data) {
//         empTypesModels.add(EmpTypesModel.fromJson(element));
//       }
//     } catch (e) {
//       print(e);
//     }
//   }

//   createEmpTypesTable(Database db) async {
//     await db.execute('''
//     CREATE TABLE "${EmpTypesModel.EmpTypesModelName}" (
//       "${EmpTypesModel.columnId}" INTEGER NOT NULL PRIMARY KEY ,
//       "${EmpTypesModel.columnName}" TEXT
//     )
//     ''');
//   }

//   //------------------------------------------------------------------
//   // Todo PayType Table


//   getPayTypeModelById(var id) async {
//     try {
//       Database? mydb = await db;

//       List<Map<String, dynamic>> maps =
//           await mydb!.query(PayTypeModel.PayTypeModelName,
//               columns: [
//                 PayTypeModel.columnId,
//                 PayTypeModel.columnName,
//               ],
//               where: '${PayTypeModel.columnId} = ?',
//               whereArgs: [id]);
//       if (maps.isNotEmpty) {
//         return PayTypeModel.fromJson(maps.first);
//       }
//     } catch (e) {
//       print(e);
//     }
//   }

//   deletePayTypeModel(var id) async {
//     try {
//       Database? mydb = await db;

//       return await mydb!.delete(PayTypeModel.PayTypeModelName,
//           where: '${PayTypeModel.columnId} = ?', whereArgs: [id]);
//     } catch (e) {
//       print(e);
//     }
//   }

//   deleteAllPayTypeModel() async {
//     try {
//       Database? mydb = await db;

//       for (var element in payTypeModels) {
//         mydb!.delete(PayTypeModel.PayTypeModelName,
//             where: '${PayTypeModel.columnId} = ?', whereArgs: [element.id]);
//       }
//     } catch (e) {
//       print(e);
//     }
//   }

//   updatePayTypeModel(PayTypeModel item) async {
//     try {
//       Database? mydb = await db;

//       return await mydb!.update(PayTypeModel.PayTypeModelName, item.toJson(),
//           where: '${PayTypeModel.columnId} = ?', whereArgs: [item.id]);
//     } catch (e) {
//       print(e);
//     }
//   }

  // List<PayTypeModel> payTypeModels = [];
  // getAllPayTypeTable() async {
  //   try {
  //     payTypeModels = [];
  //     List<Map<String, dynamic>> data =
  //         await readData("SELECT * FROM '${PayTypeModel.PayTypeModelName}' ");

  //     for (var element in data) {
  //       payTypeModels.add(PayTypeModel.fromJson(element));
  //     }
  //   } catch (e) {
  //     print(e);
  //   }
  // }

//   //------------------------------------------------------------------
//   // Todo Company Table


//   getCompanyModelById(var id) async {
//     try {
//       Database? mydb = await db;

//       List<Map<String, dynamic>> maps =
//           await mydb!.query(CompanyModel.CompanyModelName,
//               columns: [
//                 CompanyModel.columnId,
//                 CompanyModel.columnAddress,
//                 CompanyModel.columnCompanyDescription,
//                 CompanyModel.columnCompanyName,
//                 CompanyModel.columnCreateDate,
//                 CompanyModel.columnCurrencyId,
//                 CompanyModel.columnEmail,
//                 CompanyModel.columnIsAdmin,
//                 CompanyModel.columnIsConfirmed,
//                 CompanyModel.columnIsMustChoosePayCash,
//                 CompanyModel.columnIsTaxes,
//                 CompanyModel.columnLanguage,
//                 CompanyModel.columnLogo,
//                 CompanyModel.columnPassword,
//                 CompanyModel.columnPasswordResetToken,
//                 CompanyModel.columnPasswordSalt,
//                 CompanyModel.columnPhone,
//                 CompanyModel.columnRestTokenExpires,
//                 CompanyModel.columnTaxAmount,
//                 CompanyModel.columnTaxNumber,
//                 CompanyModel.columnVerificationToken,
//                 CompanyModel.columnVerifiedAt,
//               ],
//               where: '${CompanyModel.columnId} = ?',
//               whereArgs: [id]);
//       if (maps.isNotEmpty) {
//         return CompanyModel.fromJsonEdit(maps.first);
//       }
//     } catch (e) {
//       print(e);
//     }
//   }

//   deleteCompanyModel(var id) async {
//     try {
//       Database? mydb = await db;

//       return await mydb!.delete(CompanyModel.CompanyModelName,
//           where: '${CompanyModel.columnId} = ?', whereArgs: [id]);
//     } catch (e) {
//       print(e);
//     }
//   }

//   deleteAllCompanyModel() async {
//     try {
//       Database? mydb = await db;

//       for (var element in companyModels) {
//         mydb!.delete(CompanyModel.CompanyModelName,
//             where: '${CompanyModel.columnId} = ?', whereArgs: [element.id]);
//       }
//     } catch (e) {
//       print(e);
//     }
//   }

//   updateCompanyModel(CompanyModel item) async {
//     try {
//       Database? mydb = await db;

//       return await mydb!.update(CompanyModel.CompanyModelName, item.toJson(),
//           where: '${CompanyModel.columnId} = ?', whereArgs: [item.id]);
//     } catch (e) {
//       print(e);
//     }
//   }

  // List<CompanyModel> companyModels = [];
  // getAllCompanyTable() async {
  //   try {
  //     companyModels = [];
  //     List<Map<String, dynamic>> data =
  //         await readData("SELECT * FROM '${CompanyModel.CompanyModelName}' ");

  //     for (var element in data) {
  //       companyModels.add(CompanyModel.fromJsonEdit(element));
  //     }
  //   } catch (e) {
  //     print(e);
  //   }
  // }

// //------------------------------------------------------------------
//   // Todo Employee Table
//   createEmployeeTable(Database db) async {
//     await db.execute('''
//     CREATE TABLE "${EmployeeModel.EmployeeModelName}" (
//       "${EmployeeModel.columnId}" INTEGER NOT NULL PRIMARY KEY ,
//       "${EmployeeModel.columnCompanyId}" INTEGER ,
//       "${EmployeeModel.columnIsActive}" INTEGER ,
//       "${EmployeeModel.columnBranchId}" INTEGER ,
//       "${EmployeeModel.columnEmpTypeID}" INTEGER ,
//       "${EmployeeModel.columnName}" TEXT ,
//       "${EmployeeModel.columnPhone}" TEXT ,
//       "${EmployeeModel.columnEmail}" TEXT ,
//       "${EmployeeModel.columnPassword}" TEXT ,
//       "${EmployeeModel.columnPasswordSalt}" TEXT ,
//       "${EmployeeModel.columnCreateDate}" TEXT ,
//       "${EmployeeModel.columnUpdateDate}" TEXT
//     )
//     ''');
//   }

//   insertEmployeeTable(EmployeeModel item) async {
//     try {
//       await insertData('''
//           INSERT INTO
//           '${EmployeeModel.EmployeeModelName}'
//           ('${EmployeeModel.columnId}',
//           '${EmployeeModel.columnBranchId}',
//           '${EmployeeModel.columnCompanyId}',
//           '${EmployeeModel.columnEmpTypeID}',
//           '${EmployeeModel.columnCreateDate}',
//           '${EmployeeModel.columnIsActive}',
//           '${EmployeeModel.columnEmail}',
//           '${EmployeeModel.columnUpdateDate}',
//           '${EmployeeModel.columnName}',
//           '${EmployeeModel.columnPassword}',
//           '${EmployeeModel.columnPasswordSalt}',
//           '${EmployeeModel.columnPhone}')
//           VALUES (
//             '${item.iD}',
//           '${item.branchId}',
//           '${item.companyId}',
//           '${item.empTypeID}',
//           '${item.createDate}',
//           '${item.isActive! ? 1 : 0}}',
//           '${item.email}',
//           '${item.updateDate}',
//           '${item.name}',
//           '${item.password}',
//           '${item.passwordSalt}',
//           '${item.phone}'
//           )
//           ''');
//     } catch (e) {
//       print(e);
//     }
//   }

//   getEmployeeModelById(var id) async {
//     try {
//       Database? mydb = await db;

//       List<Map<String, dynamic>> maps =
//           await mydb!.query(EmployeeModel.EmployeeModelName,
//               columns: [
//                 EmployeeModel.columnId,
//                 EmployeeModel.columnBranchId,
//                 EmployeeModel.columnCompanyId,
//                 EmployeeModel.columnEmpTypeID,
//                 EmployeeModel.columnCreateDate,
//                 EmployeeModel.columnIsActive,
//                 EmployeeModel.columnEmail,
//                 EmployeeModel.columnUpdateDate,
//                 EmployeeModel.columnName,
//                 EmployeeModel.columnPassword,
//                 EmployeeModel.columnPasswordSalt,
//                 EmployeeModel.columnPhone,
//               ],
//               where: '${EmployeeModel.columnId} = ?',
//               whereArgs: [id]);
//       if (maps.isNotEmpty) {
//         return EmployeeModel.fromJsonEdit(maps.first);
//       }
//     } catch (e) {
//       print(e);
//     }
//   }

//   deleteEmployeeModel(var id) async {
//     try {
//       Database? mydb = await db;

//       return await mydb!.delete(EmployeeModel.EmployeeModelName,
//           where: '${EmployeeModel.columnId} = ?', whereArgs: [id]);
//     } catch (e) {
//       print(e);
//     }
//   }

//   deleteAllEmployeeModel() async {
//     try {
//       Database? mydb = await db;

//       for (var element in employeeModels) {
//         mydb!.delete(EmployeeModel.EmployeeModelName,
//             where: '${EmployeeModel.columnId} = ?', whereArgs: [element.iD]);
//       }
//     } catch (e) {
//       print(e);
//     }
//   }

//   updateEmployeeModel(EmployeeModel item) async {
//     try {
//       Database? mydb = await db;

//       return await mydb!.update(EmployeeModel.EmployeeModelName, item.toJson(),
//           where: '${EmployeeModel.columnId} = ?', whereArgs: [item.iD]);
//     } catch (e) {
//       print(e);
//     }
//   }

//   List<EmployeeModel> employeeModels = [];
//   getAllEmployeeTable() async {
//     try {
//       employeeModels = [];
//       List<Map<String, dynamic>> data =
//           await readData("SELECT * FROM '${EmployeeModel.EmployeeModelName}' ");

//       for (var element in data) {
//         employeeModels.add(EmployeeModel.fromJsonEdit(element));
//       }
//     } catch (e) {
//       print(e);
//     }
//   }

//   //------------------------------------------------------------------
//   // Todo InvoiceDetails Table


//   getInvoiceDetailsModelById(var id) async {
//     try {
//       Database? mydb = await db;

//       List<Map<String, dynamic>> maps =
//           await mydb!.query(InvoiceDetailsModel.InvoiceDetailsModelName,
//               columns: [
//                 InvoiceDetailsModel.columnId,
//                 InvoiceDetailsModel.columnIsReturn,
//                 InvoiceDetailsModel.columnOrderID,
//                 InvoiceDetailsModel.columnProdId,
//                 InvoiceDetailsModel.columnQuanitiy,
//                 InvoiceDetailsModel.columnQuantReturns,
//                 InvoiceDetailsModel.columnReasonForReturn,
//                 InvoiceDetailsModel.columnTotalCost,
//                 InvoiceDetailsModel.columnUnitPrice,
//               ],
//               where: '${InvoiceDetailsModel.columnId} = ?',
//               whereArgs: [id]);
//       if (maps.isNotEmpty) {
//         return InvoiceDetailsModel.fromJsonEdit(maps.first);
//       }
//     } catch (e) {
//       print(e);
//     }
//   }

//   deleteInvoiceDetailsModel(var id) async {
//     try {
//       Database? mydb = await db;

//       return await mydb!.delete(InvoiceDetailsModel.InvoiceDetailsModelName,
//           where: '${InvoiceDetailsModel.columnId} = ?', whereArgs: [id]);
//     } catch (e) {
//       print(e);
//     }
//   }

//   deleteAllInvoiceDetailsModel() async {
//     try {
//       Database? mydb = await db;

//       for (var element in invoiceDetailsModels) {
//         mydb!.delete(InvoiceDetailsModel.InvoiceDetailsModelName,
//             where: '${InvoiceDetailsModel.columnId} = ?',
//             whereArgs: [element.iD]);
//       }
//     } catch (e) {
//       print(e);
//     }
//   }

//   updateInvoiceDetailsModel(InvoiceDetailsModel item) async {
//     try {
//       Database? mydb = await db;

//       return await mydb!.update(
//           InvoiceDetailsModel.InvoiceDetailsModelName, item.toJson(),
//           where: '${InvoiceDetailsModel.columnId} = ?', whereArgs: [item.iD]);
//     } catch (e) {
//       print(e);
//     }
//   }

  // List<InvoiceDetailsModel> invoiceDetailsModels = [];
  // getAllInvoiceDetailsTable() async {
  //   try {
  //     invoiceDetailsModels = [];
  //     List<Map<String, dynamic>> data = await readData(
  //         "SELECT * FROM '${InvoiceDetailsModel.InvoiceDetailsModelName}' ");

  //     for (var element in data) {
  //       invoiceDetailsModels.add(InvoiceDetailsModel.fromJsonEdit(element));
  //     }
  //   } catch (e) {
  //     print(e);
  //   }
  // }

//   //------------------------------------------------------------------
//   // Todo DebitPayings Table


//   getDebitPayingsModelById(var id) async {
//     try {
//       Database? mydb = await db;

//       List<Map<String, dynamic>> maps =
//           await mydb!.query(DebitPayingsModel.DebitPayingsModelName,
//               columns: [
//                 DebitPayingsModel.columnId,
//                 DebitPayingsModel.columnClientID,
//                 DebitPayingsModel.columnOrderID,
//                 DebitPayingsModel.columnCreateDate,
//                 DebitPayingsModel.columnDebitAmount,
//                 DebitPayingsModel.columnEmpID,
//                 DebitPayingsModel.columnPayAmount,
//                 DebitPayingsModel.columnQrcode,
//                 DebitPayingsModel.columnUpdateDate,
//               ],
//               where: '${DebitPayingsModel.columnId} = ?',
//               whereArgs: [id]);
//       if (maps.isNotEmpty) {
//         return DebitPayingsModel.fromJson(maps.first);
//       }
//     } catch (e) {
//       print(e);
//     }
//   }

//   deleteDebitPayingsModel(var id) async {
//     try {
//       Database? mydb = await db;

//       return await mydb!.delete(DebitPayingsModel.DebitPayingsModelName,
//           where: '${DebitPayingsModel.columnId} = ?', whereArgs: [id]);
//     } catch (e) {
//       print(e);
//     }
//   }

//   deleteAllDebitPayingsModel() async {
//     try {
//       Database? mydb = await db;

//       for (var element in debitPayingsModels) {
//         mydb!.delete(DebitPayingsModel.DebitPayingsModelName,
//             where: '${DebitPayingsModel.columnId} = ?',
//             whereArgs: [element.id]);
//       }
//     } catch (e) {
//       print(e);
//     }
//   }

//   updateDebitPayingsModel(DebitPayingsModel item) async {
//     try {
//       Database? mydb = await db;

//       return await mydb!.update(
//           DebitPayingsModel.DebitPayingsModelName, item.toJson(),
//           where: '${DebitPayingsModel.columnId} = ?', whereArgs: [item.id]);
//     } catch (e) {
//       print(e);
//     }
//   }

  // List<DebitPayingsModel> debitPayingsModels = [];
  // getAllDebitPayingsTable() async {
  //   try {
  //     debitPayingsModels = [];
  //     List<Map<String, dynamic>> data = await readData(
  //         "SELECT * FROM '${DebitPayingsModel.DebitPayingsModelName}' ");

  //     for (var element in data) {
  //       debitPayingsModels.add(DebitPayingsModel.fromJson(element));
  //     }
  //   } catch (e) {
  //     if (kDebugMode) {
  //       print(e);
  //     }
  //   }
  // }

//   //------------------------------------------------------------------
//   // Todo Receipts Table
//   createReceiptsTable(Database db) async {
//     await db.execute('''
//     CREATE TABLE "${ReceiptsModel.ReceiptsModelName}" (
//       "${ReceiptsModel.columnId}" TEXT NOT NULL PRIMARY KEY ,
//       "${ReceiptsModel.columnAmount}" REAL ,
//       "${ReceiptsModel.columnBillId}" TEXT ,
//       "${ReceiptsModel.columnName}" TEXT ,
//       "${ReceiptsModel.columnQuantity}" INTEGER ,
//       "${ReceiptsModel.columnUnitPrice}" REAL
//     )
//     ''');
//   }

//   insertReceiptsTable(ReceiptsModel item) async {
//     try {
//       await insertData('''
//           INSERT INTO
//           '${ReceiptsModel.ReceiptsModelName}'
//           ('${ReceiptsModel.columnId}',
//           '${ReceiptsModel.columnAmount}',
//           '${ReceiptsModel.columnBillId}',
//           '${ReceiptsModel.columnName}',
//           '${ReceiptsModel.columnQuantity}',
//           '${ReceiptsModel.columnUnitPrice}')
//           VALUES (
//             '${item.id}',
//           '${item.amount}',
//           '${item.billId}',
//           '${item.productName}',
//           '${item.quantity}',
//           '${item.unitPrice}}'
//           )
//           ''');
//     } catch (e) {
//       if (kDebugMode) {
//         print(e);
//       }
//     }
//   }

//   getReceiptsModelById(var id) async {
//     try {
//       Database? mydb = await db;

//       List<Map<String, dynamic>> maps =
//           await mydb!.query(ReceiptsModel.ReceiptsModelName,
//               columns: [
//                 ReceiptsModel.columnId,
//                 ReceiptsModel.columnAmount,
//                 ReceiptsModel.columnBillId,
//                 ReceiptsModel.columnName,
//                 ReceiptsModel.columnQuantity,
//                 ReceiptsModel.columnUnitPrice
//               ],
//               where: '${ReceiptsModel.columnId} = ?',
//               whereArgs: [id]);
//       if (maps.isNotEmpty) {
//         return ReceiptsModel.fromJson(maps.first);
//       }
//     } catch (e) {
//       print(e);
//     }
//   }

//   deleteReceiptsModel(var id) async {
//     try {
//       Database? mydb = await db;

//       return await mydb!.delete(ReceiptsModel.ReceiptsModelName,
//           where: '${ReceiptsModel.columnId} = ?', whereArgs: [id]);
//     } catch (e) {
//       print(e);
//     }
//   }

//   deleteAllReceiptsModel() async {
//     try {
//       Database? mydb = await db;

//       for (var element in receiptsModels) {
//         mydb!.delete(ReceiptsModel.ReceiptsModelName,
//             where: '${ReceiptsModel.columnId} = ?', whereArgs: [element.id]);
//       }
//     } catch (e) {
//       print(e);
//     }
//   }

//   updateReceiptsModel(ReceiptsModel item) async {
//     try {
//       Database? mydb = await db;

//       return await mydb!.update(ReceiptsModel.ReceiptsModelName, item.toJson(),
//           where: '${ReceiptsModel.columnId} = ?', whereArgs: [item.id]);
//     } catch (e) {
//       print(e);
//     }
//   }

//   List<ReceiptsModel> receiptsModels = [];
//   getAllReceiptsTable() async {
//     try {
//       receiptsModels = [];
//       List<Map<String, dynamic>> data =
//           await readData("SELECT * FROM '${ReceiptsModel.ReceiptsModelName}' ");

//       for (var element in data) {
//         receiptsModels.add(ReceiptsModel.fromJson(element));
//       }
//     } catch (e) {
//       if (kDebugMode) {
//         print(e);
//       }
//     }
//   }

//   //------------------------------------------------------------------
//   // Todo Unit Table
//   createUnitTable(Database db) async {
//     await db.execute('''
//     CREATE TABLE "${UnitModel.UnitModelName}" (
//       "${UnitModel.columnId}" INTEGER NOT NULL PRIMARY KEY ,
//       "${UnitModel.columnCompanyId}" INTEGER ,
//       "${UnitModel.columnIsActive}" INTEGER ,
//       "${UnitModel.columnName}" TEXT
//     )
//     ''');
//   }

//   insertUnitTable(UnitModel item) async {
//     try {
//       await insertData('''
//           INSERT INTO
//           '${UnitModel.UnitModelName}'
//           ('${UnitModel.columnId}',
//           '${UnitModel.columnCompanyId}',
//           '${UnitModel.columnIsActive}',
//           '${UnitModel.columnName}')
//           VALUES (
//             '${item.id}',
//           '${item.companyId}',
//           '${item.isActive! ? 1 : 0}',
//           '${item.nameUnit}'
//           )
//           ''');
//     } catch (e) {
//       if (kDebugMode) {
//         print(e);
//       }
//     }
//   }

//   getUnitModelById(var id) async {
//     try {
//       Database? mydb = await db;

//       List<Map<String, dynamic>> maps =
//           await mydb!.query(UnitModel.UnitModelName,
//               columns: [
//                 UnitModel.columnId,
//                 UnitModel.columnCompanyId,
//                 UnitModel.columnIsActive,
//                 UnitModel.columnName,
//               ],
//               where: '${UnitModel.columnId} = ?',
//               whereArgs: [id]);
//       if (maps.isNotEmpty) {
//         return UnitModel.fromJsonEdit(maps.first);
//       }
//     } catch (e) {
//       print(e);
//     }
//   }

//   deleteUnitModel(var id) async {
//     try {
//       Database? mydb = await db;

//       return await mydb!.delete(UnitModel.UnitModelName,
//           where: '${UnitModel.columnId} = ?', whereArgs: [id]);
//     } catch (e) {
//       print(e);
//     }
//   }

//   deleteAllUnitModel() async {
//     try {
//       Database? mydb = await db;

//       for (var element in unitModels) {
//         mydb!.delete(UnitModel.UnitModelName,
//             where: '${UnitModel.columnId} = ?', whereArgs: [element.id]);
//       }
//     } catch (e) {
//       print(e);
//     }
//   }

//   updateUnitModel(UnitModel item) async {
//     try {
//       Database? mydb = await db;

//       return await mydb!.update(UnitModel.UnitModelName, item.toJson(),
//           where: '${UnitModel.columnId} = ?', whereArgs: [item.id]);
//     } catch (e) {
//       print(e);
//     }
//   }

//   List<UnitModel> unitModels = [];
//   getAllUnitTable() async {
//     try {
//       unitModels = [];
//       List<Map<String, dynamic>> data =
//           await readData("SELECT * FROM '${UnitModel.UnitModelName}' ");

//       for (var element in data) {
//         unitModels.add(UnitModel.fromJsonEdit(element));
//       }
//     } catch (e) {
//       if (kDebugMode) {
//         print(e);
//       }
//     }
//   }

//   //------------------------------------------------------------------
//   // Todo Category Table

//   getCategoryModelById(var id) async {
//     try {
//       Database? mydb = await db;

//       List<Map<String, dynamic>> maps =
//           await mydb!.query(CategoryModel.CategoryModelName,
//               columns: [
//                 CategoryModel.columnId,
//                 CategoryModel.columnCompanyId,
//                 CategoryModel.columnIsActive,
//                 CategoryModel.columnDescription,
//                 CategoryModel.columnName,
//               ],
//               where: '${CategoryModel.columnId} = ?',
//               whereArgs: [id]);
//       if (maps.isNotEmpty) {
//         return CategoryModel.fromJsonEdit(maps.first);
//       }
//     } catch (e) {
//       print(e);
//     }
//   }

//   deleteCategoryModel(var id) async {
//     try {
//       Database? mydb = await db;

//       return await mydb!.delete(CategoryModel.CategoryModelName,
//           where: '${CategoryModel.columnId} = ?', whereArgs: [id]);
//     } catch (e) {
//       print(e);
//     }
//   }

//   deleteAllCategoryModel() async {
//     try {
//       Database? mydb = await db;

//       for (var element in categoryModels) {
//         mydb!.delete(CategoryModel.CategoryModelName,
//             where: '${CategoryModel.columnId} = ?', whereArgs: [element.id]);
//       }
//     } catch (e) {
//       print(e);
//     }
//   }

//   updateCategoryModel(CategoryModel item) async {
//     try {
//       Database? mydb = await db;

//       return await mydb!.update(CategoryModel.CategoryModelName, item.toJson(),
//           where: '${CategoryModel.columnId} = ?', whereArgs: [item.id]);
//     } catch (e) {
//       print(e);
//     }
//   }

  // List<CategoryModel> categoryModels = [];
  // getAllCategoryTable() async {
  //   emit(GetAllCategoryTableLoading());
  //   try {
  //     categoryModels = [];
  //     List<Map<String, dynamic>> data =
  //         await readData("SELECT * FROM '${CategoryModel.CategoryModelName}' ");

  //     for (var element in data) {
  //       categoryModels.add(CategoryModel.fromJsonEdit(element));
  //     }
  //     emit(GetAllCategoryTableSuccess());
  //   } catch (e) {
  //     if (kDebugMode) {
  //       print(e);
  //     }
  //     emit(GetAllCategoryTableError());
  //   }
  // }

//   //------------------------------------------------------------------
//   // Todo Order Table


//   getOrderModelById(var id) async {
//     try {
//       Database? mydb = await db;

//       List<Map<String, dynamic>> maps =
//           await mydb!.query(OrderModel.OrderModelName,
//               columns: [
//                 OrderModel.columnId,
//                 OrderModel.columnClientID,
//                 OrderModel.columnPayTypeID,
//                 OrderModel.columnEmpID,
//                 OrderModel.columnIsPayCash,
//                 OrderModel.columnCreateDate,
//                 OrderModel.columnUpdateDate,
//                 OrderModel.columnDiscount,
//                 OrderModel.columnTotalCost,
//                 OrderModel.columnTaxes,
//                 OrderModel.columnCostNet,
//                 OrderModel.columnDebitPay,
//                 OrderModel.columnPayAmount,
//                 OrderModel.columnQrcode,
//                 OrderModel.columnIsReturn,
//                 OrderModel.columnReturnDesc,
//               ],
//               where: '${OrderModel.columnId} = ?',
//               whereArgs: [id]);
//       if (maps.isNotEmpty) {
//         return OrderModel.fromJsonEdit(maps.first);
//       }
//     } catch (e) {
//       print(e);
//     }
//   }

//   deleteOrderModel(var id) async {
//     try {
//       Database? mydb = await db;

//       return await mydb!.delete(OrderModel.OrderModelName,
//           where: '${OrderModel.columnId} = ?', whereArgs: [id]);
//     } catch (e) {
//       print(e);
//     }
//   }

//   deleteAllOrderModel() async {
//     try {
//       Database? mydb = await db;

//       for (var element in orderModels) {
//         mydb!.delete(OrderModel.OrderModelName,
//             where: '${OrderModel.columnId} = ?', whereArgs: [element.id]);
//       }
//     } catch (e) {
//       print(e);
//     }
//   }

//   updateOrderModel(OrderModel item) async {
//     try {
//       Database? mydb = await db;

//       return await mydb!.update(OrderModel.OrderModelName, item.toJson(),
//           where: '${OrderModel.columnId} = ?', whereArgs: [item.id]);
//     } catch (e) {
//       print(e);
//     }
//   }

  // List<OrderModel> orderModels = [];
  // getAllOrderTable() async {
  //   try {
  //     orderModels = [];
  //     List<Map<String, dynamic>> data =
  //         await readData("SELECT * FROM '${OrderModel.OrderModelName}' ");

  //     for (var element in data) {
  //       orderModels.add(OrderModel.fromJsonEdit(element));
  //     }
  //   } catch (e) {
  //     print(e);
  //   }
  // }

//   //------------------------------------------------------------------
//   // Todo Product Table

//   getProductModelById(var id) async {
//     try {
//       Database? mydb = await db;

//       List<Map<String, dynamic>> maps =
//           await mydb!.query(ProductModel.ProductModelName,
//               columns: [
//                 ProductModel.columnId,
//                 ProductModel.columnName,
//                 ProductModel.columnBuyingPrice,
//                 ProductModel.columnUnitPackage,
//                 ProductModel.columnUnitID,
//                 ProductModel.columnCreateDate,
//                 ProductModel.columnUpdateDate,
//                 ProductModel.columnDiscount,
//                 ProductModel.columnStockQuantity,
//                 ProductModel.columnQrCode,
//                 ProductModel.columnImage,
//                 ProductModel.columnExpirationDate,
//                 ProductModel.columnProductNumber,
//                 ProductModel.columnCatID,
//                 ProductModel.columnCompID,
//                 ProductModel.columnPriceOne,
//                 ProductModel.columnPriceThree,
//                 ProductModel.columnPriceTwo,
//                 ProductModel.columnDescription,
//                 ProductModel.columnIsActive,
//                 ProductModel.columnIsPetrolGas,
//               ],
//               where: '${ProductModel.columnId} = ?',
//               whereArgs: [id]);
//       if (maps.isNotEmpty) {
//         return ProductModel.fromJsonEdit(maps.first);
//       }
//     } catch (e) {
//       print(e);
//     }
//   }

//   deleteProductModel(var id) async {
//     try {
//       Database? mydb = await db;

//       return await mydb!.delete(ProductModel.ProductModelName,
//           where: '${ProductModel.columnId} = ?', whereArgs: [id]);
//     } catch (e) {
//       print(e);
//     }
//   }

//   deleteAllProductModel() async {
//     try {
//       Database? mydb = await db;

//       for (var element in productModels) {
//         mydb!.delete(ProductModel.ProductModelName,
//             where: '${ProductModel.columnId} = ?', whereArgs: [element.prodId]);
//       }
//     } catch (e) {
//       print(e);
//     }
//   }

//   updateProductModel(ProductModel item) async {
//     try {
//       Database? mydb = await db;

//       return await mydb!.update(ProductModel.ProductModelName, item.toJson(),
//           where: '${ProductModel.columnId} = ?', whereArgs: [item.prodId]);
//     } catch (e) {
//       print(e);
//     }
//   }

  // List<ProductModel> productModels = [];
  // getAllProductTable() async {
  //   emit(GetAllProductTableLoading());
  //   try {
  //     productModels = [];
  //     List<Map<String, dynamic>> data =
  //         await readData("SELECT * FROM '${ProductModel.ProductModelName}' ");

  //     for (var element in data) {
  //       // Database? mydb = await db;

  //       // print(await mydb!.delete(ProductModel.ProductModelName,
  //       //     where: '${ProductModel.columnId} = ?',
  //       //     whereArgs: [element["Prod_Id"]]));

  //       productModels.add(ProductModel.fromJsonEdit(element));
  //     }

  //     emit(GetAllProductTableSuccess());
  //   } catch (e) {
  //     print(e);
  //     emit(GetAllProductTableError());
  //   }
  // }

//   //------------------------------------------------------------------
//   // Todo Client Table


  // getClientModelById(var id) async {
  //   try {
  //     Database? mydb = await db;

  //     List<Map<String, dynamic>> maps =
  //         await mydb!.query(ClientModel.ClientModelName,
  //             columns: [
  //               ClientModel.columnId,
  //               ClientModel.columnName,
  //               ClientModel.columnPhone,
  //               ClientModel.columnLoacation,
  //               ClientModel.columnComment,
  //               ClientModel.columnTaxNumber,
  //               ClientModel.columnCreateDate,
  //               ClientModel.columnUpdateDate,
  //               ClientModel.columnAmmountTobePaid,
  //               ClientModel.columnMaxDebitLimit,
  //               ClientModel.columnMaxLimtDebitRecietCount,
  //               ClientModel.columnEmpID,
  //               ClientModel.columnCompanyId,
  //               ClientModel.columnIsActive,
  //               ClientModel.columnAddress
  //             ],
  //             where: '${ClientModel.columnId} = ?',
  //             whereArgs: [id]);
  //     if (maps.isNotEmpty) {
  //       return ClientModel.fromJsonEdit(maps.first);
  //     }
  //   } catch (e) {
  //     print(e);
  //   }
  // }

//   deleteClientModel(var id) async {
//     try {
//       Database? mydb = await db;

//       return await mydb!.delete(ClientModel.ClientModelName,
//           where: '${ClientModel.columnId} = ?', whereArgs: [id]);
//     } catch (e) {
//       print(e);
//     }
//   }

//   deleteAllClientModel() async {
//     try {
//       Database? mydb = await db;

//       for (var element in clientModels) {
//         mydb!.delete(ClientModel.ClientModelName,
//             where: '${ClientModel.columnId} = ?', whereArgs: [element.id]);
//       }
//     } catch (e) {
//       print(e);
//     }
//   }

  // updateClientModel(ClientModel item) async {
  //   try {
  //     Database? mydb = await db;

  //     return await mydb!.update(ClientModel.ClientModelName, item.toJson(),
  //         where: '${ClientModel.columnId} = ?', whereArgs: [item.id]);
  //   } catch (e) {
  //     print(e);
  //   }
  // }

//   //------------------------------------------------------------------
//   // Todo Bill Table
//   createBillTable(Database db) async {
//     await db.execute('''
//     CREATE TABLE "${BillModel.billModelName}" (
//       "${BillModel.columnId}" TEXT NOT NULL PRIMARY KEY ,
//       "${BillModel.columnName}" TEXT ,
//       "${BillModel.columnPhone}" TEXT ,
//       "${BillModel.columnAddress}" TEXT ,
//       "${BillModel.columnComment}" TEXT ,
//       "${BillModel.columnEmail}" TEXT ,
//       "${BillModel.columnCode}" TEXT ,
//       "${BillModel.columnLable}" TEXT ,
//       "${BillModel.columnCreateDate}" TEXT ,
//       "${BillModel.columnInvoiceDate}" TEXT ,
//       "${BillModel.columnTotal}" REAL ,
//       "${BillModel.columnCompID}" INTEGER
//     )
//     ''');
//   }

//   insertBillTable(BillModel item) async {
//     try {
//       await insertData('''
//           INSERT INTO
//           '${BillModel.billModelName}'
//           ('${BillModel.columnId}',
//           '${BillModel.columnName}',
//           '${BillModel.columnPhone}',
//           '${BillModel.columnEmail}',
//           '${BillModel.columnComment}',
//           '${BillModel.columnCode}',
//           '${BillModel.columnLable}',
//           '${BillModel.columnCreateDate}',
//           '${BillModel.columnInvoiceDate}',
//           '${BillModel.columnTotal}',
//           '${BillModel.columnCompID}',
//           '${BillModel.columnAddress}')
//           VALUES (
//             '${item.id}',
//           '${item.name}',
//           '${item.phone}',
//           '${item.email}',
//           '${item.comment}',
//           '${item.code}',
//           '${item.lable}',
//           '${item.createDate}',
//           '${item.invoiceDate}',
//           '${item.total}',
//           '${item.compID}',
//           '${item.address}'
//           )
//           ''');
//     } catch (e) {
//       print(e);
//     }
//   }

//   getBillModelById(var id) async {
//     try {
//       Database? mydb = await db;

//       List<Map<String, dynamic>> maps =
//           await mydb!.query(BillModel.billModelName,
//               columns: [
//                 BillModel.columnId,
//                 BillModel.columnAddress,
//                 BillModel.columnCode,
//                 BillModel.columnComment,
//                 BillModel.columnCompID,
//                 BillModel.columnCreateDate,
//                 BillModel.columnEmail,
//                 BillModel.columnInvoiceDate,
//                 BillModel.columnLable,
//                 BillModel.columnName,
//                 BillModel.columnPhone,
//                 BillModel.columnTotal,
//               ],
//               where: '${BillModel.columnId} = ?',
//               whereArgs: [id]);
//       if (maps.isNotEmpty) {
//         return BillModel.fromJson(maps.first);
//       }
//     } catch (e) {
//       print(e);
//     }
//   }

//   deleteBillModel(var id) async {
//     try {
//       Database? mydb = await db;

//       return await mydb!.delete(BillModel.billModelName,
//           where: '${BillModel.columnId} = ?', whereArgs: [id]);
//     } catch (e) {
//       print(e);
//     }
//   }

//   deleteAllBillModel() async {
//     try {
//       Database? mydb = await db;

//       for (var element in billModels) {
//         mydb!.delete(BillModel.billModelName,
//             where: '${BillModel.columnId} = ?', whereArgs: [element.id]);
//       }
//     } catch (e) {
//       print(e);
//     }
//   }

//   updateBillModel(BillModel item) async {
//     try {
//       Database? mydb = await db;

//       return await mydb!.update(BillModel.billModelName, item.toJson(),
//           where: '${BillModel.columnId} = ?', whereArgs: [item.id]);
//     } catch (e) {
//       print(e);
//     }
//   }

//   List<BillModel> billModels = [];
//   getAllBillTable() async {
//     try {
//       billModels = [];
//       List<Map<String, dynamic>> data =
//           await readData("SELECT * FROM '${BillModel.billModelName}' ");

//       for (var element in data) {
//         billModels.add(BillModel.fromJson(element));
//       }
//     } catch (e) {
//       print(e);
//     }
//   }
