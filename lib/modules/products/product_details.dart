import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sandc_pos/core/components/app_language.dart';
import 'package:sandc_pos/modules/home/widgets/item_setting_data.dart';
import 'package:sandc_pos/online_models/client_response_model.dart';
import 'package:sandc_pos/online_models/product_response_model.dart';

class ProductDetails extends StatelessWidget {
  ProductDetails({super.key, this.item});

  ProductResponseModel? item;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(item!.name!),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Container(
          margin: const EdgeInsets.all(20),
          child: Column(
            children: [
              Image.memory(
                const Base64Decoder()
                    .convert(item!.image!.split("data:image/png;base64,").last),
                width: 75.w,
                height: 75.h,
                fit: BoxFit.cover,
              ),
              SizedBox(
                height: 10.h,
              ),
              ItemSettingData(title: getLang(context).name, data: item!.name!),
              ItemSettingData(
                  title: getLang(context).priceone,
                  data: item!.priceOne!.toString()),
              ItemSettingData(
                  title: getLang(context).pricetwo,
                  data: item!.priceTwo!.toString()),
              ItemSettingData(
                  title: getLang(context).pricethree,
                  data: item!.priceThree!.toString()),
              ItemSettingData(
                  title: getLang(context).category,
                  data: "${item!.categoryName}"),
              ItemSettingData(
                  title: getLang(context).desc, data: "${item!.description}"),
              ItemSettingData(
                  title: getLang(context).stock,
                  data: "${item!.stockQuantity}"),
              ItemSettingData(
                  title: getLang(context).discount,
                  data: item!.discount!.toString()),
            ],
          ),
        ),
      ),
    );
  }
}
