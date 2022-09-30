import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sandc_pos/core/style/color/app_colors.dart';
import 'package:sandc_pos/modules/sales/print_screen.dart';
import 'package:sandc_pos/modules/sales/scan_code.dart';
import 'package:sandc_pos/modules/sales/search_products.dart';

import 'table.dart';

class SalesScreen extends StatelessWidget {
  const SalesScreen({Key? key}) : super(key: key);

  _buildAppBar() {
    return AppBar(
      title: Text("Sales"),
      centerTitle: true,
      actions: [
        //open printer page
        IconButton(
          onPressed: () {
            Get.to(const PrintScreen(), transition: Transition.zoom);
          },
          icon: const Icon(Icons.print_rounded),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
      floatingActionButton: FloatingActionButton(
        child: const Icon(
          Icons.arrow_circle_up,
          size: 50,
        ),
        onPressed: () {
          Get.dialog(
            Dialog(
              insetAnimationDuration: const Duration(milliseconds: 100),
              alignment: Alignment.bottomCenter,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
              ),
              child: SizedBox(
                width: Get.width * .8,
                height: Get.height * .25,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          //close dialog
                          FloatingActionButton(
                            elevation: 0,
                            onPressed: () {
                              Get.back();
                            },
                            child: const Icon(
                              Icons.arrow_downward,
                              size: 30,
                            ),
                          ),
                          //open categories
                          FloatingActionButton(
                            elevation: 0,
                            onPressed: () {},
                            child: const Icon(
                              Icons.category_outlined,
                              size: 30,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text("Total = 50000"),
                    Container(
                      width: Get.width * .7,
                      child: ElevatedButton(
                        onPressed: () {},
                        child: Text("Finish Order"),
                      ),
                    )
                  ],
                ),
              ),
            ),
            barrierDismissible: false,
          );
        },
      ),
    );
  }

  _buildBottom() {
    return Column(
      children: [
        Text("data"),
      ],
    );
  }

  _buildSearchBar() {
    return Container(
      width: Get.width,
      height: 50.h,
      margin: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.primaryColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          //open search
          Expanded(
            child: GestureDetector(
              onTap: () {
                Get.to(
                  const SearchProductsScreen(),
                  transition: Transition.fadeIn,
                );
              },
              child: Container(
                margin: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        "Search Product",
                        style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Icon(
                        Icons.search,
                        color: Colors.grey,
                      )
                    ],
                  ),
                ),
                // child: TextFormField(
                //   textInputAction: TextInputAction.search,
                //   onTap: () {
                //     Get.to(SearchProductsScreen(), transition: Transition.zoom);
                //   },
                //   decoration: InputDecoration(
                //     contentPadding: EdgeInsets.symmetric(horizontal: 20.w),
                //     border: InputBorder.none,
                //     suffixIcon: const Icon(
                //       Icons.search,
                //       color: Colors.grey,
                //     ),
                //     hintText: "Search Product",
                // hintStyle: const TextStyle(
                //   color: Colors.grey,
                //   fontWeight: FontWeight.bold,
                // ),
                //   ),
                // ),
              ),
            ),
          ),

          //open camera scanner
          IconButton(
            icon: const Icon(
              Icons.qr_code_scanner,
              color: Colors.white,
              size: 30,
            ),
            onPressed: () {
              Get.to(const ScanCodeScreen(), transition: Transition.zoom);
            },
          )
        ],
      ),
    );
  }

  _buildBody() {
    return Column(
      children: [
        _buildSearchBar(),
        Expanded(child: TableWidget()),
      ],
    );
  }
}
