import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sandc_pos/cubits/sales_report_cubit/sales_report_cubit.dart';
import 'package:sandc_pos/online_models/order_response_model.dart';

class OrderDetailsScreen extends StatelessWidget {
  OrderDetailsScreen({super.key, this.item});
  OrderResponseModel? item;

  @override
  Widget build(BuildContext context) {
    SalesReportCubit.get(context).getOrderDetails(item!.id, context);
    print(item!.id);
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
          body: ListView.builder(
            itemBuilder: (context, index) => Card(
              child: ListTile(
                title: Text(cubit.orderProducts[index].name!),
                subtitle: Text(
                    "${cubit.orderDetails.firstWhere((element) => cubit.orderProducts[index].prodId == element.prodId).quantity}"),
              ),
            ),
            itemCount: cubit.orderProducts.length,
          ),
        );
      },
    );
  }
}
