// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:horizontal_data_table/horizontal_data_table.dart';

// import 'package:sandc_pos/core/components/default_buttons.dart';
// import 'package:sandc_pos/core/style/color/app_colors.dart';
// import 'package:sandc_pos/cubits/data_cubit/data_cubit.dart';
// import 'package:sandc_pos/online_models/order_response_model.dart';
// import 'package:uuid/uuid.dart';

// class ItemModel {
//   String title;
//   IconData icon;
//   void onPress;

//   ItemModel(this.title, this.icon, this.onPress);
// }

// class TableSalesReturns extends StatefulWidget {
//   TableSalesReturns({Key? key}) : super(key: key);

//   @override
//   State<TableSalesReturns> createState() => _TableSalesReturnsState();
// }

// class _TableSalesReturnsState extends State<TableSalesReturns> {
//   List<OrderResponseModel> orders = [
//     OrderResponseModel(
//       clientID: "1",
//       totalCost: 1500,
//       createDate: "2022-2-10",
//       id: Uuid().v1(),
//     ),
//     OrderResponseModel(
//       clientID: "1",
//       totalCost: 1500,
//       createDate: "2022-2-10",
//       id: Uuid().v1(),
//     ),
//     OrderResponseModel(
//       clientID: "1",
//       totalCost: 1500,
//       createDate: "2022-2-10",
//       id: Uuid().v1(),
//     ),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return HorizontalDataTable(
//       leftHandSideColumnWidth: Get.width * .30,
//       rightHandSideColumnWidth: Get.width * .70,
//       isFixedHeader: true,
//       headerWidgets: _getTitleWidget(),
//       leftSideItemBuilder: _generateFirstColumnRow,
//       rightSideItemBuilder: _generateRightHandSideColumnRow,
//       itemCount: orders.length,
//       rowSeparatorWidget: const Divider(
//         color: Colors.black54,
//         height: 1.0,
//         thickness: 0.0,
//       ),
//       leftHandSideColBackgroundColor: const Color(0xFFFFFFFF),
//       rightHandSideColBackgroundColor: const Color(0xFFFFFFFF),
//     );
//   }

//   List<Widget> _getTitleWidget() {
//     return [
//       _getTitleItemWidget('Reciet No', Get.width * .30),
//       _getTitleItemWidget('Client Name', Get.width * .30),
//       _getTitleItemWidget('date', Get.width * .20),
//       _getTitleItemWidget('Total', Get.width * .20),
//     ];
//   }

//   Widget _getTitleItemWidget(String label, double width) {
//     return Container(
//       width: width,
//       height: 56,
//       color: AppColors.primaryColor,
//       padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
//       alignment: Alignment.centerLeft,
//       child: Text(label,
//           style: const TextStyle(
//               fontWeight: FontWeight.bold, color: Colors.white)),
//     );
//   }

//   Widget _generateFirstColumnRow(BuildContext context, int index) {
//     return Container(
//       width: Get.width * .30,
//       height: 52.h,
//       padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
//       alignment: Alignment.centerLeft,
//       child: Text(
//         orders[index].id!,
//         overflow: TextOverflow.ellipsis,
//       ),
//     );
//   }

//   Widget _generateRightHandSideColumnRow(BuildContext context, int index) {
//     return Row(
//       children: [
//         Container(
//           width: Get.width * .30,
//           height: 52.h,
//           padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
//           alignment: Alignment.centerLeft,
//           child: Text("Eslam Fareed"),
//         ),
//         Container(
//           width: Get.width * .20,
//           height: 52.h,
//           padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
//           alignment: Alignment.centerLeft,
//           child: Text("${orders[index].createDate}"),
//         ),
//         Container(
//           width: Get.width * .20,
//           height: 52.h,
//           padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
//           alignment: Alignment.centerLeft,
//           child: Text("${orders[index].totalCost}"),
//         ),
//       ],
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart' as getx;
import 'package:horizontal_data_table/horizontal_data_table.dart';

import 'package:sandc_pos/core/style/color/app_colors.dart';
import 'package:sandc_pos/cubits/data_cubit/data_cubit.dart';
import 'package:sandc_pos/modules/sales_returns/sales_return_details.dart';

import '../../cubits/sales_report_cubit/sales_report_cubit.dart';
import '../../cubits/sales_returns_cubit/sales_returns_cubit.dart';

class ItemModel {
  String title;
  IconData icon;
  void onPress;

  ItemModel(this.title, this.icon, this.onPress);
}

class TableSalesReturns extends StatefulWidget {
  TableSalesReturns({Key? key}) : super(key: key);

  @override
  State<TableSalesReturns> createState() => _TableSalesReturnsState();
}

class _TableSalesReturnsState extends State<TableSalesReturns> {
  @override
  Widget build(BuildContext context) {
    return HorizontalDataTable(
      leftHandSideColumnWidth: getx.Get.width * .30,
      rightHandSideColumnWidth: getx.Get.width * .70,
      isFixedHeader: true,
      headerWidgets: _getTitleWidget(),
      leftSideItemBuilder: _generateFirstColumnRow,
      rightSideItemBuilder: _generateRightHandSideColumnRow,
      itemCount: SalesReturnsCubit.get(context).ordersReport.length,
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
      _getTitleItemWidget('Reciet No', getx.Get.width * .30),
      _getTitleItemWidget('Client Name', getx.Get.width * .30),
      _getTitleItemWidget('date', getx.Get.width * .20),
      _getTitleItemWidget('Total', getx.Get.width * .20),
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
    return GestureDetector(
      onTap: () {
        getx.Get.to(
            SalesDetailsScreen(
                item: SalesReturnsCubit.get(context).ordersReport[index]),
            transition: getx.Transition.zoom);
      },
      child: Container(
        width: getx.Get.width * .30,
        height: 52.h,
        padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
        alignment: Alignment.centerLeft,
        child: Text(
          SalesReturnsCubit.get(context).ordersReport[index].id!,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }

  Widget _generateRightHandSideColumnRow(BuildContext context, int index) {
    return GestureDetector(
      onTap: () {
        getx.Get.to(
            SalesDetailsScreen(
                item: SalesReturnsCubit.get(context).ordersReport[index]),
            transition: getx.Transition.zoom);
      },
      child: Row(
        children: [
          Container(
            width: getx.Get.width * .30,
            height: 52.h,
            padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
            alignment: Alignment.centerLeft,
            child: DataCubit.get(context)
                    .clientModels
                    .where((element) =>
                        element.id ==
                        SalesReturnsCubit.get(context)
                            .ordersReport[index]
                            .clientID)
                    .isEmpty
                ? Container()
                : Text(DataCubit.get(context)
                    .clientModels
                    .where((element) =>
                        element.id ==
                        SalesReturnsCubit.get(context)
                            .ordersReport[index]
                            .clientID)
                    .first
                    .name!),
          ),
          Container(
            width: getx.Get.width * .20,
            height: 52.h,
            padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
            alignment: Alignment.centerLeft,
            child: Text(
              "${SalesReturnsCubit.get(context).ordersReport[index].createDate}",
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Container(
            width: getx.Get.width * .20,
            height: 52.h,
            padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
            alignment: Alignment.centerLeft,
            child: Text(
                "${SalesReturnsCubit.get(context).ordersReport[index].totalCost}"),
          ),
        ],
      ),
    );
  }
}
