import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sandc_pos/cubits/sales_report_cubit/sales_report_cubit.dart';
import 'package:sandc_pos/online_models/order_response_model.dart';

import '../home/widgets/item_setting_data.dart';

class OrderDetailsScreen extends StatelessWidget {
  OrderDetailsScreen({super.key, this.item});
  OrderResponseModel? item;

  @override
  Widget build(BuildContext context) {
    SalesReportCubit.get(context).getOrderDetails(item!.id, context);
    return BlocConsumer<SalesReportCubit, SalesReportState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit = SalesReportCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text("${item!.id}"),
          ),
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Container(
              margin: const EdgeInsets.all(20),
              child: Column(
                children: [
                  SizedBox(
                    height: 10.h,
                  ),
                  ItemSettingData(title: "Total", data: "${item!.totalCost}"),
                  ItemSettingData(title: "paid", data: "${item!.payAmount}"),
                  ItemSettingData(title: "debit", data: "${item!.debitPay}"),
                  ItemSettingData(title: "date", data: "${item!.createDate}"),
                  ItemSettingData(title: "taxes", data: "${item!.taxes}"),
                  ItemSettingData(
                      title: "return desc", data: "${item!.returnDesc}"),
                  Text("Products"),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) => Card(
                      child: ListTile(
                        title: Text(cubit.orderProducts[index].name!),
                        subtitle: Text(
                            "${cubit.orderDetails.firstWhere((element) => cubit.orderProducts[index].prodId == element.prodId).quantity}"),
                      ),
                    ),
                    itemCount: cubit.orderProducts.length,
                  ),
                ],
              ),
            ),
          ),

          // body: ListView.builder(
          //   itemBuilder: (context, index) => Card(
          //     child: ListTile(
          //       title: Text(cubit.orderProducts[index].name!),
          //       subtitle: Text(
          //           "${cubit.orderDetails.firstWhere((element) => cubit.orderProducts[index].prodId == element.prodId).quantity}"),
          //     ),
          //   ),
          //   itemCount: cubit.orderProducts.length,
          // ),
        );
      },
    );
  }
}
