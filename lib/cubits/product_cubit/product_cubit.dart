import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../online_models/product_response_model.dart';
import '../data_cubit/data_cubit.dart';

part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  ProductCubit() : super(ProductInitial());

  static ProductCubit get(context) => BlocProvider.of(context);

  List<ProductResponseModel> products = [];

  void searchProducts(String query, BuildContext context) {
    final productsSearched =
        DataCubit.get(context).productModels.where((element) {
      final productName = element.name!.toLowerCase();
      final input = query.toLowerCase();

      return productName.contains(input);
    });
    products = productsSearched.toList();
    emit(SearchProdcuts());
  }
}
