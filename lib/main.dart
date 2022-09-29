import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'core/local/cache/cache_helper.dart';
import 'core/remote/dio/dio_helper.dart';
import 'firebase_options.dart';
import 'layouts/app_root.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  DioHelper.init();
  await CacheHelper.init();
  runApp(const AppRoot());
}
