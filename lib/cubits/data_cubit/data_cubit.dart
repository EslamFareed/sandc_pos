import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../../models/category.dart';
import '../../models/client.dart';
import '../../models/company.dart';
import '../../models/currency.dart';
import '../../models/debit_payings.dart';
import '../../models/emp_types.dart';
import '../../models/employee.dart';
import '../../models/invoice_details.dart';
import '../../models/order.dart';
import '../../models/pay_type.dart';
import '../../models/products.dart';
import '../../models/reciepts.dart';
import '../../models/unit.dart';

import '../../models/bill.dart';
import '../../models/branch.dart';
import '../../models/branch_product.dart';
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
    await createBillTable(db);
    await createBranchProductTable(db);
    await createBranchTable(db);
    await createCategoryTable(db);
    await createClientTable(db);
    await createUnitTable(db);
    await createReceiptsTable(db);
    await createPayTypeTable(db);
    await createEmpTypesTable(db);
    await createCurrencyTable(db);
    await createDebitPayingsTable(db);
    await createInvoiceDetailsTable(db);
    await createProductTable(db);
    await createOrderTable(db);
    await createEmployeeTable(db);
    await createCompanyTable(db);

    print("on Create ===================");
  }

  //------------------------------------------------------------------
  CompanyModel? companyModel;
  getCurrentCompany() async {
    companyModel = await getCompanyModelById(1);
  }

  //------------------------------------------------------------------
  // Todo Currency Table
  insertCurrencyTable(CurrencyModel item) async {
    try {
      await insertData(
          "INSERT INTO '${CurrencyModel.CurrencyModelName}' ('${CurrencyModel.columnId}','${CurrencyModel.columnName}') VALUES ('${item.id}','${item.name}') ");
    } catch (e) {
      print(e);
    }
  }

  List<CurrencyModel> currencyModels = [];
  getAllCurrencyTable() async {
    try {
      currencyModels = [];
      List<Map<String, dynamic>> data =
          await readData("SELECT * FROM '${CurrencyModel.CurrencyModelName}' ");

      for (var element in data) {
        currencyModels.add(CurrencyModel.fromJson(element));
      }
    } catch (e) {
      print(e);
    }
  }

  getCurrencyModelById(var id) async {
    try {
      Database? mydb = await db;

      List<Map<String, dynamic>> maps =
          await mydb!.query(CurrencyModel.CurrencyModelName,
              columns: [
                CurrencyModel.columnId,
                CurrencyModel.columnName,
              ],
              where: '${CurrencyModel.columnId} = ?',
              whereArgs: [id]);
      if (maps.isNotEmpty) {
        return CurrencyModel.fromJson(maps.first);
      }
    } catch (e) {
      print(e);
    }
  }

  deleteCurrencyModel(var id) async {
    try {
      Database? mydb = await db;

      return await mydb!.delete(CurrencyModel.CurrencyModelName,
          where: '${CurrencyModel.columnId} = ?', whereArgs: [id]);
    } catch (e) {
      print(e);
    }
    return 0;
  }

  deleteAllCurrencyModel() async {
    try {
      Database? mydb = await db;

      for (var element in currencyModels) {
        mydb!.delete(CurrencyModel.CurrencyModelName,
            where: '${CurrencyModel.columnId} = ?', whereArgs: [element.id]);
      }
    } catch (e) {
      print(e);
    }
  }

  updateCurrencyModel(CurrencyModel item) async {
    try {
      Database? mydb = await db;

      return await mydb!.update(CurrencyModel.CurrencyModelName, item.toJson(),
          where: '${CurrencyModel.columnId} = ?', whereArgs: [item.id]);
    } catch (e) {
      print(e);
    }
  }

  createCurrencyTable(Database db) async {
    await db.execute('''
    CREATE TABLE "${CurrencyModel.CurrencyModelName}" (
      "${CurrencyModel.columnId}" INTEGER NOT NULL PRIMARY KEY , 
      "${CurrencyModel.columnName}" TEXT
    )
    ''');
  }

  //------------------------------------------------------------------
  // Todo Emp Types Table
  insertEmpTypesTable(EmpTypesModel item) async {
    try {
      await insertData(
          "INSERT INTO '${EmpTypesModel.EmpTypesModelName}' ('${EmpTypesModel.columnId}','${EmpTypesModel.columnName}') VALUES ('${item.id}','${item.name}') ");
    } catch (e) {
      print(e);
    }
  }

  getEmpTypesModelById(var id) async {
    try {
      Database? mydb = await db;

      List<Map<String, dynamic>> maps =
          await mydb!.query(EmpTypesModel.EmpTypesModelName,
              columns: [
                EmpTypesModel.columnId,
                EmpTypesModel.columnName,
              ],
              where: '${EmpTypesModel.columnId} = ?',
              whereArgs: [id]);
      if (maps.isNotEmpty) {
        return EmpTypesModel.fromJson(maps.first);
      }
    } catch (e) {
      print(e);
    }
  }

  deleteEmpTypesModel(var id) async {
    try {
      Database? mydb = await db;

      return await mydb!.delete(EmpTypesModel.EmpTypesModelName,
          where: '${EmpTypesModel.columnId} = ?', whereArgs: [id]);
    } catch (e) {
      print(e);
    }
  }

  deleteAllEmpTypesModel() async {
    try {
      Database? mydb = await db;

      for (var element in empTypesModels) {
        mydb!.delete(EmpTypesModel.EmpTypesModelName,
            where: '${EmpTypesModel.columnId} = ?', whereArgs: [element.id]);
      }
    } catch (e) {
      print(e);
    }
  }

  updateEmpTypesModel(EmpTypesModel item) async {
    try {
      Database? mydb = await db;

      return await mydb!.update(EmpTypesModel.EmpTypesModelName, item.toJson(),
          where: '${EmpTypesModel.columnId} = ?', whereArgs: [item.id]);
    } catch (e) {
      print(e);
    }
  }

  List<EmpTypesModel> empTypesModels = [];
  getAllEmpTypesTable() async {
    try {
      empTypesModels = [];
      List<Map<String, dynamic>> data =
          await readData("SELECT * FROM '${EmpTypesModel.EmpTypesModelName}' ");

      for (var element in data) {
        empTypesModels.add(EmpTypesModel.fromJson(element));
      }
    } catch (e) {
      print(e);
    }
  }

  createEmpTypesTable(Database db) async {
    await db.execute('''
    CREATE TABLE "${EmpTypesModel.EmpTypesModelName}" (
      "${EmpTypesModel.columnId}" INTEGER NOT NULL PRIMARY KEY ,
      "${EmpTypesModel.columnName}" TEXT
    )
    ''');
  }

  //------------------------------------------------------------------
  // Todo PayType Table
  createPayTypeTable(Database db) async {
    await db.execute('''
    CREATE TABLE "${PayTypeModel.PayTypeModelName}" (
      "${ReceiptsModel.columnId}" INTEGER NOT NULL PRIMARY KEY , 
      "${ReceiptsModel.columnName}" TEXT
    )
    ''');
  }

  insertPayTypeTable(PayTypeModel item) async {
    try {
      await insertData(
          "INSERT INTO '${PayTypeModel.PayTypeModelName}' ('${PayTypeModel.columnId}','${PayTypeModel.columnName}') VALUES ('${item.id}','${item.name}') ");
    } catch (e) {
      print(e);
    }
  }

  getPayTypeModelById(var id) async {
    try {
      Database? mydb = await db;

      List<Map<String, dynamic>> maps =
          await mydb!.query(PayTypeModel.PayTypeModelName,
              columns: [
                PayTypeModel.columnId,
                PayTypeModel.columnName,
              ],
              where: '${PayTypeModel.columnId} = ?',
              whereArgs: [id]);
      if (maps.isNotEmpty) {
        return PayTypeModel.fromJson(maps.first);
      }
    } catch (e) {
      print(e);
    }
  }

  deletePayTypeModel(var id) async {
    try {
      Database? mydb = await db;

      return await mydb!.delete(PayTypeModel.PayTypeModelName,
          where: '${PayTypeModel.columnId} = ?', whereArgs: [id]);
    } catch (e) {
      print(e);
    }
  }

  deleteAllPayTypeModel() async {
    try {
      Database? mydb = await db;

      for (var element in payTypeModels) {
        mydb!.delete(PayTypeModel.PayTypeModelName,
            where: '${PayTypeModel.columnId} = ?', whereArgs: [element.id]);
      }
    } catch (e) {
      print(e);
    }
  }

  updatePayTypeModel(PayTypeModel item) async {
    try {
      Database? mydb = await db;

      return await mydb!.update(PayTypeModel.PayTypeModelName, item.toJson(),
          where: '${PayTypeModel.columnId} = ?', whereArgs: [item.id]);
    } catch (e) {
      print(e);
    }
  }

  List<PayTypeModel> payTypeModels = [];
  getAllPayTypeTable() async {
    try {
      payTypeModels = [];
      List<Map<String, dynamic>> data =
          await readData("SELECT * FROM '${PayTypeModel.PayTypeModelName}' ");

      for (var element in data) {
        payTypeModels.add(PayTypeModel.fromJson(element));
      }
    } catch (e) {
      print(e);
    }
  }

  //------------------------------------------------------------------
  // Todo Company Table
  createCompanyTable(Database db) async {
    await db.execute('''
    CREATE TABLE "${CompanyModel.CompanyModelName}" (
      "${CompanyModel.columnId}" INTEGER NOT NULL PRIMARY KEY , 
      "${CompanyModel.columnIsAdmin}" INTEGER , 
      "${CompanyModel.columnIsConfirmed}" INTEGER , 
      "${CompanyModel.columnIsMustChoosePayCash}" INTEGER , 
      "${CompanyModel.columnIsTaxes}" INTEGER , 
      "${CompanyModel.columnCurrencyId}" INTEGER , 
      "${CompanyModel.columnCompanyName}" TEXT ,      
      "${CompanyModel.columnCompanyDescription}" TEXT ,      
      "${CompanyModel.columnAddress}" TEXT ,      
      "${CompanyModel.columnVerificationToken}" TEXT ,      
      "${CompanyModel.columnVerifiedAt}" TEXT ,
      "${CompanyModel.columnPhone}" TEXT ,
      "${CompanyModel.columnEmail}" TEXT ,
      "${CompanyModel.columnPassword}" TEXT ,
      "${CompanyModel.columnPasswordSalt}" TEXT ,
      "${CompanyModel.columnRestTokenExpires}" TEXT ,
      "${CompanyModel.columnCreateDate}" TEXT ,
      "${CompanyModel.columnLogo}" TEXT ,
      "${CompanyModel.columnLanguage}" TEXT ,
      "${CompanyModel.columnTaxNumber}" TEXT ,
      "${CompanyModel.columnTaxAmount}" REAL ,
      "${CompanyModel.columnPasswordResetToken}" TEXT
    )
    ''');
  }

  insertCompanyTable(CompanyModel item) async {
    try {
      await insertData('''
          INSERT INTO 
          '${CompanyModel.CompanyModelName}'
          ('${CompanyModel.columnId}',
          '${CompanyModel.columnAddress}',
          '${CompanyModel.columnCompanyDescription}',
          '${CompanyModel.columnCompanyName}',
          '${CompanyModel.columnCreateDate}',
          '${CompanyModel.columnCurrencyId}',
          '${CompanyModel.columnEmail}',
          '${CompanyModel.columnIsAdmin}',
          '${CompanyModel.columnIsConfirmed}',
          '${CompanyModel.columnIsMustChoosePayCash}',
          '${CompanyModel.columnIsTaxes}',
          '${CompanyModel.columnLanguage}',
          '${CompanyModel.columnLogo}',
          '${CompanyModel.columnPassword}',
          '${CompanyModel.columnPasswordResetToken}',
          '${CompanyModel.columnPasswordSalt}',
          '${CompanyModel.columnPhone}',
          '${CompanyModel.columnRestTokenExpires}',
          '${CompanyModel.columnTaxAmount}',
          '${CompanyModel.columnTaxNumber}',
          '${CompanyModel.columnVerificationToken}',
          '${CompanyModel.columnVerifiedAt}')
          VALUES (
            '${item.id}',
          '${item.address}',
          '${item.companyDescription}',
          '${item.companyName}',
          '${item.createDate}',
          '${item.currencyId}',
          '${item.email}',
          '${item.isAdmin! ? 1 : 0}',
          '${item.isConfirmed! ? 1 : 0}',
          '${item.isMustChoosePayCash! ? 1 : 0}',
          '${item.isTaxes! ? 1 : 0}',
          '${item.language}',
          '${item.logo}',
          '${item.password}',
          '${item.passwordResetToken}',
          '${item.passwordSalt}',
          '${item.phone}',
          '${item.restTokenExpires}',
          '${item.taxAmount}',
          '${item.taxNumber}',
          '${item.verificationToken}',
          '${item.verifiedAt}'
          ) 
          ''');
    } catch (e) {
      print(e);
    }
  }

  getCompanyModelById(var id) async {
    try {
      Database? mydb = await db;

      List<Map<String, dynamic>> maps =
          await mydb!.query(CompanyModel.CompanyModelName,
              columns: [
                CompanyModel.columnId,
                CompanyModel.columnAddress,
                CompanyModel.columnCompanyDescription,
                CompanyModel.columnCompanyName,
                CompanyModel.columnCreateDate,
                CompanyModel.columnCurrencyId,
                CompanyModel.columnEmail,
                CompanyModel.columnIsAdmin,
                CompanyModel.columnIsConfirmed,
                CompanyModel.columnIsMustChoosePayCash,
                CompanyModel.columnIsTaxes,
                CompanyModel.columnLanguage,
                CompanyModel.columnLogo,
                CompanyModel.columnPassword,
                CompanyModel.columnPasswordResetToken,
                CompanyModel.columnPasswordSalt,
                CompanyModel.columnPhone,
                CompanyModel.columnRestTokenExpires,
                CompanyModel.columnTaxAmount,
                CompanyModel.columnTaxNumber,
                CompanyModel.columnVerificationToken,
                CompanyModel.columnVerifiedAt,
              ],
              where: '${CompanyModel.columnId} = ?',
              whereArgs: [id]);
      if (maps.isNotEmpty) {
        return CompanyModel.fromJsonEdit(maps.first);
      }
    } catch (e) {
      print(e);
    }
  }

  deleteCompanyModel(var id) async {
    try {
      Database? mydb = await db;

      return await mydb!.delete(CompanyModel.CompanyModelName,
          where: '${CompanyModel.columnId} = ?', whereArgs: [id]);
    } catch (e) {
      print(e);
    }
  }

  deleteAllCompanyModel() async {
    try {
      Database? mydb = await db;

      for (var element in companyModels) {
        mydb!.delete(CompanyModel.CompanyModelName,
            where: '${CompanyModel.columnId} = ?', whereArgs: [element.id]);
      }
    } catch (e) {
      print(e);
    }
  }

  updateCompanyModel(CompanyModel item) async {
    try {
      Database? mydb = await db;

      return await mydb!.update(CompanyModel.CompanyModelName, item.toJson(),
          where: '${CompanyModel.columnId} = ?', whereArgs: [item.id]);
    } catch (e) {
      print(e);
    }
  }

  List<CompanyModel> companyModels = [];
  getAllCompanyTable() async {
    try {
      companyModels = [];
      List<Map<String, dynamic>> data =
          await readData("SELECT * FROM '${CompanyModel.CompanyModelName}' ");

      for (var element in data) {
        companyModels.add(CompanyModel.fromJsonEdit(element));
      }
    } catch (e) {
      print(e);
    }
  }

