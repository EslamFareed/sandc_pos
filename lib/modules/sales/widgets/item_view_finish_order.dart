import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ItemViewFinishOrder extends StatelessWidget {
  ItemViewFinishOrder({super.key, this.title, this.data});
  String? title;
  String? data;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(title!),
        Container(
            width: Get.width,
            alignment: Alignment.center,
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: const Color.fromARGB(255, 221, 221, 221)),
            child: Text(data!)),
        SizedBox(height: 10.h),
      ],
    );
  }
}
