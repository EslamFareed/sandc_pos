// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:sandc_pos/cubits/data_cubit/data_cubit.dart';
// import 'package:sandc_pos/online_models/order_response_model.dart';

// import 'package:uuid/uuid.dart';

// class SearchOrdersSalesReturnScreen extends StatefulWidget {
//   SearchOrdersSalesReturnScreen({Key? key}) : super(key: key);

//   @override
//   State<SearchOrdersSalesReturnScreen> createState() =>
//       _SearchOrdersSalesReturnScreenState();
// }

// class _SearchOrdersSalesReturnScreenState
//     extends State<SearchOrdersSalesReturnScreen> {
//   TextEditingController? controller = TextEditingController();

//   List<OrderResponseModel> orders = [];

//   @override
//   void initState() {
//     // orders = DataCubit.get(context).orderModels;
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         title: Text("Search By reciet no"),
//       ),
//       body: Column(
//         children: [
//           Container(
//             margin: const EdgeInsets.all(20),
//             child: TextField(
//               controller: controller,
//               onChanged: (value) {
//                 searchProducts(value, context);
//               },
//               decoration: InputDecoration(
//                   prefixIcon: const Icon(Icons.search),
//                   hintText: "reciet no",
//                   border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(20),
//                       borderSide: const BorderSide(color: Colors.black))),
//             ),
//           ),
//           Expanded(
//               child: ListView.builder(
//                   itemCount: orders.length,
//                   itemBuilder: (ctx, i) => _buildItemSearch(orders[i])))
//         ],
//       ),
//     );
//   }

//   _buildItemSearch(OrderResponseModel order) {
//     return Card(
//       child: ListTile(
//         onTap: () {
//           // if (DataCubit.get(context).productsCurrentOrder.contains(product)) {
//           //   DataCubit.get(context).addQuantityProdcut(product, context);
//           // } else {
//           //   DataCubit.get(context).addNewProduct(product, context);
//           // }
//         },
//         title: Text(order.id!),
//         subtitle: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: [
//             Text("total cost : ${order.totalCost!}"),
//             Text("date : ${order.createDate!}"),
//           ],
//         ),
//       ),
//     );
//   }

//   void searchProducts(String query, BuildContext context) {
//     // final ordersSearched = DataCubit.get(context).orderModels.where((element) {
//     //   final orderReciet = element.id!.toLowerCase();
//     //   final input = query.toLowerCase();

//     //   return orderReciet.contains(input);
//     // });
//     // setState(() {
//     //   orders = ordersSearched.toList();
//     // });
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart' as getx;
import 'package:sandc_pos/modules/sales_returns/sales_return_details.dart';
import 'package:sandc_pos/online_models/order_response_model.dart';

import '../../cubits/sales_report_cubit/sales_report_cubit.dart';
import '../../cubits/sales_returns_cubit/sales_returns_cubit.dart';

class SearchSalesReturnsReportScreen extends StatefulWidget {
  SearchSalesReturnsReportScreen({Key? key}) : super(key: key);

  @override
  State<SearchSalesReturnsReportScreen> createState() =>
      _SearchSalesReturnsReportScreenState();
}

class _SearchSalesReturnsReportScreenState
    extends State<SearchSalesReturnsReportScreen> {
  TextEditingController? controller = TextEditingController();

  @override
  void initState() {
    // orders = DataCubit.get(context).orderModels;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SalesReturnsCubit, SalesReturnsState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit = SalesReturnsCubit.get(context);
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
          getx.Get.to(SalesDetailsScreen(item: order),
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