//------------------------------------------------------------------
  // Todo Employee Table
  createEmployeeTable(Database db) async {
    await db.execute('''
    CREATE TABLE "${EmployeeModel.EmployeeModelName}" (
      "${EmployeeModel.columnId}" INTEGER NOT NULL PRIMARY KEY , 
      "${EmployeeModel.columnCompanyId}" INTEGER ,      
      "${EmployeeModel.columnIsActive}" INTEGER ,      
      "${EmployeeModel.columnBranchId}" INTEGER ,      
      "${EmployeeModel.columnEmpTypeID}" INTEGER ,      
      "${EmployeeModel.columnName}" TEXT ,
      "${EmployeeModel.columnPhone}" TEXT ,
      "${EmployeeModel.columnEmail}" TEXT ,
      "${EmployeeModel.columnPassword}" TEXT ,
      "${EmployeeModel.columnPasswordSalt}" TEXT ,
      "${EmployeeModel.columnCreateDate}" TEXT ,
      "${EmployeeModel.columnUpdateDate}" TEXT
    )
    ''');
  }

  insertEmployeeTable(EmployeeModel item) async {
    try {
      await insertData('''
          INSERT INTO 
          '${EmployeeModel.EmployeeModelName}'
          ('${EmployeeModel.columnId}',
          '${EmployeeModel.columnBranchId}',
          '${EmployeeModel.columnCompanyId}',
          '${EmployeeModel.columnEmpTypeID}',
          '${EmployeeModel.columnCreateDate}',
          '${EmployeeModel.columnIsActive}',
          '${EmployeeModel.columnEmail}',
          '${EmployeeModel.columnUpdateDate}',
          '${EmployeeModel.columnName}',
          '${EmployeeModel.columnPassword}',
          '${EmployeeModel.columnPasswordSalt}',
          '${EmployeeModel.columnPhone}')
          VALUES (
            '${item.iD}',
          '${item.branchId}',
          '${item.companyId}',
          '${item.empTypeID}',
          '${item.createDate}',
          '${item.isActive! ? 1 : 0}}',
          '${item.email}',
          '${item.updateDate}',
          '${item.name}',
          '${item.password}',
          '${item.passwordSalt}',
          '${item.phone}'          
          ) 
          ''');
    } catch (e) {
      print(e);
    }
  }

  getEmployeeModelById(var id) async {
    try {
      Database? mydb = await db;

      List<Map<String, dynamic>> maps =
          await mydb!.query(EmployeeModel.EmployeeModelName,
              columns: [
                EmployeeModel.columnId,
                EmployeeModel.columnBranchId,
                EmployeeModel.columnCompanyId,
                EmployeeModel.columnEmpTypeID,
                EmployeeModel.columnCreateDate,
                EmployeeModel.columnIsActive,
                EmployeeModel.columnEmail,
                EmployeeModel.columnUpdateDate,
                EmployeeModel.columnName,
                EmployeeModel.columnPassword,
                EmployeeModel.columnPasswordSalt,
                EmployeeModel.columnPhone,
              ],
              where: '${EmployeeModel.columnId} = ?',
              whereArgs: [id]);
      if (maps.isNotEmpty) {
        return EmployeeModel.fromJsonEdit(maps.first);
      }
    } catch (e) {
      print(e);
    }
  }

  deleteEmployeeModel(var id) async {
    try {
      Database? mydb = await db;

      return await mydb!.delete(EmployeeModel.EmployeeModelName,
          where: '${EmployeeModel.columnId} = ?', whereArgs: [id]);
    } catch (e) {
      print(e);
    }
  }

  deleteAllEmployeeModel() async {
    try {
      Database? mydb = await db;

      for (var element in employeeModels) {
        mydb!.delete(EmployeeModel.EmployeeModelName,
            where: '${EmployeeModel.columnId} = ?', whereArgs: [element.iD]);
      }
    } catch (e) {
      print(e);
    }
  }

  updateEmployeeModel(EmployeeModel item) async {
    try {
      Database? mydb = await db;

      return await mydb!.update(EmployeeModel.EmployeeModelName, item.toJson(),
          where: '${EmployeeModel.columnId} = ?', whereArgs: [item.iD]);
    } catch (e) {
      print(e);
    }
  }

  List<EmployeeModel> employeeModels = [];
  getAllEmployeeTable() async {
    try {
      employeeModels = [];
      List<Map<String, dynamic>> data =
          await readData("SELECT * FROM '${EmployeeModel.EmployeeModelName}' ");

      for (var element in data) {
        employeeModels.add(EmployeeModel.fromJsonEdit(element));
      }
    } catch (e) {
      print(e);
    }
  }

  //------------------------------------------------------------------
  // Todo InvoiceDetails Table
  createInvoiceDetailsTable(Database db) async {
    await db.execute('''
    CREATE TABLE "${InvoiceDetailsModel.InvoiceDetailsModelName}" (
      "${InvoiceDetailsModel.columnId}" TEXT NOT NULL PRIMARY KEY , 
      "${InvoiceDetailsModel.columnProdId}" TEXT ,      
      "${InvoiceDetailsModel.columnQuanitiy}" INTEGER ,
      "${InvoiceDetailsModel.columnUnitPrice}" REAL ,
      "${InvoiceDetailsModel.columnTotalCost}" REAL ,
      "${InvoiceDetailsModel.columnIsReturn}" INTEGER ,
      "${InvoiceDetailsModel.columnReasonForReturn}" TEXT ,
      "${InvoiceDetailsModel.columnQuantReturns}" INTEGER ,
      "${InvoiceDetailsModel.columnOrderID}" TEXT
    )
    ''');
  }

  insertInvoiceDetailsTable(InvoiceDetailsModel item) async {
    try {
      await insertData('''
          INSERT INTO 
          '${InvoiceDetailsModel.InvoiceDetailsModelName}'
          ('${InvoiceDetailsModel.columnId}',
          '${InvoiceDetailsModel.columnIsReturn}',
          '${InvoiceDetailsModel.columnOrderID}',
          '${InvoiceDetailsModel.columnProdId}',
          '${InvoiceDetailsModel.columnQuanitiy}',
          '${InvoiceDetailsModel.columnQuantReturns}',
          '${InvoiceDetailsModel.columnReasonForReturn}',
          '${InvoiceDetailsModel.columnTotalCost}',
          '${InvoiceDetailsModel.columnUnitPrice}')
          VALUES (
            '${item.iD}',
          '${item.orderID}',
          '${item.prodId}',
          '${item.quanitiy}',
          '${item.quantReturns}',
          '${item.isReturn! ? 1 : 0}}',
          '${item.reasonForReturn}',
          '${item.totalCost}',
          '${item.unitPrice}'          
          ) 
          ''');
    } catch (e) {
      print(e);
    }
  }

  getInvoiceDetailsModelById(var id) async {
    try {
      Database? mydb = await db;

      List<Map<String, dynamic>> maps =
          await mydb!.query(InvoiceDetailsModel.InvoiceDetailsModelName,
              columns: [
                InvoiceDetailsModel.columnId,
                InvoiceDetailsModel.columnIsReturn,
                InvoiceDetailsModel.columnOrderID,
                InvoiceDetailsModel.columnProdId,
                InvoiceDetailsModel.columnQuanitiy,
                InvoiceDetailsModel.columnQuantReturns,
                InvoiceDetailsModel.columnReasonForReturn,
                InvoiceDetailsModel.columnTotalCost,
                InvoiceDetailsModel.columnUnitPrice,
              ],
              where: '${InvoiceDetailsModel.columnId} = ?',
              whereArgs: [id]);
      if (maps.isNotEmpty) {
        return InvoiceDetailsModel.fromJsonEdit(maps.first);
      }
    } catch (e) {
      print(e);
    }
  }

  deleteInvoiceDetailsModel(var id) async {
    try {
      Database? mydb = await db;

      return await mydb!.delete(InvoiceDetailsModel.InvoiceDetailsModelName,
          where: '${InvoiceDetailsModel.columnId} = ?', whereArgs: [id]);
    } catch (e) {
      print(e);
    }
  }

  deleteAllInvoiceDetailsModel() async {
    try {
      Database? mydb = await db;

      for (var element in invoiceDetailsModels) {
        mydb!.delete(InvoiceDetailsModel.InvoiceDetailsModelName,
            where: '${InvoiceDetailsModel.columnId} = ?',
            whereArgs: [element.iD]);
      }
    } catch (e) {
      print(e);
    }
  }

  updateInvoiceDetailsModel(InvoiceDetailsModel item) async {
    try {
      Database? mydb = await db;

      return await mydb!.update(
          InvoiceDetailsModel.InvoiceDetailsModelName, item.toJson(),
          where: '${InvoiceDetailsModel.columnId} = ?', whereArgs: [item.iD]);
    } catch (e) {
      print(e);
    }
  }

  List<InvoiceDetailsModel> invoiceDetailsModels = [];
  getAllInvoiceDetailsTable() async {
    try {
      invoiceDetailsModels = [];
      List<Map<String, dynamic>> data = await readData(
          "SELECT * FROM '${InvoiceDetailsModel.InvoiceDetailsModelName}' ");

      for (var element in data) {
        invoiceDetailsModels.add(InvoiceDetailsModel.fromJsonEdit(element));
      }
    } catch (e) {
      print(e);
    }
  }

  //------------------------------------------------------------------
  // Todo DebitPayings Table
  createDebitPayingsTable(Database db) async {
    await db.execute('''
    CREATE TABLE "${DebitPayingsModel.DebitPayingsModelName}" (
      "${DebitPayingsModel.columnId}" INTEGER NOT NULL PRIMARY KEY , 
      "${DebitPayingsModel.columnClientID}" INTEGER ,      
      "${DebitPayingsModel.columnCreateDate}" TEXT ,
      "${DebitPayingsModel.columnDebitAmount}" REAL ,
      "${DebitPayingsModel.columnEmpID}" INTEGER ,
      "${DebitPayingsModel.columnUpdateDate}" TEXT ,
      "${DebitPayingsModel.columnQrcode}" TEXT ,
      "${DebitPayingsModel.columnPayAmount}" REAL ,
      "${DebitPayingsModel.columnOrderID}" TEXT
    )
    ''');
  }

  insertDebitPayingsTable(DebitPayingsModel item) async {
    try {
      await insertData('''
          INSERT INTO 
          '${DebitPayingsModel.DebitPayingsModelName}'
          ('${DebitPayingsModel.columnId}',
          '${DebitPayingsModel.columnClientID}',
          '${DebitPayingsModel.columnOrderID}',
          '${DebitPayingsModel.columnCreateDate}',
          '${DebitPayingsModel.columnDebitAmount}',
          '${DebitPayingsModel.columnEmpID}',
          '${DebitPayingsModel.columnPayAmount}',
          '${DebitPayingsModel.columnQrcode}',
          '${DebitPayingsModel.columnUpdateDate}')
          VALUES (
            '${item.id}',
          '${item.clientID}',
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

  getDebitPayingsModelById(var id) async {
    try {
      Database? mydb = await db;

      List<Map<String, dynamic>> maps =
          await mydb!.query(DebitPayingsModel.DebitPayingsModelName,
              columns: [
                DebitPayingsModel.columnId,
                DebitPayingsModel.columnClientID,
                DebitPayingsModel.columnOrderID,
                DebitPayingsModel.columnCreateDate,
                DebitPayingsModel.columnDebitAmount,
                DebitPayingsModel.columnEmpID,
                DebitPayingsModel.columnPayAmount,
                DebitPayingsModel.columnQrcode,
                DebitPayingsModel.columnUpdateDate,
              ],
              where: '${DebitPayingsModel.columnId} = ?',
              whereArgs: [id]);
      if (maps.isNotEmpty) {
        return DebitPayingsModel.fromJson(maps.first);
      }
    } catch (e) {
      print(e);
    }
  }

  deleteDebitPayingsModel(var id) async {
    try {
      Database? mydb = await db;

      return await mydb!.delete(DebitPayingsModel.DebitPayingsModelName,
          where: '${DebitPayingsModel.columnId} = ?', whereArgs: [id]);
    } catch (e) {
      print(e);
    }
  }

  deleteAllDebitPayingsModel() async {
    try {
      Database? mydb = await db;

      for (var element in debitPayingsModels) {
        mydb!.delete(DebitPayingsModel.DebitPayingsModelName,
            where: '${DebitPayingsModel.columnId} = ?',
            whereArgs: [element.id]);
      }
    } catch (e) {
      print(e);
    }
  }

  updateDebitPayingsModel(DebitPayingsModel item) async {
    try {
      Database? mydb = await db;

      return await mydb!.update(
          DebitPayingsModel.DebitPayingsModelName, item.toJson(),
          where: '${DebitPayingsModel.columnId} = ?', whereArgs: [item.id]);
    } catch (e) {
      print(e);
    }
  }

  List<DebitPayingsModel> debitPayingsModels = [];
  getAllDebitPayingsTable() async {
    try {
      debitPayingsModels = [];
      List<Map<String, dynamic>> data = await readData(
          "SELECT * FROM '${DebitPayingsModel.DebitPayingsModelName}' ");

      for (var element in data) {
        debitPayingsModels.add(DebitPayingsModel.fromJson(element));
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  //------------------------------------------------------------------
  // Todo Receipts Table
  createReceiptsTable(Database db) async {
    await db.execute('''
    CREATE TABLE "${ReceiptsModel.ReceiptsModelName}" (
      "${ReceiptsModel.columnId}" TEXT NOT NULL PRIMARY KEY , 
      "${ReceiptsModel.columnAmount}" REAL ,      
      "${ReceiptsModel.columnBillId}" TEXT ,
      "${ReceiptsModel.columnName}" TEXT ,
      "${ReceiptsModel.columnQuantity}" INTEGER ,
      "${ReceiptsModel.columnUnitPrice}" REAL
    )
    ''');
  }

  insertReceiptsTable(ReceiptsModel item) async {
    try {
      await insertData('''
          INSERT INTO 
          '${ReceiptsModel.ReceiptsModelName}'
          ('${ReceiptsModel.columnId}',
          '${ReceiptsModel.columnAmount}',
          '${ReceiptsModel.columnBillId}',
          '${ReceiptsModel.columnName}',
          '${ReceiptsModel.columnQuantity}',
          '${ReceiptsModel.columnUnitPrice}')
          VALUES (
            '${item.id}',
          '${item.amount}',
          '${item.billId}',
          '${item.productName}',
          '${item.quantity}',
          '${item.unitPrice}}'         
          ) 
          ''');
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  getReceiptsModelById(var id) async {
    try {
      Database? mydb = await db;

      List<Map<String, dynamic>> maps =
          await mydb!.query(ReceiptsModel.ReceiptsModelName,
              columns: [
                ReceiptsModel.columnId,
                ReceiptsModel.columnAmount,
                ReceiptsModel.columnBillId,
                ReceiptsModel.columnName,
                ReceiptsModel.columnQuantity,
                ReceiptsModel.columnUnitPrice
              ],
              where: '${ReceiptsModel.columnId} = ?',
              whereArgs: [id]);
      if (maps.isNotEmpty) {
        return ReceiptsModel.fromJson(maps.first);
      }
    } catch (e) {
      print(e);
    }
  }

  deleteReceiptsModel(var id) async {
    try {
      Database? mydb = await db;

      return await mydb!.delete(ReceiptsModel.ReceiptsModelName,
          where: '${ReceiptsModel.columnId} = ?', whereArgs: [id]);
    } catch (e) {
      print(e);
    }
  }

  deleteAllReceiptsModel() async {
    try {
      Database? mydb = await db;

      for (var element in receiptsModels) {
        mydb!.delete(ReceiptsModel.ReceiptsModelName,
            where: '${ReceiptsModel.columnId} = ?', whereArgs: [element.id]);
      }
    } catch (e) {
      print(e);
    }
  }

  updateReceiptsModel(ReceiptsModel item) async {
    try {
      Database? mydb = await db;

      return await mydb!.update(ReceiptsModel.ReceiptsModelName, item.toJson(),
          where: '${ReceiptsModel.columnId} = ?', whereArgs: [item.id]);
    } catch (e) {
      print(e);
    }
  }

  List<ReceiptsModel> receiptsModels = [];
  getAllReceiptsTable() async {
    try {
      receiptsModels = [];
      List<Map<String, dynamic>> data =
          await readData("SELECT * FROM '${ReceiptsModel.ReceiptsModelName}' ");

      for (var element in data) {
        receiptsModels.add(ReceiptsModel.fromJson(element));
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  //------------------------------------------------------------------
  // Todo Unit Table
  createUnitTable(Database db) async {
    await db.execute('''
    CREATE TABLE "${UnitModel.UnitModelName}" (
      "${UnitModel.columnId}" INTEGER NOT NULL PRIMARY KEY , 
      "${UnitModel.columnCompanyId}" INTEGER ,      
      "${UnitModel.columnIsActive}" INTEGER ,
      "${UnitModel.columnName}" TEXT
    )
    ''');
  }

  insertUnitTable(UnitModel item) async {
    try {
      await insertData('''
          INSERT INTO 
          '${UnitModel.UnitModelName}'
          ('${UnitModel.columnId}',
          '${UnitModel.columnCompanyId}',
          '${UnitModel.columnIsActive}',
          '${UnitModel.columnName}')
          VALUES (
            '${item.id}',
          '${item.companyId}',
          '${item.isActive! ? 1 : 0}',
          '${item.nameUnit}'        
          ) 
          ''');
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  getUnitModelById(var id) async {
    try {
      Database? mydb = await db;

      List<Map<String, dynamic>> maps =
          await mydb!.query(UnitModel.UnitModelName,
              columns: [
                UnitModel.columnId,
                UnitModel.columnCompanyId,
                UnitModel.columnIsActive,
                UnitModel.columnName,
              ],
              where: '${UnitModel.columnId} = ?',
              whereArgs: [id]);
      if (maps.isNotEmpty) {
        return UnitModel.fromJsonEdit(maps.first);
      }
    } catch (e) {
      print(e);
    }
  }

  deleteUnitModel(var id) async {
    try {
      Database? mydb = await db;

      return await mydb!.delete(UnitModel.UnitModelName,
          where: '${UnitModel.columnId} = ?', whereArgs: [id]);
    } catch (e) {
      print(e);
    }
  }

  deleteAllUnitModel() async {
    try {
      Database? mydb = await db;

      for (var element in unitModels) {
        mydb!.delete(UnitModel.UnitModelName,
            where: '${UnitModel.columnId} = ?', whereArgs: [element.id]);
      }
    } catch (e) {
      print(e);
    }
  }

  updateUnitModel(UnitModel item) async {
    try {
      Database? mydb = await db;

      return await mydb!.update(UnitModel.UnitModelName, item.toJson(),
          where: '${UnitModel.columnId} = ?', whereArgs: [item.id]);
    } catch (e) {
      print(e);
    }
  }

  List<UnitModel> unitModels = [];
  getAllUnitTable() async {
    try {
      unitModels = [];
      List<Map<String, dynamic>> data =
          await readData("SELECT * FROM '${UnitModel.UnitModelName}' ");

      for (var element in data) {
        unitModels.add(UnitModel.fromJsonEdit(element));
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  //------------------------------------------------------------------
  // Todo Category Table
  createCategoryTable(Database db) async {
    await db.execute('''
    CREATE TABLE "${CategoryModel.CategoryModelName}" (
      "${CategoryModel.columnId}" INTEGER NOT NULL PRIMARY KEY , 
      "${CategoryModel.columnCompanyId}" INTEGER ,      
      "${CategoryModel.columnIsActive}" INTEGER ,
      "${CategoryModel.columnName}" TEXT ,
      "${CategoryModel.columnDescription}" TEXT
    )
    ''');
  }

  insertCategoryTable(CategoryModel item) async {
    try {
      await insertData('''
          INSERT INTO 
          '${CategoryModel.CategoryModelName}'
          ('${CategoryModel.columnId}',
          '${CategoryModel.columnCompanyId}',
          '${CategoryModel.columnIsActive}',
          '${CategoryModel.columnDescription}',
          '${CategoryModel.columnName}')
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

  getCategoryModelById(var id) async {
    try {
      Database? mydb = await db;

      List<Map<String, dynamic>> maps =
          await mydb!.query(CategoryModel.CategoryModelName,
              columns: [
                CategoryModel.columnId,
                CategoryModel.columnCompanyId,
                CategoryModel.columnIsActive,
                CategoryModel.columnDescription,
                CategoryModel.columnName,
              ],
              where: '${CategoryModel.columnId} = ?',
              whereArgs: [id]);
      if (maps.isNotEmpty) {
        return CategoryModel.fromJsonEdit(maps.first);
      }
    } catch (e) {
      print(e);
    }
  }

  deleteCategoryModel(var id) async {
    try {
      Database? mydb = await db;

      return await mydb!.delete(CategoryModel.CategoryModelName,
          where: '${CategoryModel.columnId} = ?', whereArgs: [id]);
    } catch (e) {
      print(e);
    }
  }

  deleteAllCategoryModel() async {
    try {
      Database? mydb = await db;

      for (var element in categoryModels) {
        mydb!.delete(CategoryModel.CategoryModelName,
            where: '${CategoryModel.columnId} = ?', whereArgs: [element.id]);
      }
    } catch (e) {
      print(e);
    }
  }

  updateCategoryModel(CategoryModel item) async {
    try {
      Database? mydb = await db;

      return await mydb!.update(CategoryModel.CategoryModelName, item.toJson(),
          where: '${CategoryModel.columnId} = ?', whereArgs: [item.id]);
    } catch (e) {
      print(e);
    }
  }

  List<CategoryModel> categoryModels = [];
  getAllCategoryTable() async {
    try {
      categoryModels = [];
      List<Map<String, dynamic>> data =
          await readData("SELECT * FROM '${CategoryModel.CategoryModelName}' ");

      for (var element in data) {
        categoryModels.add(CategoryModel.fromJsonEdit(element));
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  //------------------------------------------------------------------
  // Todo BranchProduct Table
  createBranchProductTable(Database db) async {
    await db.execute('''
    CREATE TABLE "${BranchProductModel.BranchProductModelName}" (
      "${BranchProductModel.columnId}" INTEGER NOT NULL PRIMARY KEY , 
      "${BranchProductModel.columnProductId}" TEXT ,      
      "${BranchProductModel.columnQuantity}" INTEGER ,
      "${BranchProductModel.columnBranchId}" INTEGER
    )
    ''');
  }

  insertBranchProductTable(BranchProductModel item) async {
    try {
      await insertData('''
          INSERT INTO 
          '${BranchProductModel.BranchProductModelName}'
          ('${BranchProductModel.columnId}',
          '${BranchProductModel.columnBranchId}',
          '${BranchProductModel.columnProductId}',
          '${BranchProductModel.columnQuantity}')
          VALUES (
            '${item.id}',
          '${item.branchId}',
          '${item.productId}',
          '${item.quantity}'    
          ) 
          ''');
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  getBranchProductModelById(var id) async {
    try {
      Database? mydb = await db;

      List<Map<String, dynamic>> maps =
          await mydb!.query(BranchProductModel.BranchProductModelName,
              columns: [
                BranchProductModel.columnId,
                BranchProductModel.columnBranchId,
                BranchProductModel.columnProductId,
                BranchProductModel.columnQuantity,
              ],
              where: '${BranchProductModel.columnId} = ?',
              whereArgs: [id]);
      if (maps.isNotEmpty) {
        return BranchProductModel.fromJson(maps.first);
      }
    } catch (e) {
      print(e);
    }
  }

  deleteBranchProductModel(var id) async {
    try {
      Database? mydb = await db;

      return await mydb!.delete(BranchProductModel.BranchProductModelName,
          where: '${BranchProductModel.columnId} = ?', whereArgs: [id]);
    } catch (e) {
      print(e);
    }
  }

  deleteAllBranchProductModel() async {
    try {
      Database? mydb = await db;

      for (var element in branchProductModels) {
        mydb!.delete(BranchProductModel.BranchProductModelName,
            where: '${BranchProductModel.columnId} = ?',
            whereArgs: [element.id]);
      }
    } catch (e) {
      print(e);
    }
  }

  updateBranchProductModel(BranchProductModel item) async {
    try {
      Database? mydb = await db;

      return await mydb!.update(
          BranchProductModel.BranchProductModelName, item.toJson(),
          where: '${BranchProductModel.columnId} = ?', whereArgs: [item.id]);
    } catch (e) {
      print(e);
    }
  }

  List<BranchProductModel> branchProductModels = [];
  getAllBranchProductTable() async {
    try {
      branchProductModels = [];
      List<Map<String, dynamic>> data = await readData(
          "SELECT * FROM '${BranchProductModel.BranchProductModelName}' ");

      for (var element in data) {
        branchProductModels.add(BranchProductModel.fromJson(element));
      }
    } catch (e) {
      print(e);
    }
  }

  //------------------------------------------------------------------
  // Todo Branch Table
  createBranchTable(Database db) async {
    await db.execute('''
    CREATE TABLE "${BranchModel.BranchModelName}" (
      "${BranchModel.columnId}" INTEGER NOT NULL PRIMARY KEY , 
      "${BranchModel.columnName}" TEXT ,
      "${BranchModel.columnPhone}" TEXT ,
      "${BranchModel.columnAddress}" TEXT ,
      "${BranchModel.columnEmail}" TEXT ,
      "${BranchModel.columnPassword}" TEXT ,
      "${BranchModel.columnPasswordSalt}" TEXT ,
      "${BranchModel.columnIsComfirmed}" INTEGER ,      
      "${BranchModel.columnCompID}" INTEGER
    )
    ''');
  }

  insertBranchTable(BranchModel item) async {
    try {
      await insertData('''
          INSERT INTO 
          '${BranchModel.BranchModelName}'
          ('${BranchModel.columnId}',
          '${BranchModel.columnAddress}',
          '${BranchModel.columnCompID}',
          '${BranchModel.columnIsComfirmed}',
          '${BranchModel.columnName}',
          '${BranchModel.columnPassword}',
          '${BranchModel.columnPasswordSalt}',
          '${BranchModel.columnPhone}',
          '${BranchModel.columnEmail}')
          VALUES (
            '${item.id}',
          '${item.address}',
          '${item.compID}',
          '${item.isComfirmed! ? 1 : 0}',
          '${item.name}',
          '${item.password}',
          '${item.passwordSalt}',
          '${item.phone}',
          '${item.email}'    
          ) 
          ''');
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  getBranchModelById(var id) async {
    try {
      Database? mydb = await db;

      List<Map<String, dynamic>> maps =
          await mydb!.query(BranchModel.BranchModelName,
              columns: [
                BranchModel.columnId,
                BranchModel.columnAddress,
                BranchModel.columnCompID,
                BranchModel.columnIsComfirmed,
                BranchModel.columnName,
                BranchModel.columnPassword,
                BranchModel.columnPasswordSalt,
                BranchModel.columnPhone,
                BranchModel.columnEmail,
              ],
              where: '${BranchModel.columnId} = ?',
              whereArgs: [id]);
      if (maps.isNotEmpty) {
        return BranchModel.fromJsonEdit(maps.first);
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  deleteBranchModel(var id) async {
    try {
      Database? mydb = await db;

      return await mydb!.delete(BranchModel.BranchModelName,
          where: '${BranchModel.columnId} = ?', whereArgs: [id]);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  deleteAllBranchModel() async {
    try {
      Database? mydb = await db;

      for (var element in branchModels) {
        mydb!.delete(BranchModel.BranchModelName,
            where: '${BranchModel.columnId} = ?', whereArgs: [element.id]);
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  updateBranchModel(BranchModel item) async {
    try {
      Database? mydb = await db;

      return await mydb!.update(BranchModel.BranchModelName, item.toJson(),
          where: '${BranchModel.columnId} = ?', whereArgs: [item.id]);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  List<BranchModel> branchModels = [];
  getAllBranchTable() async {
    try {
      branchModels = [];
      List<Map<String, dynamic>> data =
          await readData("SELECT * FROM '${BranchModel.BranchModelName}' ");

      for (var element in data) {
        branchModels.add(BranchModel.fromJsonEdit(element));
      }
    } catch (e) {
      print(e);
    }
  }

  //------------------------------------------------------------------
  // Todo Order Table
  createOrderTable(Database db) async {
    await db.execute('''
    CREATE TABLE "${OrderModel.OrderModelName}" (
      "${OrderModel.columnId}" TEXT NOT NULL PRIMARY KEY , 
      "${OrderModel.columnClientID}" INTEGER ,
      "${OrderModel.columnPayTypeID}" INTEGER ,
      "${OrderModel.columnEmpID}" INTEGER ,
      "${OrderModel.columnIsPayCash}" INTEGER ,
      "${OrderModel.columnCreateDate}" TEXT ,
      "${OrderModel.columnUpdateDate}" TEXT ,
      "${OrderModel.columnDiscount}" REAL ,
      "${OrderModel.columnTotalCost}" REAL ,
      "${OrderModel.columnTaxes}" REAL ,
      "${OrderModel.columnCostNet}" REAL ,
      "${OrderModel.columnDebitPay}" REAL ,
      "${OrderModel.columnPayAmount}" REAL ,
      "${OrderModel.columnQrcode}" TEXT ,
      "${OrderModel.columnIsReturn}" INTEGER ,
      "${OrderModel.columnReturnDesc}" TEXT
    )
    ''');
  }

  insertOrderTable(OrderModel item) async {
    try {
      await insertData('''
          INSERT INTO 
          '${OrderModel.OrderModelName}'
          ('${OrderModel.columnId}',
          '${OrderModel.columnClientID}',
          '${OrderModel.columnPayTypeID}',
          '${OrderModel.columnEmpID}',
          '${OrderModel.columnIsPayCash}',
          '${OrderModel.columnCreateDate}',
          '${OrderModel.columnUpdateDate}',
          '${OrderModel.columnDiscount}',
          '${OrderModel.columnTotalCost}',
          '${OrderModel.columnTaxes}',
          '${OrderModel.columnCostNet}',
          '${OrderModel.columnDebitPay}',
          '${OrderModel.columnPayAmount}',
          '${OrderModel.columnQrcode}',
          '${OrderModel.columnIsReturn}',
          '${OrderModel.columnReturnDesc}')
          VALUES (
            '${item.id}',
          '${item.clientID}',
          '${item.payTypeID}',
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
          '${item.returnDesc}'
          ) 
          ''');
    } catch (e) {
      print(e);
    }
  }

  getOrderModelById(var id) async {
    try {
      Database? mydb = await db;

      List<Map<String, dynamic>> maps =
          await mydb!.query(OrderModel.OrderModelName,
              columns: [
                OrderModel.columnId,
                OrderModel.columnClientID,
                OrderModel.columnPayTypeID,
                OrderModel.columnEmpID,
                OrderModel.columnIsPayCash,
                OrderModel.columnCreateDate,
                OrderModel.columnUpdateDate,
                OrderModel.columnDiscount,
                OrderModel.columnTotalCost,
                OrderModel.columnTaxes,
                OrderModel.columnCostNet,
                OrderModel.columnDebitPay,
                OrderModel.columnPayAmount,
                OrderModel.columnQrcode,
                OrderModel.columnIsReturn,
                OrderModel.columnReturnDesc,
              ],
              where: '${OrderModel.columnId} = ?',
              whereArgs: [id]);
      if (maps.isNotEmpty) {
        return OrderModel.fromJsonEdit(maps.first);
      }
    } catch (e) {
      print(e);
    }
  }

  deleteOrderModel(var id) async {
    try {
      Database? mydb = await db;

      return await mydb!.delete(OrderModel.OrderModelName,
          where: '${OrderModel.columnId} = ?', whereArgs: [id]);
    } catch (e) {
      print(e);
    }
  }

  deleteAllOrderModel() async {
    try {
      Database? mydb = await db;

      for (var element in orderModels) {
        mydb!.delete(OrderModel.OrderModelName,
            where: '${OrderModel.columnId} = ?', whereArgs: [element.id]);
      }
    } catch (e) {
      print(e);
    }
  }

  updateOrderModel(OrderModel item) async {
    try {
      Database? mydb = await db;

      return await mydb!.update(OrderModel.OrderModelName, item.toJson(),
          where: '${OrderModel.columnId} = ?', whereArgs: [item.id]);
    } catch (e) {
      print(e);
    }
  }

  List<OrderModel> orderModels = [];
  getAllOrderTable() async {
    try {
      orderModels = [];
      List<Map<String, dynamic>> data =
          await readData("SELECT * FROM '${OrderModel.OrderModelName}' ");

      for (var element in data) {
        orderModels.add(OrderModel.fromJsonEdit(element));
      }
    } catch (e) {
      print(e);
    }
  }

  //------------------------------------------------------------------
  // Todo Product Table
  createProductTable(Database db) async {
    await db.execute('''
    CREATE TABLE "${ProductModel.ProductModelName}" (
      "${ProductModel.columnId}" TEXT NOT NULL PRIMARY KEY , 
      "${ProductModel.columnName}" TEXT ,
      "${ProductModel.columnBuyingPrice}" REAL ,
      "${ProductModel.columnUnitPackage}" INTEGER ,
      "${ProductModel.columnUnitID}" INTEGER ,
      "${ProductModel.columnStockQuantity}" INTEGER ,
      "${ProductModel.columnQrCode}" TEXT ,
      "${ProductModel.columnCreateDate}" TEXT ,
      "${ProductModel.columnUpdateDate}" TEXT ,
      "${ProductModel.columnImage}" TEXT ,
      "${ProductModel.columnDiscount}" REAL ,
      "${ProductModel.columnExpirationDate}" TEXT ,
      "${ProductModel.columnProductNumber}" TEXT ,
      "${ProductModel.columnCatID}" INTEGER ,
      "${ProductModel.columnCompID}" INTEGER ,
      "${ProductModel.columnIsPetrolGas}" INTEGER ,
      "${ProductModel.columnPriceOne}" REAL ,
      "${ProductModel.columnPriceThree}" REAL ,
      "${ProductModel.columnPriceTwo}" REAL ,
      "${ProductModel.columnDescription}" TEXT ,
      "${ProductModel.columnIsActive}" INTEGER
    )
    ''');
  }

  insertProductTable(ProductModel item) async {
    try {
      await insertData('''
          INSERT INTO 
          '${ProductModel.ProductModelName}'
          ('${ProductModel.columnId}',
          '${ProductModel.columnName}',
          '${ProductModel.columnBuyingPrice}',
          '${ProductModel.columnUnitPackage}',
          '${ProductModel.columnUnitID}',
          '${ProductModel.columnCreateDate}',
          '${ProductModel.columnUpdateDate}',
          '${ProductModel.columnDiscount}',
          '${ProductModel.columnStockQuantity}',
          '${ProductModel.columnQrCode}',
          '${ProductModel.columnImage}',
          '${ProductModel.columnExpirationDate}',
          '${ProductModel.columnProductNumber}',
          '${ProductModel.columnCatID}',
          '${ProductModel.columnCompID}',
          '${ProductModel.columnPriceOne}',
          '${ProductModel.columnPriceThree}',
          '${ProductModel.columnPriceTwo}',
          '${ProductModel.columnDescription}',
          '${ProductModel.columnIsActive}',
          '${ProductModel.columnIsPetrolGas}')
          VALUES (
            '${item.prodId}',
          '${item.name}',
          '${item.buyingPrice}',
          '${item.unitPackage}',
          '${item.isActive! ? 1 : 0}',
          '${item.isPetrolGas! ? 1 : 0}',
          '${item.createDate}',
          '${item.updateDate}',
          '${item.discount}',
          '${item.unitID}',
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
          '${item.description}'
          ) 
          ''');
    } catch (e) {
      print(e);
    }
  }

  getProductModelById(var id) async {
    try {
      Database? mydb = await db;

      List<Map<String, dynamic>> maps =
          await mydb!.query(ProductModel.ProductModelName,
              columns: [
                ProductModel.columnId,
                ProductModel.columnName,
                ProductModel.columnBuyingPrice,
                ProductModel.columnUnitPackage,
                ProductModel.columnUnitID,
                ProductModel.columnCreateDate,
                ProductModel.columnUpdateDate,
                ProductModel.columnDiscount,
                ProductModel.columnStockQuantity,
                ProductModel.columnQrCode,
                ProductModel.columnImage,
                ProductModel.columnExpirationDate,
                ProductModel.columnProductNumber,
                ProductModel.columnCatID,
                ProductModel.columnCompID,
                ProductModel.columnPriceOne,
                ProductModel.columnPriceThree,
                ProductModel.columnPriceTwo,
                ProductModel.columnDescription,
                ProductModel.columnIsActive,
                ProductModel.columnIsPetrolGas,
              ],
              where: '${ProductModel.columnId} = ?',
              whereArgs: [id]);
      if (maps.isNotEmpty) {
        return ProductModel.fromJsonEdit(maps.first);
      }
    } catch (e) {
      print(e);
    }
  }

  deleteProductModel(var id) async {
    try {
      Database? mydb = await db;

      return await mydb!.delete(ProductModel.ProductModelName,
          where: '${ProductModel.columnId} = ?', whereArgs: [id]);
    } catch (e) {
      print(e);
    }
  }

  deleteAllProductModel() async {
    try {
      Database? mydb = await db;

      for (var element in productModels) {
        mydb!.delete(ProductModel.ProductModelName,
            where: '${ProductModel.columnId} = ?', whereArgs: [element.prodId]);
      }
    } catch (e) {
      print(e);
    }
  }

  updateProductModel(ProductModel item) async {
    try {
      Database? mydb = await db;

      return await mydb!.update(ProductModel.ProductModelName, item.toJson(),
          where: '${ProductModel.columnId} = ?', whereArgs: [item.prodId]);
    } catch (e) {
      print(e);
    }
  }

  List<ProductModel> productModels = [];
  getAllProductTable() async {
    try {
      productModels = [];
      List<Map<String, dynamic>> data =
          await readData("SELECT * FROM '${ProductModel.ProductModelName}' ");

      for (var element in data) {
        productModels.add(ProductModel.fromJsonEdit(element));
      }
    } catch (e) {
      print(e);
    }
  }

  //------------------------------------------------------------------
  // Todo Client Table
  createClientTable(Database db) async {
    await db.execute('''
    CREATE TABLE "${ClientModel.ClientModelName}" (
      "${ClientModel.columnId}" TEXT NOT NULL PRIMARY KEY , 
      "${ClientModel.columnName}" TEXT ,
      "${ClientModel.columnPhone}" TEXT ,
      "${ClientModel.columnAddress}" TEXT ,
      "${ClientModel.columnLoacation}" TEXT ,
      "${ClientModel.columnComment}" TEXT ,
      "${ClientModel.columnTaxNumber}" TEXT ,
      "${ClientModel.columnCreateDate}" TEXT ,
      "${ClientModel.columnUpdateDate}" TEXT ,
      "${ClientModel.columnAmmountTobePaid}" REAL ,
      "${ClientModel.columnMaxDebitLimit}" REAL ,
      "${ClientModel.columnMaxLimtDebitRecietCount}" REAL ,
      "${ClientModel.columnCompanyId}" INTEGER ,
      "${ClientModel.columnEmpID}" INTEGER ,
      "${ClientModel.columnIsActive}" INTEGER
    )
    ''');
  }

  insertClientTable(ClientModel item) async {
    try {
      await insertData('''
          INSERT INTO 
          '${ClientModel.ClientModelName}'
          ('${ClientModel.columnId}',
          '${ClientModel.columnName}',
          '${ClientModel.columnPhone}',
          '${ClientModel.columnLoacation}',
          '${ClientModel.columnComment}',
          '${ClientModel.columnTaxNumber}',
          '${ClientModel.columnCreateDate}',
          '${ClientModel.columnUpdateDate}',          
          '${ClientModel.columnAmmountTobePaid}',          
          '${ClientModel.columnMaxDebitLimit}',          
          '${ClientModel.columnMaxLimtDebitRecietCount}',          
          '${ClientModel.columnEmpID}',          
          '${ClientModel.columnCompanyId}',          
          '${ClientModel.columnIsActive}',
          '${ClientModel.columnAddress}')
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
          '${item.address}'
          ) 
          ''');
    } catch (e) {
      print(e);
    }
  }

  getClientModelById(var id) async {
    try {
      Database? mydb = await db;

      List<Map<String, dynamic>> maps =
          await mydb!.query(ClientModel.ClientModelName,
              columns: [
                ClientModel.columnId,
                ClientModel.columnName,
                ClientModel.columnPhone,
                ClientModel.columnLoacation,
                ClientModel.columnComment,
                ClientModel.columnTaxNumber,
                ClientModel.columnCreateDate,
                ClientModel.columnUpdateDate,
                ClientModel.columnAmmountTobePaid,
                ClientModel.columnMaxDebitLimit,
                ClientModel.columnMaxLimtDebitRecietCount,
                ClientModel.columnEmpID,
                ClientModel.columnCompanyId,
                ClientModel.columnIsActive,
                ClientModel.columnAddress
              ],
              where: '${ClientModel.columnId} = ?',
              whereArgs: [id]);
      if (maps.isNotEmpty) {
        return ClientModel.fromJsonEdit(maps.first);
      }
    } catch (e) {
      print(e);
    }
  }

  deleteClientModel(var id) async {
    try {
      Database? mydb = await db;

      return await mydb!.delete(ClientModel.ClientModelName,
          where: '${ClientModel.columnId} = ?', whereArgs: [id]);
    } catch (e) {
      print(e);
    }
  }

  deleteAllClientModel() async {
    try {
      Database? mydb = await db;

      for (var element in clientModels) {
        mydb!.delete(ClientModel.ClientModelName,
            where: '${ClientModel.columnId} = ?', whereArgs: [element.id]);
      }
    } catch (e) {
      print(e);
    }
  }

  updateClientModel(ClientModel item) async {
    try {
      Database? mydb = await db;

      return await mydb!.update(ClientModel.ClientModelName, item.toJson(),
          where: '${ClientModel.columnId} = ?', whereArgs: [item.id]);
    } catch (e) {
      print(e);
    }
  }

  List<ClientModel> clientModels = [];
  getAllClientTable() async {
    emit(GetAllClientTableLoading());
    try {
      clientModels = [];
      List<Map<String, dynamic>> data =
          await readData("SELECT * FROM '${ClientModel.ClientModelName}' ");

      for (var element in data) {
        clientModels.add(ClientModel.fromJsonEdit(element));
      }
      emit(GetAllClientTableSuccess());
    } catch (e) {
      print(e);
      emit(GetAllClientTableError());
    }
  }

  //------------------------------------------------------------------
  // Todo Bill Table
  createBillTable(Database db) async {
    await db.execute('''
    CREATE TABLE "${BillModel.billModelName}" (
      "${BillModel.columnId}" TEXT NOT NULL PRIMARY KEY ,
      "${BillModel.columnName}" TEXT ,
      "${BillModel.columnPhone}" TEXT ,
      "${BillModel.columnAddress}" TEXT ,
      "${BillModel.columnComment}" TEXT ,
      "${BillModel.columnEmail}" TEXT ,
      "${BillModel.columnCode}" TEXT ,
      "${BillModel.columnLable}" TEXT ,
      "${BillModel.columnCreateDate}" TEXT ,
      "${BillModel.columnInvoiceDate}" TEXT ,
      "${BillModel.columnTotal}" REAL ,
      "${BillModel.columnCompID}" INTEGER
    )
    ''');
  }

  insertBillTable(BillModel item) async {
    try {
      await insertData('''
          INSERT INTO 
          '${BillModel.billModelName}'
          ('${BillModel.columnId}',
          '${BillModel.columnName}',
          '${BillModel.columnPhone}',
          '${BillModel.columnEmail}',
          '${BillModel.columnComment}',
          '${BillModel.columnCode}',
          '${BillModel.columnLable}',          
          '${BillModel.columnCreateDate}',          
          '${BillModel.columnInvoiceDate}',          
          '${BillModel.columnTotal}',          
          '${BillModel.columnCompID}',          
          '${BillModel.columnAddress}')
          VALUES (
            '${item.id}',
          '${item.name}',
          '${item.phone}',
          '${item.email}',
          '${item.comment}',
          '${item.code}',
          '${item.lable}',
          '${item.createDate}',
          '${item.invoiceDate}',
          '${item.total}',
          '${item.compID}',
          '${item.address}'
          ) 
          ''');
    } catch (e) {
      print(e);
    }
  }

  getBillModelById(var id) async {
    try {
      Database? mydb = await db;

      List<Map<String, dynamic>> maps =
          await mydb!.query(BillModel.billModelName,
              columns: [
                BillModel.columnId,
                BillModel.columnAddress,
                BillModel.columnCode,
                BillModel.columnComment,
                BillModel.columnCompID,
                BillModel.columnCreateDate,
                BillModel.columnEmail,
                BillModel.columnInvoiceDate,
                BillModel.columnLable,
                BillModel.columnName,
                BillModel.columnPhone,
                BillModel.columnTotal,
              ],
              where: '${BillModel.columnId} = ?',
              whereArgs: [id]);
      if (maps.isNotEmpty) {
        return BillModel.fromJson(maps.first);
      }
    } catch (e) {
      print(e);
    }
  }

  deleteBillModel(var id) async {
    try {
      Database? mydb = await db;

      return await mydb!.delete(BillModel.billModelName,
          where: '${BillModel.columnId} = ?', whereArgs: [id]);
    } catch (e) {
      print(e);
    }
  }

  deleteAllBillModel() async {
    try {
      Database? mydb = await db;

      for (var element in billModels) {
        mydb!.delete(BillModel.billModelName,
            where: '${BillModel.columnId} = ?', whereArgs: [element.id]);
      }
    } catch (e) {
      print(e);
    }
  }

  updateBillModel(BillModel item) async {
    try {
      Database? mydb = await db;

      return await mydb!.update(BillModel.billModelName, item.toJson(),
          where: '${BillModel.columnId} = ?', whereArgs: [item.id]);
    } catch (e) {
      print(e);
    }
  }

  List<BillModel> billModels = [];
  getAllBillTable() async {
    try {
      billModels = [];
      List<Map<String, dynamic>> data =
          await readData("SELECT * FROM '${BillModel.billModelName}' ");

      for (var element in data) {
        billModels.add(BillModel.fromJson(element));
      }
    } catch (e) {
      print(e);
    }
  }

  // List<Map> response =
  // await sqlDb.readData("SELECT * FROM 'notes' ");
  readData(String sql) async {
    Database? mydb = await db;
    List<Map> response = await mydb!.rawQuery(sql);
    return response;
  }

  // int response = await sqlDb.insertData(
  // "INSERT INTO 'notes' ('note') VALUES ('note one') ");
  insertData(String sql) async {
    Database? mydb = await db;
    int response = await mydb!.rawInsert(sql);
    return response;
  }

// Future<Todo> getTodo(int id) async {
//     List<Map> maps = await db.query(tableTodo,
//         columns: [columnId, columnDone, columnTitle],
//         where: '$columnId = ?',
//         whereArgs: [id]);
//     if (maps.length > 0) {
//       return Todo.fromMap(maps.first);
//     }
//     return null;
//   }
  // Future<int> delete(int id) async {
  //   return await db.delete(tableTodo, where: '$columnId = ?', whereArgs: [id]);
  // }
  // Future<int> update(Todo todo) async {
  //   return await db.update(tableTodo, todo.toMap(),
  //       where: '$columnId = ?', whereArgs: [todo.id]);
  // }

  // int response = await sqlDb.updateData(
  // "UPDATE 'notes' SET 'note' = 'note four' WHERE id = 4 ");
  updateData(String sql) async {
    Database? mydb = await db;
    int response = await mydb!.rawUpdate(sql);
    return response;
  }

  // int response =
  // await sqlDb.deleteData("DELETE FROM 'notes' WHERE id = 3 ");
  deleteData(String sql) async {
    Database? mydb = await db;
    int response = await mydb!.rawDelete(sql);
    return response;
  }
}
