import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';

import 'package:sandc_pos/core/style/color/app_colors.dart';
import 'package:sandc_pos/models/order_item.dart';
import 'package:sandc_pos/models/product.dart';

class TableProduct extends StatelessWidget {
  TableProduct({Key? key}) : super(key: key);

  List<Product> items = [
    Product(
        id: 1,
        quantity: 5,
        name: "Camera canon",
        price: 5500,
        image:
            "https://images.pexels.com/photos/90946/pexels-photo-90946.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500"),
    Product(
        id: 2,
        name: "shoes",
        quantity: 2,
        price: 500,
        image:
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ0TSTY64HrvXAHvfJU0-WFcLDAPdMbbWJq5g&usqp=CAU"),
    Product(
        id: 3,
        name: "pepsi",
        quantity: 100,
        price: 5,
        image:
            "https://images.unsplash.com/photo-1612817288484-6f916006741a?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8YmVhdXR5JTIwcHJvZHVjdHN8ZW58MHx8MHx8&w=1000&q=80"),
    Product(
        id: 4,
        name: "mouse",
        quantity: 15,
        price: 150,
        image:
            "https://media.istockphoto.com/photos/set-of-female-skin-care-products-picture-id1306102673?b=1&k=20&m=1306102673&s=170667a&w=0&h=AFA1EYJzIEMh5ww5K2H-dnJoOMWPDa5jAtEnCyD8pxs="),
  ];
  @override
  Widget build(BuildContext context) {
    return HorizontalDataTable(
      leftHandSideColumnWidth: Get.width * .20,
      rightHandSideColumnWidth: Get.width * .80,
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
      _getTitleItemWidget('image', Get.width * .20),
      _getTitleItemWidget('Prodcut', Get.width * .40),
      _getTitleItemWidget('Price', Get.width * .20),
      _getTitleItemWidget('Quantity', Get.width * .20),
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
      width: Get.width * .20,
      height: 52.h,
      padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
      alignment: Alignment.centerLeft,
      child: FadeInImage(
        image: NetworkImage(items[index].image!),
        placeholder: AssetImage("assets/images/logo.png"),
      ),
    );
  }

  Widget _generateRightHandSideColumnRow(BuildContext context, int index) {
    return Row(
      children: [
        Container(
          width: Get.width * .40,
          height: 52.h,
          padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.centerLeft,
          child: Text(items[index].name!),
        ),
        Container(
          width: Get.width * .20,
          height: 52.h,
          padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.centerLeft,
          child: Text("${items[index].price!}"),
        ),
        Container(
          width: Get.width * .20,
          height: 52.h,
          padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.centerLeft,
          child: Text("${items[index].quantity!}"),
        ),
      ],
    );
  }
}
