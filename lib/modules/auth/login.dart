import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart' as tra;
import 'package:sandc_pos/core/components/app_language.dart';
import 'package:sandc_pos/core/style/color/app_colors.dart';
import 'package:sandc_pos/core/style/text/app_text_style.dart';
import 'package:sandc_pos/cubits/auth_cubit/auth_cubit.dart';
import 'package:sandc_pos/modules/about/contact_us.dart';

import '../../layouts/main_screen/main_screen.dart';
import 'forget_password.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  GlobalKey<FormState> _keyForm = GlobalKey();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      builder: (context, state) => Scaffold(body: _buildBody(context)),
      listener: (context, state) {
        if (state is LoginLoadingState) {
          tra.Get.dialog(const Dialog(
            child: Center(child: CircularProgressIndicator()),
          ));
        }

        if (state is LoginSuccessState) {
          tra.Get.offAll(const MainScreen(), transition: tra.Transition.zoom);
          tra.Get.showSnackbar(const tra.GetSnackBar(
            message: "Login successfully",
            duration: Duration(seconds: 4),
          ));
        }

        if (state is LoginErrorState) {
          tra.Get.back();
          tra.Get.showSnackbar(const tra.GetSnackBar(
            message: "Error please try again",
            duration: Duration(seconds: 4),
          ));
        }
      },
    );
  }

  _buildBody(BuildContext context) {
    return Form(
      key: _keyForm,
      child: Container(
          width: tra.Get.width,
          height: tra.Get.height,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/background_splash.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: SizedBox(
              width: tra.Get.width,
              height: tra.Get.height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Image.asset(
                    "assets/images/logo.png",
                    width: tra.Get.width * 0.5,
                    height: tra.Get.height * 0.15,
                  ),
                  SizedBox(
                    width: tra.Get.width * 0.7,
                    height: tra.Get.height * 0.6,
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
                                  tra.Get.to(const ForgetPasswordScreen(),
                                      transition: tra.Transition.zoom,
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
                              width: tra.Get.width.w,
                              decoration: BoxDecoration(
                                color: AppColors.primaryColor,
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: MaterialButton(
                                onPressed: () async {
                                  if (_keyForm.currentState!.validate()) {
                                    await AuthCubit.get(context).login(
                                        email: emailController.text.toString(),
                                        password:
                                            passwordController.text.toString());
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
                                    tra.Get.to(
                                      ContactUsScreen(),
                                      transition: tra.Transition.zoom,
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
