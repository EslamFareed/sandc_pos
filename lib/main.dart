import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'firebase_options.dart';
import 'layouts/app_root/app_root.dart';
import 'reposetories/remote/dio/dio_helper.dart';
import 'reposetories/shared_pref/cache_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  DioHelper.init();
  await CacheHelper.init();
  runApp(const AppRoot());
}
//todo 
//popup in sales