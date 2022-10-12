import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sandc_pos/cubits/data_cubit/data_cubit.dart';
import 'package:sandc_pos/models/products.dart';
import 'package:uuid/uuid.dart';

import '../../models/invoice_details.dart';

class SearchProductsScreen extends StatefulWidget {
  SearchProductsScreen({Key? key}) : super(key: key);

  @override
  State<SearchProductsScreen> createState() => _SearchProductsScreenState();
}

class _SearchProductsScreenState extends State<SearchProductsScreen> {
  TextEditingController? controller = TextEditingController();

  List<ProductModel> products = [];

  @override
  void initState() {
    products = DataCubit.get(context).productModels;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                searchProducts(value, context);
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
                  itemCount: products.length,
                  itemBuilder: (ctx, i) => _buildItemSearch(products[i])))
        ],
      ),
    );
  }

  _buildItemSearch(ProductModel product) {
    return Card(
      child: ListTile(
        onTap: () {
          if (DataCubit.get(context).productsCurrentOrder.contains(product)) {
            DataCubit.get(context).addQuantityProdcut(product, context);
          } else {
            DataCubit.get(context).addNewProduct(product, context);
          }
        },
        leading: Image.network(
          product.image!,
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

  void searchProducts(String query, BuildContext context) {
    final productsSearched =
        DataCubit.get(context).productModels.where((element) {
      final productName = element.name!.toLowerCase();
      final input = query.toLowerCase();

      return productName.contains(input);
    });
    setState(() {
      products = productsSearched.toList();
    });
  }
}
