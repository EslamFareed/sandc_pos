import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sandc_pos/core/style/color/app_colors.dart';
import 'package:sandc_pos/layouts/main_screen/main_screen.dart';
import 'package:sandc_pos/modules/customers/table_customer.dart';
import 'package:sandc_pos/modules/sales/print_screen.dart';
import 'package:sandc_pos/modules/sales/scan_code.dart';
import 'package:sandc_pos/modules/sales/search_products.dart';

import '../../core/components/build_popup.dart';
import '../../core/components/default_buttons.dart';
import '../../core/style/text/app_text_style.dart';
import '../sales/table_sales.dart';
import 'make_pdf_customer.dart';
import 'search_customers.dart';

class ShowCustomers extends StatelessWidget {
  const ShowCustomers({super.key});

  _buildAppBar() {
    return AppBar(
      title: const Text("Clients"),
      centerTitle: true,
      actions: [
        //open printer page
        IconButton(
          onPressed: () {
            Get.to(const MakePdfClients(), transition: Transition.zoom);
          },
          icon: SvgPicture.asset("assets/icons/reports.svg", height: 25.h),
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
        child: GestureDetector(
          onTap: () {
            Get.to(
              const SearchCustomersScreen(),
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
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    "Search Customer Name - Phone",
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
        ));
  }

  _buildBody() {
    return Column(
      children: [
        // _buildSearchBar(),
        SizedBox(height: 25.h),
        Expanded(child: TableCustomer()),
      ],
    );
  }
}
