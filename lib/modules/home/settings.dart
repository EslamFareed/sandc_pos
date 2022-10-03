import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sandc_pos/core/components/app_currency.dart';

import '../../core/components/app_language.dart';
import '../../core/components/default_buttons.dart';
import '../../core/components/text_form_field.dart';
import '../../core/style/color/app_colors.dart';

class SettingsScreen extends StatefulWidget {
  SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool? isPriceIncludesTaxes = false;
  bool? mustChooseCustomerWhenPayCash = false;
  bool? cancelTaxes = false;

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
    return Column(
      children: [
        Text("Company Logo"),
        GestureDetector(
          onTap: () {},
          child: Icon(
            Icons.add_photo_alternate_outlined,
            size: 100,
          ),
        ),
        DefaultTextField(labelText: "Company Name That shown in sales bill"),
        SizedBox(height: 10.h),
        DefaultTextField(labelText: "Phone"),
        SizedBox(height: 10.h),
        DefaultTextField(labelText: "Address"),
        SizedBox(height: 10.h),
        DefaultTextField(labelText: "Notes Writen in the last of bill"),
        SizedBox(height: 10.h),
        Container(
          alignment: getLang(context).localeName == "ar"
              ? Alignment.centerRight
              : Alignment.centerLeft,
          child: Text(
            "Language",
          ),
        ),
        LangSwitch(isExpanded: true, width: Get.width),
        SizedBox(height: 10.h),
        Container(
          alignment: getLang(context).localeName == "ar"
              ? Alignment.centerRight
              : Alignment.centerLeft,
          child: Text(
            "Currency",
          ),
        ),
        CurrencySwitch(isExpanded: true, width: Get.width),
        SizedBox(height: 10.h),
        CheckboxListTile(
          value: cancelTaxes,
          onChanged: (val) {
            setState(() {
              cancelTaxes = val;
            });
          },
          title: Text("Cancel Taxes"),
        ),
        SizedBox(height: 5.h),
        Row(
          children: [
            Text("value added tax"),
            SizedBox(width: 10.w),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: const Color.fromARGB(255, 221, 221, 221)),
                child: TextFormField(
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                  ),
                ),
              ),
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
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: const Color.fromARGB(255, 221, 221, 221)),
                child: TextFormField(
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 10.h),
        CheckboxListTile(
          value: isPriceIncludesTaxes,
          onChanged: (val) {
            setState(() {
              isPriceIncludesTaxes = val;
            });
          },
          title: Text("Price includes Taxes"),
        ),
        SizedBox(height: 10.h),
        CheckboxListTile(
          value: mustChooseCustomerWhenPayCash,
          onChanged: (val) {
            setState(() {
              mustChooseCustomerWhenPayCash = val;
            });
          },
          title: Text("must choose customer when pay cash"),
        ),
        SizedBox(height: 50.h),
        DefaultButton(
          onPress: () {},
          buttonText: "Save Data",
          buttonBorderCircular: 16,
          buttonHeight: 35.h,
        ),
        SizedBox(height: 25.h),
      ],
    );
  }
}
