import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sandc_pos/modules/products/table_product.dart';

import '../../core/style/color/app_colors.dart';
import '../sales/print_screen.dart';
import '../sales/scan_code.dart';
import '../sales/search_products.dart';
import '../sales/table_sales.dart';

class ShowProducts extends StatelessWidget {
  const ShowProducts({super.key});

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
        Expanded(child: TableProduct()),
      ],
    );
  }
}