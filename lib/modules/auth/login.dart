import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sandc_pos/core/components/app_language.dart';
import 'package:sandc_pos/core/style/color/app_colors.dart';
import 'package:sandc_pos/core/style/text/app_text_style.dart';
import 'package:sandc_pos/layouts/main_screen.dart';

import '../../core/components/default_buttons.dart';
import 'forget_password.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _buildBody(context));
  }

  _buildBody(BuildContext context) {
    return Container(
        width: Get.width.w,
        height: Get.height.h,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/background_splash.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: SizedBox(
            width: Get.width.w,
            height: Get.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image.asset(
                  "assets/images/logo.jpg",
                  width: Get.width * 0.5,
                  height: Get.height * 0.15,
                ),
                SizedBox(
                  width: Get.width * 0.7,
                  height: Get.height * 0.5,
                  child: Card(
                    color: AppColors.whitBackGroundColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          Text(
                            "Login",
                            style: AppTextStyle.headLine()
                                .copyWith(color: AppColors.primaryColor),
                          ),
                          SizedBox(height: 20.h),
                          TextFormField(
                            style: const TextStyle(fontSize: 15),
                            decoration: const InputDecoration(
                              hintText: "Email",
                              contentPadding: EdgeInsets.all(10),
                            ),
                          ),
                          SizedBox(height: 10.h),
                          TextFormField(
                            style: const TextStyle(fontSize: 15),
                            obscureText: true,
                            obscuringCharacter: "*",
                            decoration: const InputDecoration(
                              hintText: "Password",
                              contentPadding: EdgeInsets.all(10),
                            ),
                          ),
                          SizedBox(height: 10.h),
                          Container(
                            alignment: getLang(context).localeName == "ar"
                                ? Alignment.centerRight
                                : Alignment.centerLeft,
                            child: GestureDetector(
                              onTap: () {
                                Get.to(const ForgetPasswordScreen(),
                                    transition: Transition.zoom,
                                    duration: Duration(milliseconds: 200));
                              },
                              child: const Text(
                                "Forget Password ?",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: AppColors.primaryColor,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 25.h),
                          Container(
                            width: Get.width.w,
                            decoration: BoxDecoration(
                              color: AppColors.primaryColor,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: MaterialButton(
                              onPressed: () {
                                Get.off(const MainScreen(),
                                    transition: Transition.zoom);
                              },
                              child: Text(
                                "Login",
                                style: AppTextStyle.bodyText().copyWith(
                                  color: AppColors.whitBackGroundColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                "Don't Have Account ?",
                                style: TextStyle(fontSize: 12),
                              ),
                              SizedBox(width: 5.w),
                              GestureDetector(
                                onTap: () {
                                  Get.to(const ForgetPasswordScreen(),
                                      transition: Transition.zoom);
                                },
                                child: const Text(
                                  "Contact us",
                                  style: TextStyle(
                                      color: AppColors.primaryColor,
                                      fontSize: 12),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
