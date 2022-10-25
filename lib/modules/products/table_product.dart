import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';

import 'package:sandc_pos/core/style/color/app_colors.dart';
import 'package:sandc_pos/models/order_item.dart';
import 'package:sandc_pos/models/product.dart';

import '../../cubits/data_cubit/data_cubit.dart';

class TableProduct extends StatefulWidget {
  TableProduct({Key? key}) : super(key: key);

  @override
  State<TableProduct> createState() => _TableProductState();
}

class _TableProductState extends State<TableProduct> {
  @override
  void initState() {
    _getData();
    super.initState();
  }

  _getData() async {
    await DataCubit.get(context).getAllProductTable();
    DataCubit.get(context).productModels.forEach((element) {
      print(element.prodId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DataCubit, DataState>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = DataCubit.get(context);

          return cubit.productModels.isNotEmpty &&
                  state is GetAllProductTableSuccess
              ? HorizontalDataTable(
                  leftHandSideColumnWidth: Get.width * .20,
                  rightHandSideColumnWidth: Get.width * .80,
                  isFixedHeader: true,
                  headerWidgets: _getTitleWidget(),
                  // refreshIndicator: RefreshProgressIndicator(),
                  // htdRefreshController: HDTRefreshController(),
                  // onRefresh: () {},
                  // enablePullToRefresh: true,
                  leftSideItemBuilder: _generateFirstColumnRow,
                  rightSideItemBuilder: _generateRightHandSideColumnRow,
                  itemCount: cubit.productModels.length,
                  rowSeparatorWidget: const Divider(
                    color: Colors.black54,
                    height: 1.0,
                    thickness: 0.0,
                  ),
                  leftHandSideColBackgroundColor: const Color(0xFFFFFFFF),
                  rightHandSideColBackgroundColor: const Color(0xFFFFFFFF),
                )
              : const Scaffold(
                  body: Center(
                    child: Text("No items found.."),
                  ),
                );
        });
  }

  List<Widget> _getTitleWidget() {
    return [
      _getTitleItemWidget('image', Get.width * .20),
      _getTitleItemWidget('Prodcut', Get.width * .40),
      _getTitleItemWidget('Price', Get.width * .20),
      _getTitleItemWidget('Quantity', Get.width * .20),
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
      width: Get.width * .20,
      height: 52.h,
      padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
      alignment: Alignment.centerLeft,
      child: FadeInImage(
        image: NetworkImage(DataCubit.get(context).productModels[index].image!),
        placeholder: AssetImage("assets/images/logo.png"),
      ),
    );
  }

  Widget _generateRightHandSideColumnRow(BuildContext context, int index) {
    return Row(
      children: [
        Container(
          width: Get.width * .40,
          height: 52.h,
          padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.centerLeft,
          child: Text(DataCubit.get(context).productModels[index].name!),
        ),
        Container(
          width: Get.width * .20,
          height: 52.h,
          padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.centerLeft,
          child:
              Text("${DataCubit.get(context).productModels[index].priceOne!}"),
        ),
        Container(
          width: Get.width * .20,
          height: 52.h,
          padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.centerLeft,
          child: Text(
              "${DataCubit.get(context).productModels[index].stockQuantity!}"),
        ),
      ],
    );
  }
}
