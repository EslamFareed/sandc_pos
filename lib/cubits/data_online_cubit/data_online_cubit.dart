import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:sandc_pos/cubits/data_cubit/data_cubit.dart';
import 'package:sandc_pos/online_models/company_info_response_model.dart';
import 'package:sandc_pos/online_models/product_response_model.dart';
import 'package:sandc_pos/reposetories/shared_pref/cache_helper.dart';

import '../../online_models/category_response_model.dart';
import '../../online_models/client_response_model.dart';
import '../../online_models/debit_paying_response_model.dart';
import '../../online_models/order_response_model.dart';
import '../../online_models/pay_type_response_model.dart';
import '../../reposetories/remote/dio/dio_helper.dart';
import '../../reposetories/remote/dio/end_points.dart';

part 'data_online_state.dart';

class DataOnlineCubit extends Cubit<DataOnlineState> {
  DataOnlineCubit() : super(DataOnlineInitial());

  static DataOnlineCubit get(context) => BlocProvider.of(context);

  //! Make Sure if data is up to date
  checkIfDataUptodate(BuildContext context) async {
    await insertClients(DataCubit.get(context)
        .clientModels
        .where((element) => !element.offlineDatabase!)
        .toList());

    await updateClients(DataCubit.get(context)
        .clientModels
        .where((element) => !element.updateDataBase!)
        .toList());

    await insertOrders(DataCubit.get(context)
        .orderModels
        .where((element) => !element.offlineDatabase!)
        .toList());

    await insertOrdersDetails(DataCubit.get(context)
        .invoiceDetailsModels
        .where((element) => !element.offlineDatabase!)
        .toList());

    await getAllDataForFirstTime(context);
  }

  //? Get All Data Offline
  getAllOfflineData(BuildContext context) async {
    emit(GetAllDataOfflineLoading());
    try {
      await DataCubit.get(context).getAllCategoryTable();
      await DataCubit.get(context).getAllClientTable();
      await DataCubit.get(context).getAllCompanyTable();
      await DataCubit.get(context).getAllDebitPayingsTable();
      await DataCubit.get(context).getAllInvoiceDetailsTable();
      await DataCubit.get(context).getAllOrderTable();
      await DataCubit.get(context).getAllPayTypeTable();
      await DataCubit.get(context).getAllProductTable();
      emit(GetAllDataOfflineSuccess());
    } catch (e) {
      emit(GetAllDataOfflineError());
      if (kDebugMode) {
        print(e);
      }
    }
  }

  //todo save offline all data
  saveAllDataToOffline() {}

  insertOrdersDetails(List<GetInVoiceDetails> items) async {
    if (items.isNotEmpty) {
      try {
        List<Map> data = [];

        for (var element in items) {
          element.offlineDatabase = true;
          element.updateDataBase = true;
          data.add(element.toJson());
        }
        await DioHelper.postListDataWithToken(
                url: ADD_ORDER_DETAILS, data: items)
            .then((value) {
          if (value.statusCode == 200) {
            if (kDebugMode) {
              print(
                  "success adding ${items.length} items in order details ---------------------------------------");
            }
          } else {
            if (kDebugMode) {
              print(value.data);
            }
          }
        }).catchError((onError) {
          if (kDebugMode) {
            print(onError.toString());
          }
        });
      } catch (e) {
        if (kDebugMode) {
          print(e.toString());
        }
      }
    }
  }

  insertOrders(List<OrderResponseModel> items) async {
    if (items.isNotEmpty) {
      try {
        List<Map> data = [];
        for (var element in items) {
          element.offlineDatabase = true;
          element.updateDataBase = true;
          data.add(element.toJson());
        }
        await DioHelper.postListDataWithToken(url: ADD_ORDER, data: data)
            .then((value) {
          if (value.statusCode == 200) {
            if (kDebugMode) {
              print(
                  "success adding ${items.length} items in orders ---------------------------------------");
            }
          } else {
            if (kDebugMode) {
              print(value.data);
            }
          }
        }).catchError((onError) {
          if (kDebugMode) {
            print(onError.toString());
          }
        });
      } catch (e) {
        if (kDebugMode) {
          print(e.toString());
        }
      }
    }
  }

  insertClients(List<ClientResponseModel> items) async {
    if (items.isNotEmpty) {
      try {
        List<Map> data = [];

        for (var element in items) {
          element.offlineDatabase = true;
          element.updateDataBase = true;
          data.add(element.toJson());
        }
        await DioHelper.postListDataWithToken(url: ADD_CLIENT, data: data)
            .then((value) {
          if (value.statusCode == 200) {
            if (kDebugMode) {
              print(
                  "success adding ${items.length} items in clients ---------------------------------------");
            }
          } else {
            if (kDebugMode) {
              print(value.data);
            }
          }
        }).catchError((onError) {
          if (kDebugMode) {
            print(onError.toString());
          }
        });
      } catch (e) {
        if (kDebugMode) {
          print(e.toString());
        }
      }
    }
  }

