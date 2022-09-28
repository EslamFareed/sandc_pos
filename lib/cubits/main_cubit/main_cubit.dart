import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/local/cache/cache_helper.dart';
import '../../core/local/cache/cache_keys.dart';
import '../../layouts/app_root.dart';
import 'main_states.dart';

class MainCubit extends Cubit<MainStates> {
  MainCubit() : super(MainCubitInitialState());

  static MainCubit get(context) => BlocProvider.of(context);

  String language = CacheKeysManger.getLanguageFromCache();
  void changeAppLanguage(BuildContext context, {required String lang}) {
    CacheHelper.saveData(key: 'lang', value: lang).then((value) {
      language = lang;
      emit(ChangeAppLanguageState());
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (bu) => const AppRoot()),
          (route) => false);
    });
  }
}
