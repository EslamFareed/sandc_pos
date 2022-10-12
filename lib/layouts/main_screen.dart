import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:responsive_grid/responsive_grid.dart';
import 'package:sandc_pos/core/local/cache/cache_helper.dart';
import 'package:sandc_pos/core/style/color/app_colors.dart';
import 'package:sandc_pos/cubits/data_cubit/data_cubit.dart';
import 'package:sandc_pos/models/branch.dart';
import 'package:sandc_pos/models/category.dart';
import 'package:sandc_pos/models/company.dart';
import 'package:sandc_pos/models/currency.dart';
import 'package:sandc_pos/models/emp_types.dart';
import 'package:sandc_pos/models/employee.dart';
import 'package:sandc_pos/models/products.dart';
import 'package:sandc_pos/models/unit.dart';
import 'package:sandc_pos/modules/about/about_us.dart';
import 'package:sandc_pos/modules/about/contact_us.dart';
import 'package:sandc_pos/modules/auth/login.dart';
import 'package:sandc_pos/modules/customers/customers_home.dart';
import 'package:sandc_pos/modules/products/products_home.dart';
import 'package:uuid/uuid.dart';

import '../core/components/build_popup.dart';
import '../core/components/default_buttons.dart';
import '../core/style/text/app_text_style.dart';
import '../core/utils/navigation_utility.dart';
import '../modules/about/contact_with_admin_screen.dart';
import '../modules/home/settings.dart';
import '../modules/home/settings_printer.dart';
import '../modules/reports/reports_home.dart';
import '../modules/sales/sales.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  void initState() {
    _getData();

    super.initState();
  }

  _getData() async {
    await DataCubit.get(context).getCurrentCompany();

    // await DataCubit.get(context).deleteAllProductModel();
    // var id = Uuid().v1();
    // print(id);
    // await DataCubit.get(context).insertProductTable(
    //   ProductModel(
    //     buyingPrice: 150,
    //     catID: 1,
    //     compID: 1,
    //     createDate: DateTime.now().toString(),
    //     description: "shoes with color black",
    //     discount: 50,
    //     expirationDate:
    //         DateTime.now().add(const Duration(days: 365)).toString(),
    //     image: "https://m.media-amazon.com/images/I/71D9ImsvEtL._UY500_.jpg",
    //     isActive: true,
    //     isPetrolGas: false,
    //     name: "shoes bata",
    //     priceOne: 150,
    //     priceThree: 175,
    //     priceTwo: 150,
    //     prodId: id,
    //     productNumber: id,
    //     qrCode: id,
    //     stockQuantity: 50,
    //     unitID: 1,
    //     unitPackage: 1,
    //     updateDate: DateTime.now().toString(),
    //   ),
    // );
    // var id1 = Uuid().v1();
    // print(id1);
    // await DataCubit.get(context).insertProductTable(
    //   ProductModel(
    //     buyingPrice: 2000,
    //     catID: 1,
    //     compID: 1,
    //     createDate: DateTime.now().toString(),
    //     description: "Samsung s21s",
    //     discount: 0,
    //     expirationDate:
    //         DateTime.now().add(const Duration(days: 365)).toString(),
    //     image:
    //         "https://zkartbw.com/32-large_default/samsung-galaxy-a21s-32gb.jpg",
    //     isActive: true,
    //     isPetrolGas: false,
    //     name: "Samsung s21s",
    //     priceOne: 2500,
    //     priceThree: 2700,
    //     priceTwo: 3000,
    //     prodId: id1,
    //     productNumber: id1,
    //     qrCode: id1,
    //     stockQuantity: 10,
    //     unitID: 1,
    //     unitPackage: 1,
    //     updateDate: DateTime.now().toString(),
    //   ),
    // );
    // var id2 = Uuid().v1();
    // print(id2);
    // await DataCubit.get(context).insertProductTable(
    //   ProductModel(
    //     buyingPrice: 5,
    //     catID: 1,
    //     compID: 1,
    //     createDate: DateTime.now().toString(),
    //     description: "pepsi cans",
    //     discount: 0,
    //     expirationDate:
    //         DateTime.now().add(const Duration(days: 365)).toString(),
    //     image:
    //         "https://cdnprod.mafretailproxy.com/sys-master-root/hc1/hc4/14539671175198/3813_main.jpg_480Wx480H",
    //     isActive: true,
    //     isPetrolGas: false,
    //     name: "pepsi",
    //     priceOne: 6,
    //     priceThree: 7,
    //     priceTwo: 10,
    //     prodId: id2,
    //     productNumber: id2,
    //     qrCode: id2,
    //     stockQuantity: 1000,
    //     unitID: 1,
    //     unitPackage: 1,
    //     updateDate: DateTime.now().toString(),
    //   ),
    // );

    // await DataCubit.get(context).getAllProductTable();
    // print(DataCubit.get(context).productModels);
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
        Get.to(SalesScreen(), transition: Transition.zoom);
      }
    },
    {
      "title": "Customers",
      "image": "assets/images/logo.png",
      "onTap": () {
        Get.to(const CustomersHome(), transition: Transition.zoom);
      }
    },
    {
      "title": "Stock",
      "image": "assets/images/logo.png",
      "onTap": () {
        Get.to(const ProductsHome(), transition: Transition.zoom);
      }
    },
    {
      "title": "Reports",
      "image": "assets/images/logo.png",
      "onTap": () {
        Get.to(const ReportsHome(), transition: Transition.zoom);
      }
    },
    {
      "title": "Sales Returns",
      "image": "assets/images/logo.png",
      "onTap": () {}
    },
    {
      "title": "Settings",
      "image": "assets/images/logo.png",
      "onTap": () {
        Get.to(SettingsScreen(), transition: Transition.zoom);
      }
    },
    // {
    //   "title": "Printer",
    //   "image": "assets/images/logo.png",
    //   "onTap": () {
    //     Get.to(SettingsPrinter(), transition: Transition.zoom);
    //   }
    // },
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
                    ListTile(
                      onTap: () async {
                        await CacheHelper.saveData(
                            key: "userToken", value: "NO");
                        Get.offAll(LoginScreen(), transition: Transition.zoom);
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
