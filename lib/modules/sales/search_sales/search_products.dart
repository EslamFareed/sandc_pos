import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart' as getx;
import 'package:sandc_pos/cubits/data_cubit/data_cubit.dart';
import 'package:sandc_pos/online_models/product_response_model.dart';
import 'package:uuid/uuid.dart';

class SearchProductsScreen extends StatefulWidget {
  SearchProductsScreen({Key? key}) : super(key: key);

  @override
  State<SearchProductsScreen> createState() => _SearchProductsScreenState();
}

class _SearchProductsScreenState extends State<SearchProductsScreen> {
  TextEditingController? controller = TextEditingController();

  @override
  void initState() {
    DataCubit.get(context).products = DataCubit.get(context).productModels;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DataCubit, DataState>(
      builder: (context, state) {
        var cubit = DataCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text("Search By name"),
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
                      hintText: "Product Name",
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
      },
      listener: (context, state) {},
    );
  }

  _buildItemSearch(ProductResponseModel product) {
    return Card(
      child: ListTile(
        onTap: () {
          if (product.stockQuantity! > 0) {
            if (DataCubit.get(context).productsCurrentOrder.contains(product)) {
              DataCubit.get(context).addQuantityProdcut(product, context);
            } else {
              DataCubit.get(context).addNewProduct(product, context);
            }
          } else {
            getx.Get.showSnackbar(const getx.GetSnackBar(
              message: "this product out of stock",
              duration: Duration(seconds: 2),
              animationDuration: Duration(milliseconds: 200),
            ));
          }
        },
        leading: product.image!.length > 22
            ? Image.memory(
                const Base64Decoder().convert(
                    product.image!.split("data:image/png;base64,").last),
                fit: BoxFit.cover,
                width: 50.w,
                height: 50.h,
              )
            : Image.asset(
                "assets/images/placeholder.png",
                fit: BoxFit.cover,
                width: 50.w,
                height: 50.h,
              ),
        title: Text(product.name!),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text("price : ${product.priceOne!}"),
            Text("quantity : ${product.stockQuantity!}"),
          ],
        ),
      ),
    );
  }
}
