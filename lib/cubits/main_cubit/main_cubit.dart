import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_scan_bluetooth/flutter_scan_bluetooth.dart';

import '../../reposetories/shared_pref/cache_helper.dart';
import '../../reposetories/shared_pref/cache_keys.dart';
import 'main_states.dart';

class MainCubit extends Cubit<MainStates> {
  MainCubit() : super(MainCubitInitialState());

  static MainCubit get(context) => BlocProvider.of(context);

  bool? isConnectedToPrinter = false;
  BluetoothDevice? selectedDevice;

  String language = CacheKeysManger.getLanguageFromCache();
  void changeAppLanguage(BuildContext context, {required String lang}) {
    CacheHelper.saveData(key: 'lang', value: lang).then((value) {
      language = lang;
      emit(ChangeAppLanguageState());
    });
  }

  String currency = CacheKeysManger.getCurrencyFromCache();
  void changeCurrency(BuildContext context, {required String curn}) {
    CacheHelper.saveData(key: 'currency', value: curn).then((value) {
      currency = curn;
      emit(ChangeAppCurrencyState());
    });
  }
}
