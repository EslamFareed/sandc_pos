import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
              ItemSettingData(title: "Name", data: item!.name!),
              ItemSettingData(
                  title: "Price 1", data: item!.priceOne!.toString()),
              ItemSettingData(
                  title: "Price 2", data: item!.priceTwo!.toString()),
              ItemSettingData(
                  title: "Price 3", data: item!.priceThree!.toString()),
              ItemSettingData(
                  title: "Category Name", data: "${item!.categoryName}"),
              ItemSettingData(
                  title: "Description", data: "${item!.description}"),
              ItemSettingData(title: "stock", data: "${item!.stockQuantity}"),
              ItemSettingData(
                  title: "Discount", data: item!.discount!.toString()),
            ],
          ),
        ),
      ),
    );
  }
}
