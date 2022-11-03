import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:sandc_pos/cubits/auth_cubit/auth_cubit.dart';
import 'package:sandc_pos/cubits/chat_cubit/chat_cubit.dart';
import 'package:sandc_pos/cubits/client_cubit/client_cubit.dart';
import 'package:sandc_pos/cubits/data_cubit/data_cubit.dart';
import 'package:sandc_pos/cubits/data_online_cubit/data_online_cubit.dart';

import '../../../core/style/dark/dark.dart';
import '../../core/style/light/light.dart';
import '../../cubits/main_cubit/main_cubit.dart';
import '../../cubits/main_cubit/main_states.dart';
import '../splash_screen/splash_Screen.dart';

class AppRoot extends StatelessWidget {
  const AppRoot({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (BuildContext context) => MainCubit()),
        BlocProvider(create: (BuildContext context) => ChatCubit()),
        BlocProvider(create: (BuildContext context) => AuthCubit()),
        BlocProvider(create: (BuildContext context) => DataOnlineCubit()),
        BlocProvider(create: (BuildContext context) => ClientCubit()),
        BlocProvider(create: (BuildContext context) => DataCubit()..db),
      ],
      child: BlocConsumer<MainCubit, MainStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = MainCubit.get(context);
          return ScreenUtilInit(
            designSize: const Size(360, 640),
            minTextAdapt: true,
            splitScreenMode: true,
            builder: (ctx, widget) => GetMaterialApp(
              debugShowCheckedModeBanner: false,
              builder: (context, widget) {
                ScreenUtil.init(context);
                return MediaQuery(
                  data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
                  child: widget!,
                );
              },
              localizationsDelegates: const [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: const [
                Locale('en', ''),
                Locale('ar', ''),
              ],
              locale: Locale.fromSubtags(languageCode: cubit.language),
              theme: lightMode,
              darkTheme: darkMode,
              themeMode: ThemeMode.light,
              home: const SplashScreen(),
            ),
          );
        },
      ),
    );
  }
}
