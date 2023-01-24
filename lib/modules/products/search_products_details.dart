import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart' as getx;
import 'package:sandc_pos/cubits/data_cubit/data_cubit.dart';
import 'package:sandc_pos/cubits/product_cubit/product_cubit.dart';
import 'package:sandc_pos/modules/products/product_details.dart';
import 'package:sandc_pos/online_models/product_response_model.dart';
import 'package:uuid/uuid.dart';

import '../../core/components/app_language.dart';

class SearchProductsDetailsScreen extends StatefulWidget {
  SearchProductsDetailsScreen({Key? key}) : super(key: key);

  @override
  State<SearchProductsDetailsScreen> createState() =>
      _SearchProductsDetailsScreenState();
}

class _SearchProductsDetailsScreenState
    extends State<SearchProductsDetailsScreen> {
  TextEditingController? controller = TextEditingController();

  @override
  void initState() {
    // products = DataCubit.get(context).productModels;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductCubit, ProductState>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = ProductCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text(getLang(context).searchByname),
            ),
            body: Column(
              children: [
                Container(
                  margin: const EdgeInsets.all(20),
                  child: TextField(
                    controller: controller,
                    onChanged: (value) {
                      cubit.searchProducts(value, context);
                    },
                    decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.search),
                        hintText: getLang(context).prodcut,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: const BorderSide(color: Colors.black))),
                  ),
                ),
                Expanded(
                    child: ListView.builder(
                        itemCount: cubit.products.length,
                        itemBuilder: (ctx, i) =>
                            _buildItemSearch(cubit.products[i])))
              ],
            ),
          );
        });
  }

  _buildItemSearch(ProductResponseModel product) {
    return Card(
      child: ListTile(
        onTap: () {
          getx.Get.to(
              ProductDetails(
                item: product,
              ),
              transition: getx.Transition.zoom);
        },
        leading: Image.memory(
          const Base64Decoder()
              .convert(product.image!.split("data:image/png;base64,").last),
          fit: BoxFit.cover,
          width: 50.w,
          height: 50.h,
        ),
        title: Text(product.name!),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text("${getLang(context).price} : ${product.priceOne!}"),
            Text("${getLang(context).quantity} : ${product.stockQuantity!}"),
          ],
        ),
      ),
    );
  }
}
