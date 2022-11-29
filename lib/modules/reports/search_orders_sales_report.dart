import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart' as getx;
import 'package:sandc_pos/online_models/order_response_model.dart';

import '../../cubits/sales_report_cubit/sales_report_cubit.dart';
import 'order_details.dart';

class SearchOrdersSalesReportScreen extends StatefulWidget {
  SearchOrdersSalesReportScreen({Key? key}) : super(key: key);

  @override
  State<SearchOrdersSalesReportScreen> createState() =>
      _SearchOrdersSalesReportScreenState();
}

class _SearchOrdersSalesReportScreenState
    extends State<SearchOrdersSalesReportScreen> {
  TextEditingController? controller = TextEditingController();

  @override
  void initState() {
    // orders = DataCubit.get(context).orderModels;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SalesReportCubit, SalesReportState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit = SalesReportCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text("Search By reciet no"),
          ),
          body: Column(
            children: [
              Container(
                margin: const EdgeInsets.all(20),
                child: TextField(
                  controller: controller,
                  onChanged: (value) {
                    cubit.searchOrders(value, context);
                  },
                  decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.search),
                      hintText: "reciet no",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: const BorderSide(color: Colors.black))),
                ),
              ),
              Expanded(
                  child: ListView.builder(
                      itemCount: cubit.ordersSearchQuery.length,
                      itemBuilder: (ctx, i) =>
                          _buildItemSearch(cubit.ordersSearchQuery[i])))
            ],
          ),
        );
      },
    );
  }

  _buildItemSearch(OrderResponseModel order) {
    return Card(
      child: ListTile(
        onTap: () {
          getx.Get.to(OrderDetailsScreen(item: order),
              transition: getx.Transition.zoom);
        },
        title: Text(order.id!),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text("total cost : ${order.totalCost!}"),
            Text("date : ${order.createDate!}"),
          ],
        ),
      ),
    );
  }
}
