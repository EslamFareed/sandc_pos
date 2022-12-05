import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:sandc_pos/cubits/data_cubit/data_cubit.dart';
import 'package:sandc_pos/online_models/order_response_model.dart';
import 'package:sandc_pos/online_models/product_response_model.dart';

part 'sales_returns_state.dart';

class SalesReturnsCubit extends Cubit<SalesReturnsState> {
  SalesReturnsCubit() : super(SalesReportInitial());

  static SalesReturnsCubit get(context) => BlocProvider.of(context);

  List<OrderResponseModel> ordersReport = [];
  double total = 0;
  getOrders(BuildContext context) {
    ordersReport.clear();
    DataCubit.get(context).orderModels.forEach((element) {
      ordersReport.add(element);
    });
    for (var element in ordersReport) {
      total += element.totalCost!;
    }
    emit(GetOrdersForFirstTimeState());
  }

  TextEditingController? dateFilterOneController = TextEditingController();
  TextEditingController? dateFilterTwoController = TextEditingController();

  DateTime? dateFilterone;
  chooseDateOne(DateTime date) {
    dateFilterone = DateTime(date.year, date.month, date.day);
    dateFilterOneController!.text =
        "${date.day} - ${date.month} -  ${date.year}";

    emit(SelectDateFilterState());
  }

  DateTime? dateFiltertwo;
  chooseDateTwo(DateTime date) {
    dateFiltertwo = DateTime(date.year, date.month, date.day);
    dateFilterTwoController!.text =
        "${date.day} - ${date.month} -  ${date.year}";

    emit(SelectDateFilterState());
  }

  filterOrdersByDate() {
    List<OrderResponseModel> ordersFilter = ordersReport;
    ordersReport = [];
    ordersReport = ordersFilter.where((element) {
      DateTime current = DateTime(
          DateTime.parse(element.createDate!).year,
          DateTime.parse(element.createDate!).month,
          DateTime.parse(element.createDate!).day);
      if (current.isBefore(dateFiltertwo!) && current.isAfter(dateFilterone!)) {
        return true;
      } else if (current.isAtSameMomentAs(dateFilterone!) ||
          current.isAtSameMomentAs(dateFiltertwo!)) {
        return true;
      }
      return false;
    }).toList();
    total = 0;
    for (var element in ordersReport) {
      total += element.totalCost!;
    }
    emit(FilterOrdersByDateState());
  }

  List<GetInVoiceDetails> orderDetails = [];
  List<ProductResponseModel> orderProducts = [];

  getOrderDetails(String? id, BuildContext context) {
    orderDetails = [];
    orderProducts = [];
    DataCubit.get(context)
        .invoiceDetailsModels
        .where((element) => element.orderID == id)
        .toList()
        .forEach((e) {
      orderDetails.add(e);
    });

    for (var item in orderDetails) {
      orderProducts.add(DataCubit.get(context)
          .productModels
          .firstWhere((e) => e.prodId == item.prodId));
    }

    emit(GetOrderDetailsState());
  }

  List<OrderResponseModel> ordersSearchQuery = [];

  void searchOrders(String query, BuildContext context) {
    final ordersSearched = DataCubit.get(context).orderModels.where((element) {
      final orderReciet = element.id!.toLowerCase();
      final input = query.toLowerCase();

      return orderReciet.contains(input);
    });
    ordersSearchQuery = ordersSearched.toList();
    emit(SearchOrderQueryState());
  }
}
