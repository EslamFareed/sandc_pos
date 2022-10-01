import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:responsive_grid/responsive_grid.dart';
import 'package:sandc_pos/core/style/color/app_colors.dart';
import 'package:sandc_pos/modules/about/about_us.dart';
import 'package:sandc_pos/modules/about/contact_us.dart';
import 'package:sandc_pos/modules/customers/customers_home.dart';

import '../core/components/build_popup.dart';
import '../core/components/default_buttons.dart';
import '../core/style/text/app_text_style.dart';
import '../core/utils/navigation_utility.dart';
import '../modules/about/contact_with_admin_screen.dart';
import '../modules/sales/sales.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  _onWillPop() {
    return buildPopUpMessage(
      context: context,
      content: Text(
        "Want To Exit",
        style: AppTextStyle.bodyText(),
      ),
      title: Image.asset("assets/images/logo.png"),
      actions: [
        DefaultButton(
          onPress: () {
            exit(0);
          },
          buttonText: "yes",
          buttonWidth: 70.w,
          buttonHeight: 30.h,
        ),
        DefaultButton(
          onPress: () {
            NavigationUtils.navigateBack(
              context: context,
            );
          },
          buttonText: "No",
          buttonWidth: 70.w,
          buttonHeight: 30.h,
        ),
      ],
    ) as Future<bool>;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        appBar: _buildAppBar(),
        drawer: _buildDrawer(),
        body: _buildBody(),
      ),
      onWillPop: () => _onWillPop(),
    );
  }

  _buildBody() {
    return Container(
      padding: const EdgeInsets.all(10),
      child: ResponsiveGridRow(children: [
        ...items.map(
          (e) => _buildItemCard(
              e["image"].toString(), e["title"].toString(), e["onTap"]),
        )
      ]),
    );
  }

  List<Map<String, dynamic>> items = [
    {
      "title": "Sales",
      "image": "assets/images/logo.png",
      "onTap": () {
        Get.to(const SalesScreen(), transition: Transition.zoom);
      }
    },
    {
      "title": "Customers",
      "image": "assets/images/logo.png",
      "onTap": () {
        Get.to(const CustomersHome(), transition: Transition.zoom);
      }
    },
    {"title": "Stock", "image": "assets/images/logo.png", "onTap": () {}},
    {"title": "Reports", "image": "assets/images/logo.png", "onTap": () {}},
    {
      "title": "Sales Returns",
      "image": "assets/images/logo.png",
      "onTap": () {}
    },
    {"title": "Settings", "image": "assets/images/logo.png", "onTap": () {}},
  ];

  _buildItemCard(String image, String title, void Function() onTap) {
    return ResponsiveGridCol(
      xs: 6,
      md: 3,
      child: GestureDetector(
        onTap: onTap,
        child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0.r),
            ),
            borderOnForeground: true,
            child: Column(
              children: [
                Image.asset(
                  image,
                  fit: BoxFit.fill,
                ),
                Text(
                  title,
                  style: AppTextStyle.bodyText()
                      .copyWith(fontWeight: FontWeight.bold),
                )
              ],
            )),
      ),
    );
  }

  _buildAppBar() {
    return AppBar(
      elevation: 8,
      backgroundColor: AppColors.whitBackGroundColor,
      title: Image.asset(
        "assets/images/logo.png",
        width: 50.w,
      ),
      centerTitle: true,
      iconTheme: IconThemeData(color: AppColors.primaryColor),
    );
  }

  _buildDrawer() {
    return Drawer(
      child: Column(
        children: [
          Container(
              color: AppColors.primaryColor,
              height: Get.height * .25,
              width: Get.width,
              child: Center(
                child: Image.asset(
                  "assets/images/logo.png",
                  height: 100.h,
                ),
              )),
          SizedBox(
            height: Get.height * .75,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 10.h),
                      child: Card(
                        color: const Color.fromARGB(255, 215, 215, 215),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0.r),
                        ),
                        child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 25.w, vertical: 2.h),
                            child: Text(
                              "Test Version",
                              style: AppTextStyle.caption().copyWith(
                                  color:
                                      const Color.fromARGB(255, 155, 155, 155)),
                            )),
                      ),
                    ),
                    SizedBox(height: 10.h),
                    ListTile(
                      onTap: () {
                        Get.to(
                            ContactWithAdminScreen(
                              userID: '1',
                            ),
                            transition: Transition.zoom);
                      },
                      title: const Text("Chat With Admin"),
                      trailing: const Icon(Icons.chat),
                    ),
                    ListTile(
                      onTap: () {
                        Get.to(const AboutScreen(),
                            transition: Transition.zoom);
                      },
                      title: const Text("More Information"),
                      trailing: const Icon(Icons.info),
                    ),
                    ListTile(
                      onTap: () {
                        Get.to(ContactUsScreen(), transition: Transition.zoom);
                      },
                      title: const Text("Contact with us"),
                      trailing: const Icon(Icons.contact_support),
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 10.h),
                  child: Card(
                    color: const Color.fromARGB(255, 215, 215, 215),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0.r),
                    ),
                    child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 25.w, vertical: 2.h),
                        child: Text(
                          "All Rights Reserved Sandc",
                          style: AppTextStyle.caption().copyWith(
                              color: const Color.fromARGB(255, 155, 155, 155),
                              fontSize: 12.sp),
                        )),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
