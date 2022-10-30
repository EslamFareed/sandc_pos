import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';
import 'package:sandc_pos/online_models/company_info_response_model.dart';
import 'package:sandc_pos/online_models/product_response_model.dart';

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

  //todo save offline all data
  saveAllDataToOffline() {}

  getAllDataForFirstTime(BuildContext context) async {
    emit(GetDataOnlineLoadingState());
    try {
      await getAllClients(context);
      await getAllProducts(context);
      await getAllPayTypes(context);
      await getAllCategories(context);
      await getAllOrders(context);
      await getAllDebitPayings(context);
      await getCompanyInfo(context);
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
        } else {
          emit(GetDataOnlineErrorState());
          if (kDebugMode) {
            print(value.data.toString());
          }
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
            print("onlineCompanyInfo : ${value.data}");
          }
        } else {
          emit(GetDataOnlineErrorState());
          if (kDebugMode) {
            print(value.data.toString());
          }
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
