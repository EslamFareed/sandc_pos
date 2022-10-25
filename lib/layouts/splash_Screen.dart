import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sandc_pos/core/local/cache/cache_helper.dart';
import 'package:sandc_pos/core/local/cache/cache_keys.dart';
import 'package:sandc_pos/core/style/color/app_colors.dart';
import 'package:sandc_pos/cubits/data_cubit/data_cubit.dart';
import 'package:sandc_pos/layouts/main_screen.dart';
import 'package:sandc_pos/modules/auth/login.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _buildBody());
  }

  _buildBody() {
    return Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/background_splash.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Image.asset(
              "assets/images/logo.png",
              width: 300.w,
              height: 200.h,
            ),
            const CircularProgressIndicator(
              color: AppColors.whitBackGroundColor,
            )
          ],
        ));
  }

  @override
  void initState() {
    // SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);

    // if (CacheKeysManger.geIsFirstTimeFromCache()) {
    //   CacheHelper.saveData(key: "isFirstTime", value: false);
    //   _getData();
    // }

    Future.delayed(const Duration(seconds: 4)).then((value) => Get.off(
        CacheKeysManger.getUserTokenFromCache() == "NO"
            ? LoginScreen()
            : const MainScreen(),
        transition: Transition.fade,
        duration: const Duration(seconds: 1)));

    super.initState();
  }

  // _getData() async{

  // }

  // @override
  // void dispose() {
  //   SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
  //       overlays: SystemUiOverlay.values);
  //   super.dispose();
  // }
}
