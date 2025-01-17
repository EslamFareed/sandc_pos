import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart' as getx;
import 'package:sandc_pos/core/components/app_language.dart';

import '../../../core/style/color/app_colors.dart';
import '../../../core/style/text/app_text_style.dart';
import '../../../cubits/sales_report_cubit/sales_report_cubit.dart';

import 'make_pdf_report_sales.dart';
import 'scan_code_report_sales.dart';
import 'search_orders_sales_report.dart';
import 'table_sales_report.dart';

class SalesReport extends StatefulWidget {
  const SalesReport({Key? key}) : super(key: key);

  @override
  State<SalesReport> createState() => _SalesReportState();
}

class _SalesReportState extends State<SalesReport> {
  TextEditingController? controller = TextEditingController();

  @override
  void initState() {
    SalesReportCubit.get(context).dateFilterone = DateTime.now();
    SalesReportCubit.get(context).chooseDateOne(DateTime.now());

    SalesReportCubit.get(context).dateFiltertwo = DateTime.now();
    SalesReportCubit.get(context).chooseDateTwo(DateTime.now());

    SalesReportCubit.get(context).getOrders(context);

    super.initState();
  }

  _buildAppBar(SalesReportCubit cubit) {
    return AppBar(
      title: Text(getLang(context).salesReport),
      centerTitle: true,
      actions: [
        IconButton(
          onPressed: () {
            getx.Get.dialog(Dialog(
              child: Container(
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.all(10),
                width: getx.Get.width * .7,
                height: getx.Get.height * .4,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      getLang(context).chooseDateStartandend,
                      style: AppTextStyle.appBarText().copyWith(fontSize: 16),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(getLang(context).from),
                        GestureDetector(
                          onTap: () {
                            DatePicker.showDatePicker(context,
                                showTitleActions: true,
                                minTime: DateTime(2022, 1, 1),
                                maxTime: DateTime.now(), onChanged: (date) {
                              cubit.chooseDateOne(date);
                            }, onConfirm: (date) {
                              cubit.chooseDateOne(date);
                            },
                                currentTime: DateTime.now(),
                                locale: LocaleType.en);
                          },
                          child: TextFormField(
                            controller: cubit.dateFilterOneController,
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
                        Text(getLang(context).to),
                        GestureDetector(
                          onTap: () {
                            DatePicker.showDatePicker(context,
                                showTitleActions: true,
                                minTime: cubit.dateFilterone,
                                maxTime: DateTime.now(), onChanged: (date) {
                              cubit.chooseDateTwo(date);
                            }, onConfirm: (date) {
                              cubit.chooseDateTwo(date);
                            },
                                currentTime: DateTime.now(),
                                locale: LocaleType.en);
                          },
                          child: TextFormField(
                            controller: cubit.dateFilterTwoController,
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
                                  cubit.filterOrdersByDate();
                                  getx.Get.back();
                                },
                                child: Text(getLang(context).save))),
                        const Spacer(),
                        Expanded(
                            child: ElevatedButton(
                                onPressed: () {
                                  getx.Get.back();
                                },
                                child: Text(getLang(context).cancel))),
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
            getx.Get.to(
                MakePdfReportSales(
                    list: cubit.ordersReport, total: cubit.total),
                transition: getx.Transition.zoom);
          },
          icon: SvgPicture.asset("assets/icons/reports.svg", height: 25.h),
        ),
      ],
    );
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
          appBar: _buildAppBar(cubit),
          body: _buildBody(cubit),
          // floatingActionButton: _buildFAB(context, cubit),
        );
      },
    );
  }

  // _buildFAB(BuildContext context, SalesReportCubit cubit) {
  //   return FloatingActionButton(
  //     child: const Icon(
  //       Icons.arrow_circle_up,
  //       size: 50,
  //     ),
  //     onPressed: () {
  //       _buildBottom(context, cubit);
  //     },
  //   );
  // }

  // _buildBottom(BuildContext context, SalesReportCubit cubit) {
  //   getx.Get.dialog(
  //     Dialog(
  //       insetAnimationDuration: const Duration(milliseconds: 100),
  //       alignment: Alignment.bottomCenter,
  //       shape: RoundedRectangleBorder(
  //         borderRadius: BorderRadius.circular(18.0),
  //       ),
  //       child: SizedBox(
  //         width: getx.Get.width * .8,
  //         height: getx.Get.height * .25,
  //         child: Column(
  //           mainAxisAlignment: MainAxisAlignment.spaceAround,
  //           children: [
  //             Container(
  //               alignment: Alignment.topRight,
  //               child: IconButton(
  //                 onPressed: () {
  //                   getx.Get.back();
  //                 },
  //                 icon: const Icon(
  //                   Icons.exit_to_app,
  //                   size: 30,
  //                 ),
  //               ),
  //             ),
  //             Text(
  //               "${getLang(context).total} = ${cubit.total}",
  //               style: AppTextStyle.headLine(),
  //             ),
  //           ],
  //         ),
  //       ),
  //     ),
  //     barrierDismissible: false,
  //   );
  // }

  _buildSearchBar(SalesReportCubit cubit) {
    return Container(
      width: getx.Get.width,
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
                getx.Get.to(
                  SearchOrdersSalesReportScreen(),
                  transition: getx.Transition.fadeIn,
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
                    children: [
                      Text(
                        getLang(context).searchOrders,
                        style: const TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Icon(
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
          // IconButton(
          //   icon: const Icon(
          //     Icons.qr_code_scanner,
          //     color: Colors.white,
          //     size: 30,
          //   ),
          //   onPressed: () {
          //     getx.Get.to(const ScanCodeReportSalesScreen(),
          //         transition: getx.Transition.zoom);
          //   },
          // ),
        ],
      ),
    );
  }

  _buildBody(SalesReportCubit cubit) {
    return Column(
      children: [
        _buildSearchBar(cubit),
        Expanded(child: TableSalesReport()),
      ],
    );
  }
}