  updateClients(List<ClientResponseModel> items) async {
    if (items.isNotEmpty) {
      try {
        List<Map> data = [];

        for (var element in items) {
          element.offlineDatabase = true;
          element.updateDataBase = true;
          data.add(element.toJson());
        }
        await DioHelper.postListDataWithToken(url: EDIT_CLIENT, data: data)
            .then((value) {
          if (value.statusCode == 200) {
            if (kDebugMode) {
              print(
                  "success editing ${items.length} items in clients ---------------------------------------");
            }
          } else {
            if (kDebugMode) {
              print(value.data);
            }
          }
        }).catchError((onError) {
          if (kDebugMode) {
            print(onError.toString());
          }
        });
      } catch (e) {
        if (kDebugMode) {
          print(e.toString());
        }
      }
    }
  }

  getAllDataForFirstTime(BuildContext context) async {
    emit(GetDataOnlineLoadingState());
    try {
      //? Get Online Data From Apis
      await getAllClients(context);
      await getAllProducts(context);
      await getAllPayTypes(context);
      await getAllCategories(context);
      await getAllOrders(context);
      await getAllDebitPayings(context);
      await getCompanyInfo(context);

      //? Deleta All Offline Data
      await DataCubit.get(context).deleteAllCategories();
      await DataCubit.get(context).deleteAllClients();
      await DataCubit.get(context).deleteAllCompanies();
      await DataCubit.get(context).deleteAllDebitPayings();
      await DataCubit.get(context).deleteAllInvoiceDetails();
      await DataCubit.get(context).deleteAllOrders();
      await DataCubit.get(context).deleteAllPayTypes();
      await DataCubit.get(context).deleteAllProducts();

      //? Get Offline Data From Sql
      //! Get Offline Clients
      await DataCubit.get(context).insertClientsByList(onlineClients);
      await DataCubit.get(context).getAllClientTable();
      onlineClients = [];

      //! Get Offline Products
      await DataCubit.get(context).insertProductsByList(onlineProducts);
      await DataCubit.get(context).getAllProductTable();
      onlineProducts = [];

      //! Get Offline Pay Types
      await DataCubit.get(context).insertPayTypesByList(onlinePayTypes);
      await DataCubit.get(context).getAllPayTypeTable();
      onlinePayTypes = [];

      //! Get Offline Categories
      await DataCubit.get(context).insertCategoriesByList(onlineCategories);
      await DataCubit.get(context).getAllCategoryTable();
      onlineCategories = [];

      //! Get Offline Products
      await DataCubit.get(context).insertOrdersByList(onlineOrders);
      await DataCubit.get(context).getAllOrderTable();
      await DataCubit.get(context).getAllInvoiceDetailsTable();
      onlineOrders = [];

      //! Get Offline Products
      await DataCubit.get(context).insertDebitPayingsByList(onlineDebitPayings);
      await DataCubit.get(context).getAllDebitPayingsTable();
      onlineDebitPayings = [];

      //! Get Comapny Info
      await DataCubit.get(context).insertCompanyTable(onlineCompanyInfo!);
      await DataCubit.get(context).getAllCompanyTable();
      onlineCompanyInfo = null;

      await CacheHelper.saveData(key: "isFirstTime", value: false);
      emit(GetDataOnlineSuccessState());
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      emit(GetDataOnlineErrorState());
    }
  }

