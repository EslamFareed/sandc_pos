import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart' as getx;
import 'package:responsive_grid/responsive_grid.dart';
import 'package:sandc_pos/core/components/app_language.dart';
import 'package:sandc_pos/cubits/data_cubit/data_cubit.dart';
import 'package:sandc_pos/cubits/data_online_cubit/data_online_cubit.dart';
import 'package:sandc_pos/cubits/main_cubit/main_cubit.dart';

import 'package:sandc_pos/reposetories/shared_pref/cache_keys.dart';
import '../../core/style/color/app_colors.dart';

import '../../cubits/main_cubit/main_states.dart';
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
      _getDataFirstTime();
    } else {
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
    await DataOnlineCubit.get(context).getAllOfflineData(context);
    // await CacheHelper.saveData(
    //     key: "lang",
    //     value: DataCubit.get(context).companyModels[0].compLanguage == "عربي"
    //         ? "ar"
    //         : "en");
    // MainCubit.get(context).changeAppLanguage(context,
    //     lang: CacheKeysManger.getLanguageFromCache());
  }

  _getDataFirstTime() async {
    await DataOnlineCubit.get(context).getAllDataForFirstTime(context);
    // await CacheHelper.saveData(
    //     key: "lang",
    //     value: DataCubit.get(context).companyModels[0].compLanguage == "عربي"
    //         ? "ar"
    //         : "en");
    // MainCubit.get(context).changeAppLanguage(context,
    //     lang: CacheKeysManger.getLanguageFromCache());
  }

  _onWillPop() {
    return buildPopUpMessage(
      context: context,
      content: Text(
        getLang(context).wanttoexit,
        style: AppTextStyle.bodyText(),
      ),
      title: Image.asset("assets/images/logo.png"),
      actions: [
        DefaultButton(
          onPress: () {
            exit(0);
          },
          buttonText: getLang(context).yes,
          buttonWidth: 70.w,
          buttonHeight: 30.h,
        ),
        DefaultButton(
          onPress: () {
            NavigationUtils.navigateBack(
              context: context,
            );
          },
          buttonText: getLang(context).no,
          buttonWidth: 70.w,
          buttonHeight: 30.h,
        ),
      ],
    ) as Future<bool>;
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DataOnlineCubit, DataOnlineState>(
      builder: (context, state) {
        var cubit = DataOnlineCubit.get(context);
        return WillPopScope(
          child: Scaffold(
            appBar: _buildAppBar(),
            drawer: _buildDrawer(context, state),
            body: SingleChildScrollView(child: _buildBody()),
          ),
          onWillPop: () => _onWillPop(),
        );
      },
      listener: (context, state) {
        if (state is GetDataOnlineSuccessState) {
          getx.Get.back(closeOverlays: true);
          getx.Get.showSnackbar(getx.GetSnackBar(
            message: getLang(context).dataupdatedsuccessfuly,
            duration: const Duration(seconds: 4),
          ));
        }

        if (state is GetDataOnlineErrorState) {
          getx.Get.back();
          getx.Get.showSnackbar(getx.GetSnackBar(
            message: getLang(context).errorpleasetryagain,
            duration: const Duration(seconds: 4),
          ));
        }
        if (state is GetAllDataOfflineSuccess) {
          getx.Get.back(closeOverlays: true);
          getx.Get.showSnackbar(getx.GetSnackBar(
            message: getLang(context).dataupdatedsuccessfuly,
            duration: const Duration(seconds: 4),
          ));
        }

        if (state is GetAllDataOfflineError) {
          getx.Get.back(closeOverlays: true);
          getx.Get.showSnackbar(getx.GetSnackBar(
            message: getLang(context).errorpleasetryagain,
            duration: const Duration(seconds: 4),
          ));
        }
      },
    );
  }

  _buildBody() {
    return Container(
      padding: const EdgeInsets.all(10),
      child: BlocConsumer<MainCubit, MainStates>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          return ResponsiveGridRow(children: [
            _buildItemCard(
                "assets/images/sales_pos_2.png", getLang(context).sales, () {
              getx.Get.to(SalesScreen(), transition: getx.Transition.zoom);
            }),
            _buildItemCard(
                "assets/images/customer_pos.png", getLang(context).clients, () {
              getx.Get.to(const CustomersHome(),
                  transition: getx.Transition.zoom);
            }),
            _buildItemCard(
                "assets/images/stock_pos.png", getLang(context).stock, () {
              getx.Get.to(const ProductsHome(),
                  transition: getx.Transition.zoom);
            }),
            _buildItemCard(
                "assets/images/reports_pos_2.png", getLang(context).reports,
                () {
              getx.Get.to(const ReportsHome(),
                  transition: getx.Transition.zoom);
            }),
            _buildItemCard("assets/images/sales_returns_pos.png",
                getLang(context).salesreturns, () {
              getx.Get.to(const SalesReturnsScreen(),
                  transition: getx.Transition.zoom);
            }),
            _buildItemCard(
                "assets/images/settings_pos.png", getLang(context).settings,
                () {
              getx.Get.to(const SettingsScreen(),
                  transition: getx.Transition.zoom);
            }),
            _buildItemCard(
                "assets/images/printer_pos.png",
                MainCubit.get(context).isConnectedToPrinter!
                    ? MainCubit.get(context).selectedDevice!.name
                    : getLang(context).noprinterselected, () {
              getx.Get.to(const SettingsPrinter(),
                  transition: getx.Transition.zoom);
            }),
            _buildItemCard(
                "assets/images/cloud_pos.png", getLang(context).updatewithcloud,
                () async {
              _showDialog();
              await DataOnlineCubit.get(context).checkIfDataUptodate(context);
            }),
          ]);
        },
      ),
    );
  }

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
                  width: 75.w,
                  height: 75.h,
                ),
                Text(
                  title,
                  style: AppTextStyle.bodyText()
                      .copyWith(fontWeight: FontWeight.w700, fontSize: 15.sp),
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
      title: Text(
        DataCubit.get(context).companyModels.isNotEmpty
            ? DataCubit.get(context).companyModels[0].companyName!
            : "SANDC",
        style:
            AppTextStyle.appBarText().copyWith(color: AppColors.primaryColor),
      ),
      centerTitle: true,
      iconTheme: const IconThemeData(color: AppColors.primaryColor),
    );
  }

  _buildDrawer(BuildContext context, DataOnlineState state) {
    if (DataCubit.get(context).companyModels.isNotEmpty) {
      Uint8List _bytesImage = const Base64Decoder().convert(
          DataCubit.get(context)
              .companyModels[0]
              .logo!
              .split("data:image/png;base64,")
              .last);

      return Drawer(
        child: Column(
          children: [
            Container(
                color: AppColors.primaryColor,
                height: getx.Get.height * .25,
                width: getx.Get.width,
                child: Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.all(20),
                      child: CircleAvatar(
                        backgroundImage: MemoryImage(_bytesImage),
                        radius: 50.r,
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          DataCubit.get(context).companyModels[0].empName!,
                          style: AppTextStyle.appBarText()
                              .copyWith(color: Colors.white),
                        ),
                        Text(
                          DataCubit.get(context).companyModels[0].empPhone!,
                          style: AppTextStyle.caption()
                              .copyWith(color: Colors.white),
                        ),
                        Text(
                          DataCubit.get(context).companyModels[0].empEmail!,
                          style: AppTextStyle.caption()
                              .copyWith(color: Colors.white),
                        ),
                        Text(
                          DataCubit.get(context).companyModels[0].branchName!,
                          style: AppTextStyle.caption()
                              .copyWith(color: Colors.white),
                        ),
                      ],
                    )
                  ],
                )),
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
                                getLang(context).testversion,
                                style: AppTextStyle.caption().copyWith(
                                    color: const Color.fromARGB(
                                        255, 155, 155, 155)),
                              )),
                        ),
                      ),
                      SizedBox(height: 10.h),
                      ListTile(
                        onTap: () {
                          getx.Get.to(const AboutScreen(),
                              transition: getx.Transition.zoom);
                        },
                        title: Text(getLang(context).moreinformation),
                        trailing: const Icon(Icons.info),
                      ),
                      ListTile(
                        onTap: () {
                          getx.Get.to(ContactUsScreen(),
                              transition: getx.Transition.zoom);
                        },
                        title: Text(getLang(context).contactwithus),
                        trailing: const Icon(Icons.contact_support),
                      ),
                      ListTile(
                        onTap: () async {
                          await CacheHelper.saveData(
                              key: "userToken", value: "NO");
                          getx.Get.offAll(LoginScreen(),
                              transition: getx.Transition.zoom);
                        },
                        title: Text(getLang(context).logout),
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
                            getLang(context).allrightsreservedsandc,
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
    } else {
      return const CircularProgressIndicator();
    }
  }
}
