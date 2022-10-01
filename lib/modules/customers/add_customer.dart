import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../core/components/default_buttons.dart';
import '../../core/components/text_form_field.dart';
import '../../core/style/color/app_colors.dart';

class AddCustomer extends StatelessWidget {
  const AddCustomer({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Add Mew Customer"),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topCenter,
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
                  child: _buildForm()),
            ),
          ],
        ),
      ),
    );
  }

  _buildForm() {
    return Column(
      children: [
        Image.asset("assets/icons/add_customer.png"),
        DefaultTextField(labelText: "Full Name"),
        SizedBox(height: 10.h),
        DefaultTextField(labelText: "Address"),
        SizedBox(height: 10.h),
        DefaultTextField(labelText: "Phone"),
        SizedBox(height: 10.h),
        DefaultTextField(labelText: "Amount on him"),
        SizedBox(height: 10.h),
        DefaultTextField(labelText: "Maximum indebtedness"),
        SizedBox(height: 10.h),
        DefaultTextField(labelText: "Maximum indebtedness bills"),
        SizedBox(height: 10.h),
        DefaultTextField(labelText: "Tax Number"),
        SizedBox(height: 10.h),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Address on map"),
            Image.asset("assets/images/map_choose.png"),
          ],
        ),
        DefaultTextField(
          labelText: "Notes",
          lines: 3,
        ),
        SizedBox(height: 50.h),
        DefaultButton(
          onPress: () {},
          buttonText: "Save Customer Data",
          buttonBorderCircular: 16,
          buttonHeight: 35.h,
        ),
        SizedBox(height: 25.h),
      ],
    );
  }
}
