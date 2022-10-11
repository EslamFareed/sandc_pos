import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../core/components/default_buttons.dart';
import '../../core/style/color/app_colors.dart';
import 'add_customer.dart';
import 'show_customers.dart';

class CustomersHome extends StatelessWidget {
  const CustomersHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Customers"),
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
                    child: SvgPicture.asset(
                      "assets/icons/clients.svg",
                      semanticsLabel: 'A red up arrow',
                    ),
                  ),
                  DefaultButton(
                    onPress: () {
                      Get.to(const ShowCustomers(),
                          transition: Transition.zoom);
                    },
                    buttonText: "Show Customers",
                    buttonBorderCircular: 16.r,
                    buttonHeight: 35.h,
                  ),
                  DefaultButton(
                    onPress: () {
                      Get.to(AddCustomer(), transition: Transition.zoom);
                    },
                    buttonText: "Add New Customer",
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
