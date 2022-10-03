import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'dart:io';
import 'package:horizontal_data_table/horizontal_data_table.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sandc_pos/core/style/color/app_colors.dart';
import 'package:sandc_pos/models/customer.dart';
import 'package:sandc_pos/models/order_item.dart';
import 'package:sandc_pos/models/product.dart';

import 'view_customer_details.dart';

class TableCustomer extends StatelessWidget {
  TableCustomer({Key? key}) : super(key: key);

  List<Customer> items = [
    Customer(
        amountRest: 100,
        maxDepit: 1000,
        name: "eslam fareed abd alrahman ",
        phone: "+201016361173"),
    Customer(
        amountRest: 500,
        maxDepit: 5000,
        name: "احمد ممدوح اكرام",
        phone: "+905454564"),
    Customer(
        amountRest: 50,
        maxDepit: 100,
        name: "eslam fareed abd alrahman",
        phone: "+201016361173"),
  ];
  @override
  Widget build(BuildContext context) {
    return HorizontalDataTable(
      leftHandSideColumnWidth: Get.width * .5,
      rightHandSideColumnWidth: Get.width * .5,
      isFixedHeader: true,
      headerWidgets: _getTitleWidget(),
      // refreshIndicator: RefreshProgressIndicator(),
      // htdRefreshController: HDTRefreshController(),
      // onRefresh: () {},
      // enablePullToRefresh: true,
      leftSideItemBuilder: _generateFirstColumnRow,
      rightSideItemBuilder: _generateRightHandSideColumnRow,
      itemCount: items.length,
      rowSeparatorWidget: const Divider(
        color: Colors.black54,
        height: 1.0,
        thickness: 0.0,
      ),
      leftHandSideColBackgroundColor: const Color(0xFFFFFFFF),
      rightHandSideColBackgroundColor: const Color(0xFFFFFFFF),
    );
  }

  List<Widget> _getTitleWidget() {
    return [
      _getTitleItemWidget('Customer', Get.width * .5),
      _getTitleItemWidget('Amount Rest', Get.width * .25),
      _getTitleItemWidget('Max Depit', Get.width * .25),
    ];
  }

  Widget _getTitleItemWidget(String label, double width) {
    return Container(
      width: width,
      height: 56,
      color: AppColors.primaryColor,
      padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
      alignment: Alignment.centerLeft,
      child: Text(label,
          style: const TextStyle(
              fontWeight: FontWeight.bold, color: Colors.white)),
    );
  }

  Widget _generateFirstColumnRow(BuildContext context, int index) {
    return Container(
      width: Get.width * .5,
      height: 52.h,
      padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
      alignment: Alignment.centerLeft,
      child: GestureDetector(
        onTap: () {
          Get.to(ViewCustomerDetails(), transition: Transition.zoom);
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(Icons.info),
            SizedBox(width: 5.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      items[index].name!,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      items[index].phone!,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _generateRightHandSideColumnRow(BuildContext context, int index) {
    return Row(
      children: [
        Container(
          width: Get.width * .25,
          height: 52.h,
          padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.centerLeft,
          child: Text("${items[index].amountRest!}"),
        ),
        Container(
          width: Get.width * .25,
          height: 52.h,
          padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.centerLeft,
          child: Text("${items[index].maxDepit!}"),
        ),
      ],
    );
  }
}
