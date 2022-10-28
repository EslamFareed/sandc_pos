import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:sandc_pos/core/remote/dio/dio_helper.dart';
import 'package:sandc_pos/core/remote/dio/end_points.dart';
import 'package:sandc_pos/cubits/data_cubit/data_cubit.dart';

import '../../online_models/client_response_model.dart';

part 'data_online_state.dart';

class DataOnlineCubit extends Cubit<DataOnlineState> {
  DataOnlineCubit() : super(DataOnlineInitial());

  static DataOnlineCubit get(context) => BlocProvider.of(context);

  getAllData(BuildContext context) async {
    try {} catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  List<ClientResponseModel> onlineClients = [];
  getAllCliets(BuildContext context) async {
    try {
      await DioHelper.getDataWithToken(url: GET_ALL_CLIENTS).then((value) {
        if (value.statusCode == 200) {
          for (var element in value.data) {
            onlineClients.add(ClientResponseModel.fromJson(element));
            // DataCubit.get(context).insertClientTable(item);
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
