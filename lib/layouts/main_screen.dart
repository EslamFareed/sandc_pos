import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:responsive_grid/responsive_grid.dart';
import 'package:sandc_pos/core/style/color/app_colors.dart';

import '../core/components/build_popup.dart';
import '../core/components/default_buttons.dart';
import '../core/style/text/app_text_style.dart';
import '../core/utils/navigation_utility.dart';

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
      title: Image.asset("assets/images/logo.jpg"),
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
      "image": "assets/images/logo.jpg",
      "onTap": () {
        print("sales");
      }
    },
    {"title": "Customers", "image": "assets/images/logo.jpg", "onTap": () {}},
    {"title": "Stock", "image": "assets/images/logo.jpg", "onTap": () {}},
    {"title": "Reports", "image": "assets/images/logo.jpg", "onTap": () {}},
    {
      "title": "Sales Returns",
      "image": "assets/images/logo.jpg",
      "onTap": () {}
    },
    {"title": "Settings", "image": "assets/images/logo.jpg", "onTap": () {}},
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
      title: Image.asset(
        "assets/images/logo.jpg",
        width: 50.w,
        fit: BoxFit.fill,
      ),
      centerTitle: true,
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
                  "assets/images/logo.jpg",
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
                      onTap: () {},
                      title: const Text("Chat With Admin"),
                      trailing: const Icon(Icons.chat),
                    ),
                    ListTile(
                      onTap: () {},
                      title: const Text("More Information"),
                      trailing: const Icon(Icons.info),
                    ),
                    ListTile(
                      onTap: () {},
                      title: const Text("Contact with us"),
                      trailing: const Icon(Icons.contact_support),
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 10.h),
                  child: Card(
                    color: const Color.fromARGB(255, 215, 215, 215) ,
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
