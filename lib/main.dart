import 'package:flutter/material.dart';

import 'core/local/cache/cache_helper.dart';
import 'core/remote/dio/dio_helper.dart';
import 'layouts/app_root.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  await CacheHelper.init();
  runApp(const AppRoot());
}
