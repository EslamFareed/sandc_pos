import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';
import 'package:sandc_pos/core/components/app_language.dart';

import 'package:sandc_pos/core/style/color/app_colors.dart';

import '../../cubits/data_cubit/data_cubit.dart';

class TableCategory extends StatefulWidget {
  TableCategory({Key? key}) : super(key: key);

  @override
  State<TableCategory> createState() => _TableCategoryState();
}

class _TableCategoryState extends State<TableCategory> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DataCubit, DataState>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = DataCubit.get(context);

          return HorizontalDataTable(
            leftHandSideColumnWidth: Get.width * .5,
            rightHandSideColumnWidth: Get.width * .5,
            isFixedHeader: true,
            headerWidgets: _getTitleWidget(context),
            // refreshIndicator: RefreshProgressIndicator(),
            // htdRefreshController: HDTRefreshController(),
            // onRefresh: () {},
            // enablePullToRefresh: true,
            leftSideItemBuilder: _generateFirstColumnRow,
            rightSideItemBuilder: _generateRightHandSideColumnRow,
            itemCount: cubit.categoryModels.length,
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

  List<Widget> _getTitleWidget(BuildContext context) {
    return [
      _getTitleItemWidget(getLang(context).category, Get.width * .5),
      _getTitleItemWidget(getLang(context).desc, Get.width * .5),
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
      width: Get.width * .5,
      height: 52.h,
      padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
      alignment: Alignment.centerLeft,
      child: Text(DataCubit.get(context).categoryModels[index].name!),
    );
  }

  Widget _generateRightHandSideColumnRow(BuildContext context, int index) {
    return Row(
      children: [
        Container(
          width: Get.width * .5,
          height: 52.h,
          padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.centerLeft,
          child:
              Text(DataCubit.get(context).categoryModels[index].description!),
        ),
      ],
    );
  }
}
