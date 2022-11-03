import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart' as getx;
import 'package:responsive_grid/responsive_grid.dart';
import 'package:sandc_pos/cubits/data_online_cubit/data_online_cubit.dart';
import 'package:sandc_pos/layouts/main_screen/widgets/home_item.dart';
import 'package:sandc_pos/reposetories/shared_pref/cache_keys.dart';
import '../../core/style/color/app_colors.dart';

import '../../modules/about/about_us.dart';
import '../../modules/about/contact_us.dart';
import '../../modules/auth/login.dart';
import '../../modules/customers/customers_home.dart';
import '../../modules/products/products_home.dart';
import '../../modules/sales_returns/sales_return.dart';
import '../../core/components/build_popup.dart';
import '../../core/components/default_buttons.dart';
import '../../core/style/text/app_text_style.dart';
import '../../core/utils/navigation_utility.dart';
import '../../modules/home/settings.dart';
import '../../modules/home/settings_printer.dart';
import '../../modules/reports/reports_home.dart';
import '../../modules/sales/sales.dart';
import '../../reposetories/shared_pref/cache_helper.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  void initState() {
    if (CacheKeysManger.geIsFirstTimeFromCache()) {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        _showDialog();
      });
      _getData();
    }

    super.initState();
  }

  _showDialog() {
    getx.Get.dialog(
        Dialog(
          child: SizedBox(
            height: 100.h,
            width: 100.w,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                CircularProgressIndicator(),
              ],
            ),
          ),
        ),
        barrierDismissible: false,
        transitionDuration: const Duration(milliseconds: 500));
  }

  _getData() async {
    await DataOnlineCubit.get(context).getAllDataForFirstTime(context);
  }

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
    return BlocConsumer<DataOnlineCubit, DataOnlineState>(
      builder: (context, state) => WillPopScope(
        child: Scaffold(
          appBar: _buildAppBar(),
          drawer: _buildDrawer(),
          body: SingleChildScrollView(child: _buildBody()),
        ),
        onWillPop: () => _onWillPop(),
      ),
      listener: (context, state) {
        if (state is GetDataOnlineSuccessState) {
          getx.Get.back(closeOverlays: true);
          getx.Get.showSnackbar(const getx.GetSnackBar(
            message: "Data updated successfuly",
            duration: Duration(seconds: 4),
          ));
        }

        if (state is GetDataOnlineErrorState) {
          getx.Get.back();
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
      padding: const EdgeInsets.all(10),
      child: ResponsiveGridRow(children: [
        ...items.map(
          (e) =>
              _buildItemCard(e.image.toString(), e.title.toString(), e.onTap!),
        )
      ]),
    );
  }

  List<HomeItem> items = [
    HomeItem(
        title: "Sales",
        image: "assets/images/logo.png",
        onTap: () {
          getx.Get.to(SalesScreen(), transition: getx.Transition.zoom);
        }),
    HomeItem(
        title: "Clients",
        image: "assets/images/logo.png",
        onTap: () {
          getx.Get.to(const CustomersHome(), transition: getx.Transition.zoom);
        }),
    HomeItem(
        title: "Stock",
        image: "assets/images/logo.png",
        onTap: () {
          getx.Get.to(const ProductsHome(), transition: getx.Transition.zoom);
        }),
    HomeItem(
        title: "Reports",
        image: "assets/images/logo.png",
        onTap: () {
          getx.Get.to(const ReportsHome(), transition: getx.Transition.zoom);
        }),
    HomeItem(
        title: "Sales Returns",
        image: "assets/images/logo.png",
        onTap: () {
          getx.Get.to(const SalesReturnsScreen(),
              transition: getx.Transition.zoom);
        }),
    HomeItem(
        title: "Settings",
        image: "assets/images/logo.png",
        onTap: () {
          getx.Get.to(SettingsScreen(), transition: getx.Transition.zoom);
        }),
    HomeItem(
        title: "Printer",
        image: "assets/images/logo.png",
        onTap: () {
          getx.Get.to(const SettingsPrinter(),
              transition: getx.Transition.zoom);
        }),
    HomeItem(
        title: "Update To cloud",
        image: "assets/images/logo.png",
        onTap: () {
          getx.Get.showSnackbar(const getx.GetSnackBar(
            message: "Updated To cloud successfully",
            duration: Duration(seconds: 2),
          ));
        }),
    HomeItem(
        title: "Update From cloud",
        image: "assets/images/logo.png",
        onTap: () {
          getx.Get.showSnackbar(getx.GetSnackBar(
            message: "Updated From cloud successfully",
            duration: Duration(seconds: 2),
          ));
        }),
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
              height: getx.Get.height * .25,
              width: getx.Get.width,
              child: Column()),
          SizedBox(
            height: getx.Get.height * .75,
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
                    // ListTile(
                    //   onTap: () {
                    //     Get.to(
                    //         ContactWithAdminScreen(
                    //           userID: '1',
                    //         ),
                    //         transition: Transition.zoom);
                    //   },
                    //   title: const Text("Chat With Admin"),
                    //   trailing: const Icon(Icons.chat),
                    // ),
                    ListTile(
                      onTap: () {
                        getx.Get.to(const AboutScreen(),
                            transition: getx.Transition.zoom);
                      },
                      title: const Text("More Information"),
                      trailing: const Icon(Icons.info),
                    ),
                    ListTile(
                      onTap: () {
                        getx.Get.to(ContactUsScreen(),
                            transition: getx.Transition.zoom);
                      },
                      title: const Text("Contact with us"),
                      trailing: const Icon(Icons.contact_support),
                    ),
                    ListTile(
                      onTap: () async {
                        await CacheHelper.saveData(
                            key: "userToken", value: "NO");
                        getx.Get.offAll(LoginScreen(),
                            transition: getx.Transition.zoom);
                      },
                      title: const Text("Logout"),
                      trailing: const Icon(Icons.exit_to_app),
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
