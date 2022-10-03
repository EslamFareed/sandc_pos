import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'dart:io';
import 'package:horizontal_data_table/horizontal_data_table.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sandc_pos/core/style/color/app_colors.dart';
import 'package:sandc_pos/models/order_item.dart';
import 'package:sandc_pos/models/product.dart';

class TableSales extends StatelessWidget {
  TableSales({Key? key}) : super(key: key);

  // List<Product> products = [
  //   Product(id: 1, name: "Samsung a21s", price: 5500),
  //   Product(id: 2, name: "shoes", price: 500),
  //   Product(id: 3, name: "pepsi", price: 5),
  //   Product(id: 4, name: "mouse", price: 150),
  // ];
  List<OrderItem> items = [
    OrderItem(
        id: 1,
        product: Product(id: 1, name: "Samsung a21s", price: 5500),
        quantity: 1,
        total: 5500),
    OrderItem(
        id: 2,
        product: Product(id: 2, name: "shoes", price: 500),
        quantity: 5,
        total: 2500),
    OrderItem(
        id: 3,
        product: Product(id: 3, name: "pepsi", price: 5),
        quantity: 2,
        total: 10),
    OrderItem(
        id: 1,
        product: Product(id: 1, name: "Samsung a21s", price: 5500),
        quantity: 1,
        total: 5500),
    OrderItem(
        id: 2,
        product: Product(id: 2, name: "shoes", price: 500),
        quantity: 5,
        total: 2500),
    OrderItem(
        id: 3,
        product: Product(id: 3, name: "pepsi", price: 5),
        quantity: 2,
        total: 10),
    OrderItem(
        id: 1,
        product: Product(id: 1, name: "Samsung a21s", price: 5500),
        quantity: 1,
        total: 5500),
    OrderItem(
        id: 2,
        product: Product(id: 2, name: "shoes", price: 500),
        quantity: 5,
        total: 2500),
    OrderItem(
        id: 3,
        product: Product(id: 3, name: "pepsi", price: 5),
        quantity: 2,
        total: 10),
    OrderItem(
        id: 1,
        product: Product(id: 1, name: "Samsung a21s", price: 5500),
        quantity: 1,
        total: 5500),
    OrderItem(
        id: 2,
        product: Product(id: 2, name: "shoes", price: 500),
        quantity: 5,
        total: 2500),
    OrderItem(
        id: 3,
        product: Product(id: 3, name: "pepsi", price: 5),
        quantity: 2,
        total: 10),
  ];
  @override
  Widget build(BuildContext context) {
    return HorizontalDataTable(
      leftHandSideColumnWidth: Get.width * .40,
      rightHandSideColumnWidth: Get.width * .60,
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
      _getTitleItemWidget('Product', Get.width * .40),
      _getTitleItemWidget('Price', Get.width * .20),
      _getTitleItemWidget('Quantity', Get.width * .20),
      _getTitleItemWidget('Total', Get.width * .20),
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
      width: Get.width * .40,
      height: 52.h,
      padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
      alignment: Alignment.centerLeft,
      child: Text(items[index].product!.name!),
    );
  }

  Widget _generateRightHandSideColumnRow(BuildContext context, int index) {
    return Row(
      children: [
        Container(
          width: Get.width * .20,
          height: 52.h,
          padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.centerLeft,
          child: Text("${items[index].product!.price!}"),
        ),
        Container(
          width: Get.width * .20,
          height: 52.h,
          padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.centerLeft,
          child: Text("${items[index].quantity!}"),
        ),
        Container(
          width: Get.width * .20,
          height: 52.h,
          padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.centerLeft,
          child: Text("${items[index].total!}"),
        ),
      ],
    );
  }
}
