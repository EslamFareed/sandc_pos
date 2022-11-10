import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart' as getx;
import 'package:horizontal_data_table/horizontal_data_table.dart';

import 'package:sandc_pos/core/style/color/app_colors.dart';
import 'package:sandc_pos/modules/products/product_details.dart';

import '../../cubits/data_cubit/data_cubit.dart';

class TableProduct extends StatefulWidget {
  TableProduct({Key? key}) : super(key: key);

  @override
  State<TableProduct> createState() => _TableProductState();
}

class _TableProductState extends State<TableProduct> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DataCubit, DataState>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = DataCubit.get(context);

          return HorizontalDataTable(
            leftHandSideColumnWidth: getx.Get.width * .20,
            rightHandSideColumnWidth: getx.Get.width * .80,
            isFixedHeader: true,
            headerWidgets: _getTitleWidget(),
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
          );
        });
  }

  List<Widget> _getTitleWidget() {
    return [
      _getTitleItemWidget('image', getx.Get.width * .20),
      _getTitleItemWidget('Prodcut', getx.Get.width * .40),
      _getTitleItemWidget('Price', getx.Get.width * .20),
      _getTitleItemWidget('Quantity', getx.Get.width * .20),
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
    return GestureDetector(
      onTap: () {
        getx.Get.to(
            ProductDetails(
              item: DataCubit.get(context).productModels[index],
            ),
            transition: getx.Transition.zoom);
      },
      child: Container(
        width: getx.Get.width * .20,
        height: 52.h,
        padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
        alignment: Alignment.centerLeft,
        child: DataCubit.get(context).productModels[index].image!.length > 22
            ? FadeInImage(
                image: MemoryImage(const Base64Decoder().convert(
                    DataCubit.get(context)
                        .productModels[index]
                        .image!
                        .split("data:image/png;base64,")
                        .last)),
                imageErrorBuilder: (context, error, stackTrace) =>
                    Image.asset("assets/images/placeholder.png"),
                placeholder: const AssetImage("assets/images/logo.png"),
              )
            : Image.asset("assets/images/placeholder.png"),
      ),
    );
  }

  Widget _generateRightHandSideColumnRow(BuildContext context, int index) {
    return GestureDetector(
      onTap: () {
        getx.Get.to(
            ProductDetails(
              item: DataCubit.get(context).productModels[index],
            ),
            transition: getx.Transition.zoom);
      },
      child: Row(
        children: [
          Container(
            width: getx.Get.width * .40,
            height: 52.h,
            padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
            alignment: Alignment.centerLeft,
            child: Text(DataCubit.get(context).productModels[index].name!),
          ),
          Container(
            width: getx.Get.width * .20,
            height: 52.h,
            padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
            alignment: Alignment.centerLeft,
            child: Text(
                "${DataCubit.get(context).productModels[index].priceOne!}"),
          ),
          Container(
            width: getx.Get.width * .20,
            height: 52.h,
            padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
            alignment: Alignment.centerLeft,
            child: Text(
                "${DataCubit.get(context).productModels[index].stockQuantity!}"),
          ),
        ],
      ),
    );
  }
}
