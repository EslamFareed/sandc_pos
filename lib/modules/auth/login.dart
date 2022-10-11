import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sandc_pos/core/components/app_language.dart';
import 'package:sandc_pos/core/local/cache/cache_helper.dart';
import 'package:sandc_pos/core/style/color/app_colors.dart';
import 'package:sandc_pos/core/style/text/app_text_style.dart';
import 'package:sandc_pos/layouts/main_screen.dart';
import 'package:sandc_pos/modules/about/contact_us.dart';

import 'forget_password.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  GlobalKey<FormState> _keyForm = GlobalKey();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _buildBody(context));
  }

  _buildBody(BuildContext context) {
    return Form(
      key: _keyForm,
      child: Container(
          width: Get.width,
          height: Get.height,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/background_splash.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: SizedBox(
              width: Get.width,
              height: Get.height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Image.asset(
                    "assets/images/logo.png",
                    width: Get.width * 0.5,
                    height: Get.height * 0.15,
                  ),
                  SizedBox(
                    width: Get.width * 0.7,
                    height: Get.height * 0.6,
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
                              controller: emailController,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "email must be not empty";
                                } else if (!RegExp(
                                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                    .hasMatch(value)) {
                                  return "write a valid email";
                                }
                              },
                              onChanged: (value) {
                                _keyForm.currentState!.validate();
                              },
                              maxLines: 1,
                              minLines: 1,
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
                              controller: passwordController,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "password must be not empty";
                                }
                              },
                              onChanged: (value) {
                                _keyForm.currentState!.validate();
                              },
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
                                onPressed: () async {
                                  if (_keyForm.currentState!.validate()) {
                                    if (emailController.text ==
                                            "eslam@yahoo.com" &&
                                        passwordController.text == "123456") {
                                      await CacheHelper.saveData(
                                          key: "userToken", value: "123456789");
                                      Get.showSnackbar(const GetSnackBar(
                                        message: "Login successfully",
                                        duration: Duration(seconds: 4),
                                      ));
                                      Get.offAll(const MainScreen(),
                                          transition: Transition.zoom);
                                    } else {
                                      Get.showSnackbar(const GetSnackBar(
                                        message: "error login",
                                        duration: Duration(seconds: 4),
                                      ));
                                    }
                                  }
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
                                    Get.to(
                                      ContactUsScreen(),
                                      transition: Transition.zoom,
                                    );
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
          )),
    );
  }
}
