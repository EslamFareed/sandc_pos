import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sandc_pos/core/components/app_language.dart';
import 'package:sandc_pos/core/style/text/app_text_style.dart';
import 'package:sandc_pos/cubits/data_cubit/data_cubit.dart';

import '../../core/style/color/app_colors.dart';
import 'widgets/item_setting_data.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(getLang(context).settings),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Stack(
          children: [
            Align(
              child: Container(
                  width: Get.width * .8,
                  margin: EdgeInsets.only(top: 50.h, bottom: 50.h),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: AppColors.whitBackGroundColor,
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 8,
                        blurStyle: BlurStyle.outer,
                        offset: Offset(0, 0),
                        spreadRadius: 10,
                      ),
                    ],
                  ),
                  child: _buildForm(context)),
            ),
          ],
        ),
      ),
    );
  }

  _buildForm(BuildContext context) {
    Uint8List _bytesImage = const Base64Decoder().convert(DataCubit.get(context)
        .companyModels[0]
        .logo!
        .split("data:image/png;base64,")
        .last);
    return Column(
      children: [
        Text(getLang(context).company_logo),
        CircleAvatar(
          backgroundImage: MemoryImage(_bytesImage),
          radius: 50.r,
        ),
        ItemSettingData(
            title: getLang(context).company_name_that_shown_in_sales_bill,
            data: DataCubit.get(context).companyModels[0].companyName),
        ItemSettingData(
            title: getLang(context).phone,
            data: DataCubit.get(context).companyModels[0].compPhone),
        ItemSettingData(
            title: getLang(context).address,
            data: DataCubit.get(context).companyModels[0].compAddress),
        ItemSettingData(
            title: getLang(context).notes_writen_in_the_last_of_bill,
            data: DataCubit.get(context).companyModels[0].companyDescription),
        // ItemSettingData(
        //     title: "Language",
        //     data: DataCubit.get(context).companyModels[0].compLanguage),
        ItemSettingData(
            title: getLang(context).currency,
            data: DataCubit.get(context).companyModels[0].compCurrencyName),
        CheckboxListTile(
          enabled: false,
          value: DataCubit.get(context).companyModels[0].isTaxes,
          onChanged: (val) {},
          title: Text(getLang(context).cancel_taxes),
        ),
        SizedBox(height: 5.h),
        Row(
          children: [
            Text(getLang(context).value_added_tax),
            SizedBox(width: 10.w),
            Expanded(
              child: Container(
                  width: Get.width,
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: const Color.fromARGB(255, 221, 221, 221)),
                  child: Text(
                      DataCubit.get(context).companyModels[0].compTaxAmount!,
                      style: AppTextStyle.bodyText())),
            ),
            SizedBox(width: 10.w),
            const Text(
              "%",
              style: TextStyle(color: AppColors.primaryColor),
            )
          ],
        ),
        SizedBox(height: 5.h),
        Row(
          children: [
            Text(getLang(context).taxes_number),
            SizedBox(width: 10.w),
            Expanded(
              child: Container(
                  width: Get.width,
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: const Color.fromARGB(255, 221, 221, 221)),
                  child: Text(
                      DataCubit.get(context).companyModels[0].compTaxNumber!,
                      style: AppTextStyle.bodyText())),
            ),
          ],
        ),
        SizedBox(height: 10.h),
        CheckboxListTile(
          enabled: false,
          value: DataCubit.get(context).companyModels[0].isPriceIncludeTaxes,
          onChanged: (val) {},
          title: Text(getLang(context).price_includes_taxes),
        ),
        SizedBox(height: 10.h),
        CheckboxListTile(
          enabled: false,
          value: DataCubit.get(context).companyModels[0].isMustChoosePayCash,
          onChanged: (val) {},
          title: Text(getLang(context).must_choose_customer_when_pay_cash),
        ),
        SizedBox(height: 50.h),
        Text(getLang(context).change_language),
        LangSwitch(isExpanded: true, width: 200.w),
      ],
    );
  }
}
