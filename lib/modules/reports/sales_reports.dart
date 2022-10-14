import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sandc_pos/core/style/color/app_colors.dart';
import 'package:sandc_pos/layouts/main_screen.dart';
import 'package:sandc_pos/models/order.dart';
import 'package:sandc_pos/modules/reports/make_pdf_report_sales.dart';
import 'package:sandc_pos/modules/reports/table_sales_report.dart';
import 'package:sandc_pos/modules/sales/categories_screen.dart';
import 'package:sandc_pos/modules/sales/scan_code.dart';
import 'package:sandc_pos/modules/sales/search_products.dart';
import 'package:uuid/uuid.dart';

import '../../core/components/build_popup.dart';
import '../../core/components/default_buttons.dart';
import '../../core/style/text/app_text_style.dart';
import '../../cubits/data_cubit/data_cubit.dart';
import '../sales/table_sales.dart';
import 'scan_code_report_sales.dart';
import 'search_orders_sales_report.dart';

class SalesReport extends StatefulWidget {
  const SalesReport({Key? key}) : super(key: key);

  @override
  State<SalesReport> createState() => _SalesReportState();
}

class _SalesReportState extends State<SalesReport> {
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

  List<OrderModel> orders = [
    OrderModel(
      clientID: 1,
      totalCost: 1500,
      createDate: "2022-2-10",
      id: Uuid().v1(),
    ),
    OrderModel(
      clientID: 1,
      totalCost: 1500,
      createDate: "2022-2-10",
      id: Uuid().v1(),
    ),
    OrderModel(
      clientID: 1,
      totalCost: 1500,
      createDate: "2022-2-10",
      id: Uuid().v1(),
    ),
  ];

  _buildAppBar() {
    return AppBar(
      title: Text("Sales Report"),
      centerTitle: true,
      actions: [
        IconButton(
          onPressed: () {
            Get.dialog(Dialog(
              child: Container(
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.all(10),
                width: Get.width * .7,
                height: Get.height * .4,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      "Choose Date Start and end",
                      style: AppTextStyle.appBarText().copyWith(fontSize: 16),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("From"),
                        GestureDetector(
                          onTap: () {
                            DatePicker.showDatePicker(context,
                                showTitleActions: true,
                                minTime: DateTime(2022, 1, 1),
                                maxTime: DateTime.now(), onChanged: (date) {
                              setState(() {
                                dateFilterone = date.toString();
                                dateFilterOneController!.text = dateFilterone!;
                              });
                            }, onConfirm: (date) {
                              setState(() {
                                dateFilterone = date.toString();
                                dateFilterOneController!.text = dateFilterone!;
                              });
                            },
                                currentTime: DateTime.now(),
                                locale: LocaleType.en);
                          },
                          child: TextFormField(
                            controller: dateFilterOneController,
                            enabled: false,
                            decoration: const InputDecoration(
                                prefixIcon: Icon(Icons.date_range)),
                          ),
                        )
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("To"),
                        GestureDetector(
                          onTap: () {
                            DatePicker.showDatePicker(context,
                                showTitleActions: true,
                                minTime: DateTime(2022, 1, 1),
                                maxTime: DateTime.now(), onChanged: (date) {
                              setState(() {
                                dateFiltertwo = date.toString();
                                dateFilterTwoController!.text = dateFiltertwo!;
                              });
                            }, onConfirm: (date) {
                              setState(() {
                                dateFiltertwo = date.toString();
                                dateFilterTwoController!.text = dateFiltertwo!;
                              });
                            },
                                currentTime: DateTime.now(),
                                locale: LocaleType.en);
                          },
                          child: TextFormField(
                            controller: dateFilterTwoController,
                            enabled: false,
                            decoration: const InputDecoration(
                                prefixIcon: Icon(Icons.date_range)),
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                            child: ElevatedButton(
                                onPressed: () {
                                  Get.back();
                                },
                                child: Text("Save"))),
                        const Spacer(),
                        Expanded(
                            child: ElevatedButton(
                                onPressed: () {
                                  Get.back();
                                },
                                child: Text("Cancel"))),
                      ],
                    )
                  ],
                ),
              ),
            ));
          },
          icon: Icon(Icons.filter_alt),
        ),
        IconButton(
          onPressed: () {
            Get.to(MakePdfReportSales(list: orders),
                transition: Transition.zoom);
          },
          icon: SvgPicture.asset("assets/icons/reports.svg", height: 25.h),
        ),
      ],
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
                  SearchOrdersSalesReportScreen(),
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
              Get.to(const ScanCodeReportSalesScreen(),
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
        Expanded(child: TableSalesReport()),
      ],
    );
  }
}
