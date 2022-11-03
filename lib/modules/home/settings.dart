import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sandc_pos/core/components/app_currency.dart';
import 'package:sandc_pos/core/style/text/app_text_style.dart';
import 'package:sandc_pos/cubits/data_cubit/data_cubit.dart';

import '../../core/components/app_language.dart';
import '../../core/components/default_buttons.dart';
import '../../core/components/text_form_field.dart';
import '../../core/style/color/app_colors.dart';
import 'widgets/item_setting_data.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Settings"),
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
        const Text("Company Logo"),
        CircleAvatar(
          backgroundImage: MemoryImage(_bytesImage),
          radius: 50.r,
        ),
        ItemSettingData(
            title: "Company Name That shown in sales bill",
            data: DataCubit.get(context).companyModels[0].companyName),
        SizedBox(height: 10.h),
        ItemSettingData(
            title: "Phone",
            data: DataCubit.get(context).companyModels[0].compPhone),
        SizedBox(height: 10.h),
        ItemSettingData(
            title: "Address",
            data: DataCubit.get(context).companyModels[0].compAddress),
        SizedBox(height: 10.h),
        ItemSettingData(
            title: "Notes Writen in the last of bill",
            data: DataCubit.get(context).companyModels[0].companyDescription),
        SizedBox(height: 10.h),
        ItemSettingData(
            title: "Language",
            data: DataCubit.get(context).companyModels[0].compLanguage),
        SizedBox(height: 10.h),
        ItemSettingData(
            title: "Currency",
            data: DataCubit.get(context).companyModels[0].compCurrencyName),
        SizedBox(height: 10.h),
        CheckboxListTile(
          enabled: false,
          value: false,
          onChanged: (val) {},
          title: Text("Cancel Taxes"),
        ),
        SizedBox(height: 5.h),
        Row(
          children: [
            Text("value added tax"),
            SizedBox(width: 10.w),
            Expanded(
              child: Container(
                  width: Get.width,
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: const Color.fromARGB(255, 221, 221, 221)),
                  child:
                      Text("value added tax", style: AppTextStyle.bodyText())),
            ),
            SizedBox(width: 10.w),
            Text(
              "%",
              style: TextStyle(color: AppColors.primaryColor),
            )
          ],
        ),
        SizedBox(height: 5.h),
        Row(
          children: [
            Text("Taxes Number"),
            SizedBox(width: 10.w),
            Expanded(
              child: Container(
                  width: Get.width,
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: const Color.fromARGB(255, 221, 221, 221)),
                  child: Text("Taxes Number", style: AppTextStyle.bodyText())),
            ),
          ],
        ),
        SizedBox(height: 10.h),
        CheckboxListTile(
          enabled: false,
          value: false,
          onChanged: (val) {},
          title: Text("Price includes Taxes"),
        ),
        SizedBox(height: 10.h),
        CheckboxListTile(
          enabled: false,
          value: false,
          onChanged: (val) {},
          title: Text("must choose customer when pay cash"),
        ),
        SizedBox(height: 50.h),
      ],
    );
  }
}
