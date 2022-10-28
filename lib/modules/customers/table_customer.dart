import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';

import 'package:sandc_pos/core/style/color/app_colors.dart';
import 'package:sandc_pos/cubits/data_cubit/data_cubit.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart' as tran;
import 'view_customer_details.dart';

class TableCustomer extends StatefulWidget {
  TableCustomer({Key? key}) : super(key: key);

  @override
  State<TableCustomer> createState() => _TableCustomerState();
}

class _TableCustomerState extends State<TableCustomer> {
  @override
  void initState() {
    _getData();
    super.initState();
  }

  _getData() async {
    // await DataCubit.get(context).getAllClientTable();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DataCubit, DataState>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = DataCubit.get(context);
          return
              // cubit.clientModels.isNotEmpty &&
              //         state is GetAllClientTableSuccess
              //     ? HorizontalDataTable(
              //         leftHandSideColumnWidth: Get.width * .5,
              //         rightHandSideColumnWidth: Get.width * .5,
              //         isFixedHeader: true,
              //         headerWidgets: _getTitleWidget(),
              //         // refreshIndicator: RefreshProgressIndicator(),
              //         // htdRefreshController: HDTRefreshController(),
              //         // onRefresh: () {},
              //         // enablePullToRefresh: true,
              //         leftSideItemBuilder: _generateFirstColumnRow,
              //         rightSideItemBuilder: _generateRightHandSideColumnRow,
              //         itemCount: cubit.clientModels.length,
              //         rowSeparatorWidget: const Divider(
              //           color: Colors.black54,
              //           height: 1.0,
              //           thickness: 0.0,
              //         ),
              //         leftHandSideColBackgroundColor: const Color(0xFFFFFFFF),
              //         rightHandSideColBackgroundColor: const Color(0xFFFFFFFF),
              //       )
              //     :
              const Scaffold(
            body: Center(
              child: Text("No items found.."),
            ),
          );
        });
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
          Get.to(ViewCustomerDetails(), transition: tran.Transition.zoom);
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // Icon(Icons.info),
            SizedBox(width: 5.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      // DataCubit.get(context).clientModels[index].name!,
                      "",
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      // DataCubit.get(context).clientModels[index].phone!,
                      "",
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
          // child: Text(
          //     "${DataCubit.get(context).clientModels[index].ammountTobePaid!}"),
        ),
        Container(
          width: Get.width * .25,
          height: 52.h,
          padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.centerLeft,
          // child: Text(
          //     "${DataCubit.get(context).clientModels[index].maxDebitLimit!}"),
        ),
      ],
    );
  }
}