  List<ClientResponseModel> onlineClients = [];
  getAllClients(BuildContext context) async {
    try {
      await DioHelper.getDataWithToken(url: GET_ALL_CLIENTS).then((value) {
        if (value.statusCode == 200) {
          for (var element in value.data) {
            onlineClients.add(ClientResponseModel.fromJson(element));
            // DataCubit.get(context).insertClientTable(item);
          }
          if (kDebugMode) {
            print("clients : ${onlineClients.length}");
          }
        } else {
          emit(GetDataOnlineErrorState());
          if (kDebugMode) {
            print(value.data.toString());
          }
        }
      }).catchError((onError) {
        emit(GetDataOnlineErrorState());

        if (kDebugMode) {
          print(onError.toString());
        }
      });
    } catch (e) {
      emit(GetDataOnlineErrorState());

      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  List<ProductResponseModel> onlineProducts = [];
  getAllProducts(BuildContext context) async {
    try {
      await DioHelper.getDataWithToken(url: GET_ALL_PRODUCTS).then((value) {
        if (value.statusCode == 200) {
          for (var element in value.data) {
            onlineProducts.add(ProductResponseModel.fromJson(element));
            // DataCubit.get(context).insertClientTable(item);
          }
          if (kDebugMode) {
            print("products : ${onlineProducts.length}");
          }
        } else {
          emit(GetDataOnlineErrorState());
          if (kDebugMode) {
            print(value.data.toString());
          }
        }
      }).catchError((onError) {
        emit(GetDataOnlineErrorState());

        if (kDebugMode) {
          print(onError.toString());
        }
      });
    } catch (e) {
      emit(GetDataOnlineErrorState());

      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  List<PayTypeResponseModel> onlinePayTypes = [];
  getAllPayTypes(BuildContext context) async {
    try {
      await DioHelper.getDataWithToken(url: GET_ALL_PAY_TYPES).then((value) {
        if (value.statusCode == 200) {
          for (var element in value.data) {
            onlinePayTypes.add(PayTypeResponseModel.fromJson(element));
            // DataCubit.get(context).insertClientTable(item);
          }
          if (kDebugMode) {
            print("onlinePayTypes : ${onlinePayTypes.length}");
          }
        } else {
          emit(GetDataOnlineErrorState());
          if (kDebugMode) {
            print(value.data.toString());
          }
        }
      }).catchError((onError) {
        emit(GetDataOnlineErrorState());

        if (kDebugMode) {
          print(onError.toString());
        }
      });
    } catch (e) {
      emit(GetDataOnlineErrorState());

      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  List<CategoryResponseModel> onlineCategories = [];
  getAllCategories(BuildContext context) async {
    try {
      await DioHelper.getDataWithToken(url: GET_ALL_CATEGORIES).then((value) {
        if (value.statusCode == 200) {
          for (var element in value.data) {
            onlineCategories.add(CategoryResponseModel.fromJson(element));
            // DataCubit.get(context).insertClientTable(item);
          }
          if (kDebugMode) {
            print("onlineCategories : ${onlineCategories.length}");
          }
        } else {
          emit(GetDataOnlineErrorState());
          if (kDebugMode) {
            print(value.data.toString());
          }
        }
      }).catchError((onError) {
        emit(GetDataOnlineErrorState());

        if (kDebugMode) {
          print(onError.toString());
        }
      });
    } catch (e) {
      emit(GetDataOnlineErrorState());

      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  List<OrderResponseModel> onlineOrders = [];
  getAllOrders(BuildContext context) async {
    try {
      await DioHelper.getDataWithToken(url: GET_ALL_ORDERS).then((value) {
        if (value.statusCode == 200) {
          for (var element in value.data) {
            onlineOrders.add(OrderResponseModel.fromJson(element));
            // DataCubit.get(context).insertClientTable(item);
          }
          if (kDebugMode) {
            print("onlineOrders : ${onlineOrders.length}");
          }
          // for (var element in onlineOrders) {
          //   element.getInVoiceDetails!.forEach((e) {
          //     print(e.offlineDatabase);
          //   });
          // }
        } else {
          emit(GetDataOnlineErrorState());
          if (kDebugMode) {
            print(value.data.toString());
          }
        }
      }).catchError((onError) {
        emit(GetDataOnlineErrorState());

        if (kDebugMode) {
          print(onError.toString());
        }
      });
    } catch (e) {
      emit(GetDataOnlineErrorState());

      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  List<DebitPayingResponseModel> onlineDebitPayings = [];
  getAllDebitPayings(BuildContext context) async {
    try {
      await DioHelper.getDataWithToken(url: GET_ALL_DEBIT_PAYINGS)
          .then((value) {
        if (value.statusCode == 200) {
          for (var element in value.data) {
            onlineDebitPayings.add(DebitPayingResponseModel.fromJson(element));
            // DataCubit.get(context).insertClientTable(item);
          }
          if (kDebugMode) {
            print("onlineDebitPayings : ${onlineDebitPayings.length}");
          }
        } else {
          emit(GetDataOnlineErrorState());
          if (kDebugMode) {
            print(value.data.toString());
          }
        }
      }).catchError((onError) {
        emit(GetDataOnlineErrorState());

        if (kDebugMode) {
          print(onError.toString());
        }
      });
    } catch (e) {
      emit(GetDataOnlineErrorState());

      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  CompanyInfoResponseModel? onlineCompanyInfo;
  getCompanyInfo(BuildContext context) async {
    try {
      await DioHelper.getDataWithToken(url: GET_INFO_COMPANY).then((value) {
        if (value.statusCode == 200) {
          onlineCompanyInfo = CompanyInfoResponseModel.fromJson(value.data);
          emit(GetDataOnlineCompanyInfoSuccessState());
          if (kDebugMode) {
            print("onlineCompanyInfo : ${onlineCompanyInfo!.companyName}");
          }
        } else {
          emit(GetDataOnlineErrorState());
          if (kDebugMode) {
            print(value.data.toString());
          }
        }
      }).catchError((onError) {
        emit(GetDataOnlineErrorState());

        if (kDebugMode) {
          print(onError.toString());
        }
      });
    } catch (e) {
      emit(GetDataOnlineErrorState());

      if (kDebugMode) {
        print(e.toString());
      }
    }
  }
}
