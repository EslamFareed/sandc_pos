import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../core/components/app_language.dart';
import '../../core/components/default_buttons.dart';
import '../../core/style/color/app_colors.dart';
import 'sales_report/sales_reports.dart';

class ReportsHome extends StatelessWidget {
  const ReportsHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(getLang(context).reports),
      ),
      body: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              width: Get.width * .8,
              height: Get.height * .5,
              margin: EdgeInsets.only(top: 50.h),
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CircleAvatar(
                      radius: 50.r,
                      child: SvgPicture.asset("assets/icons/reports.svg")),
                  DefaultButton(
                    onPress: () {
                      Get.to(const SalesReport(), transition: Transition.zoom);
                    },
                    buttonText: getLang(context).salesReport,
                    buttonBorderCircular: 16.r,
                    buttonHeight: 35.h,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
