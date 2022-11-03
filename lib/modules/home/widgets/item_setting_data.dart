import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/style/text/app_text_style.dart';

class ItemSettingData extends StatelessWidget {
  ItemSettingData({super.key, this.title, this.data});
  String? title;
  String? data;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title!),
        Container(
            width: Get.width,
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: const Color.fromARGB(255, 221, 221, 221)),
            child: Text(data!, style: AppTextStyle.bodyText()))
      ],
    );
  }
}
