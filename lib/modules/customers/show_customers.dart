import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import 'package:sandc_pos/modules/customers/table_customer.dart';

import '../../core/components/app_language.dart';
import 'make_pdf_customer.dart';
import 'search_customers.dart';

class ShowCustomers extends StatelessWidget {
  const ShowCustomers({super.key});

  _buildAppBar(BuildContext context) {
    return AppBar(
      title: Text(getLang(context).clients),
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
      appBar: _buildAppBar(context),
      body: _buildBody(context),
    );
  }

  _buildSearchBar(BuildContext context) {
    return Container(
        width: Get.width,
        height: 50.h,
        margin: const EdgeInsets.all(20),
        child: GestureDetector(
          onTap: () {
            Get.to(
              SearchCustomersScreen(),
              transition: Transition.fadeIn,
            );
          },
          child: Container(
            margin: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 224, 224, 224),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    getLang(context).searchByname,
                    style: const TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Icon(
                    Icons.search,
                    color: Colors.grey,
                  )
                ],
              ),
            ),
          ),
        ));
  }

  _buildBody(BuildContext context) {
    return Column(
      children: [
        _buildSearchBar(context),
        Expanded(child: TableCustomer()),
      ],
    );
  }
}
