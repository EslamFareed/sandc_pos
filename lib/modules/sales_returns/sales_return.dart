import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sandc_pos/core/style/color/app_colors.dart';
import 'package:sandc_pos/modules/reports/make_pdf_report_sales.dart';
import 'package:sandc_pos/modules/reports/table_sales_report.dart';
import 'package:sandc_pos/modules/sales/search_products.dart';
import 'package:sandc_pos/modules/sales_returns/search_orders_sales_return.dart';
import 'package:sandc_pos/modules/sales_returns/table_sales_returns.dart';
import 'package:sandc_pos/online_models/order_response_model.dart';
import 'package:uuid/uuid.dart';

import '../../core/style/text/app_text_style.dart';
import '../../cubits/data_cubit/data_cubit.dart';
import 'scan_code_sales_return.dart';

class SalesReturnsScreen extends StatefulWidget {
  const SalesReturnsScreen({Key? key}) : super(key: key);

  @override
  State<SalesReturnsScreen> createState() => _SalesReturnsScreenState();
}

class _SalesReturnsScreenState extends State<SalesReturnsScreen> {
  TextEditingController? controller = TextEditingController();
  TextEditingController? dateFilterOneController = TextEditingController();
  TextEditingController? dateFilterTwoController = TextEditingController();

  String? dateFilterone;
  String? dateFiltertwo;

  @override
  void initState() {
    setState(() {
      dateFilterone = DateTime.now().toString();
      dateFiltertwo = DateTime.now().toString();
      dateFilterOneController!.text = dateFilterone!;
      dateFilterTwoController!.text = dateFiltertwo!;
    });

    // DataCubit.get(context).itemsCurrentOrder = [];
    // DataCubit.get(context).productsCurrentOrder = [];
    // DataCubit.get(context).currentOrder = OrderModel(id: Uuid().v1());
    super.initState();
  }

  List<OrderResponseModel> orders = [
    OrderResponseModel(
      clientID: "1",
      totalCost: 1500,
      createDate: "2022-2-10",
      id: Uuid().v1(),
    ),
    OrderResponseModel(
      clientID: "1",
      totalCost: 1500,
      createDate: "2022-2-10",
      id: Uuid().v1(),
    ),
    OrderResponseModel(
      clientID: "1",
      totalCost: 1500,
      createDate: "2022-2-10",
      id: Uuid().v1(),
    ),
  ];

  _buildAppBar() {
    return AppBar(
      title: Text("Sales Returns"),
      centerTitle: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
      floatingActionButton: _buildFAB(context),
    );
  }

  _buildFAB(BuildContext context) {
    return FloatingActionButton(
      child: const Icon(
        Icons.arrow_circle_up,
        size: 50,
      ),
      onPressed: () {
        _buildBottom(context);
      },
    );
  }

  _buildBottom(BuildContext context) {
    double total = 0;
    for (var element in orders) {
      total += element.totalCost!;
    }
    Get.dialog(
      Dialog(
        insetAnimationDuration: const Duration(milliseconds: 100),
        alignment: Alignment.bottomCenter,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18.0),
        ),
        child: SizedBox(
          width: Get.width * .8,
          height: Get.height * .25,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                alignment: Alignment.topRight,
                child: IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: const Icon(
                    Icons.exit_to_app,
                    size: 30,
                  ),
                ),
              ),
              Text(
                "Total = $total",
                style: AppTextStyle.headLine(),
              ),
            ],
          ),
        ),
      ),
      barrierDismissible: false,
    );
  }

  _buildSearchBar() {
    return Container(
      width: Get.width,
      margin: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.primaryColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          //open search
          Expanded(
            child: GestureDetector(
              onTap: () {
                Get.to(
                  SearchOrdersSalesReturnScreen(),
                  transition: Transition.fadeIn,
                );
              },
              child: Container(
                margin: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        "Search Orders",
                        style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Icon(
                        Icons.search,
                        color: Colors.grey,
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          //open camera scanner
          IconButton(
            icon: const Icon(
              Icons.qr_code_scanner,
              color: Colors.white,
              size: 30,
            ),
            onPressed: () {
              Get.to(const ScanCodeSalesReturnScreen(),
                  transition: Transition.zoom);
            },
          ),
        ],
      ),
    );
  }

  _buildBody() {
    return Column(
      children: [
        _buildSearchBar(),
        Expanded(child: TableSalesReturns()),
      ],
    );
  }
}
