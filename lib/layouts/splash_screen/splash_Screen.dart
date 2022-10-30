import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart' as getx;
import 'package:sandc_pos/core/style/color/app_colors.dart';
import 'package:sandc_pos/layouts/main_screen/main_screen.dart';
import 'package:sandc_pos/modules/auth/login.dart';

import '../../cubits/auth_cubit/auth_cubit.dart';
import '../../reposetories/shared_pref/cache_keys.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      builder: (context, state) => Scaffold(body: _buildBody()),
      listener: (context, state) {
        if (state is LoginSuccessState) {
          getx.Get.showSnackbar(const getx.GetSnackBar(
            message: "update login data successfuly",
            duration: Duration(seconds: 4),
          ));
        }

        if (state is LoginErrorState) {
          getx.Get.showSnackbar(const getx.GetSnackBar(
            message: "Error please try again",
            duration: Duration(seconds: 4),
          ));
        }
      },
    );
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

    if (CacheKeysManger.getUserTokenFromCache() == "NO") {
      Future.delayed(const Duration(seconds: 4)).then((value) => getx.Get.off(
          LoginScreen(),
          transition: getx.Transition.fade,
          duration: const Duration(seconds: 1)));
    } else {
      _getData();
      Future.delayed(const Duration(seconds: 4)).then((value) => getx.Get.off(
          const MainScreen(),
          transition: getx.Transition.fade,
          duration: const Duration(seconds: 1)));
    }

    super.initState();
  }

  _getData() async {
    await AuthCubit.get(context).login(
        email: CacheKeysManger.geEmailFromCache(),
        password: CacheKeysManger.gePasswordFromCache());
  }
}

//   // _getData() async{

  // }

  // @override
  // void dispose() {
  //   SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
  //       overlays: SystemUiOverlay.values);
  //   super.dispose();
  // }

