import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sandc_pos/cubits/data_cubit/data_cubit.dart';
import 'package:sandc_pos/models/order.dart';
import 'package:sandc_pos/models/products.dart';
import 'package:uuid/uuid.dart';

import '../../models/invoice_details.dart';

class SearchOrdersSalesReportScreen extends StatefulWidget {
  SearchOrdersSalesReportScreen({Key? key}) : super(key: key);

  @override
  State<SearchOrdersSalesReportScreen> createState() =>
      _SearchOrdersSalesReportScreenState();
}

class _SearchOrdersSalesReportScreenState
    extends State<SearchOrdersSalesReportScreen> {
  TextEditingController? controller = TextEditingController();

  List<OrderModel> orders = [];

  @override
  void initState() {
    orders = DataCubit.get(context).orderModels;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                searchProducts(value, context);
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
                  itemCount: orders.length,
                  itemBuilder: (ctx, i) => _buildItemSearch(orders[i])))
        ],
      ),
    );
  }

  _buildItemSearch(OrderModel order) {
    return Card(
      child: ListTile(
        onTap: () {
          // if (DataCubit.get(context).productsCurrentOrder.contains(product)) {
          //   DataCubit.get(context).addQuantityProdcut(product, context);
          // } else {
          //   DataCubit.get(context).addNewProduct(product, context);
          // }
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

  void searchProducts(String query, BuildContext context) {
    final ordersSearched = DataCubit.get(context).orderModels.where((element) {
      final orderReciet = element.id!.toLowerCase();
      final input = query.toLowerCase();

      return orderReciet.contains(input);
    });
    setState(() {
      orders = ordersSearched.toList();
    });
  }
}
