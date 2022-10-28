import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:sandc_pos/core/remote/dio/dio_helper.dart';
import 'package:sandc_pos/core/remote/dio/end_points.dart';

import '../../core/local/cache/cache_helper.dart';
import '../../core/local/cache/cache_keys.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  static AuthCubit get(context) => BlocProvider.of(context);

  login({String? email, String? password}) async {
    emit(LoginLoadingState());
    try {
      await DioHelper.postData(
          url: LOGIN,
          data: {"email": email, "password": password}).then((value) async {
        if (value.statusCode == 200) {
          await CacheHelper.saveData(
              key: "userToken", value: value.data["data"].toString());
          await CacheHelper.saveData(key: "email", value: email);
          await CacheHelper.saveData(key: "password", value: password);
          if (kDebugMode) {
            print(CacheKeysManger.getUserTokenFromCache());
          }
          emit(LoginSuccessState());
        } else {
          if (kDebugMode) {
            print(value.data.toString());
          }
          emit(LoginErrorState());
        }
      });
    } catch (e) {
      emit(LoginErrorState());

      if (kDebugMode) {
        print(e.toString());
      }
    }
  }
}
