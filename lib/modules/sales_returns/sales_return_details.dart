import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart' as getx;
import 'package:sandc_pos/core/components/default_buttons.dart';
import 'package:sandc_pos/core/components/text_form_field.dart';
import 'package:sandc_pos/cubits/data_cubit/data_cubit.dart';
import 'package:sandc_pos/cubits/sales_report_cubit/sales_report_cubit.dart';
import 'package:sandc_pos/cubits/sales_returns_cubit/sales_returns_cubit.dart';
import 'package:sandc_pos/online_models/order_response_model.dart';

import '../home/widgets/item_setting_data.dart';

class SalesDetailsScreen extends StatefulWidget {
  SalesDetailsScreen({super.key, this.item});
  OrderResponseModel? item;

  @override
  State<SalesDetailsScreen> createState() => _SalesDetailsScreenState();
}

class _SalesDetailsScreenState extends State<SalesDetailsScreen> {
  TextEditingController? quantityReturnController = TextEditingController();

  TextEditingController? reasonReturnController = TextEditingController();

  GlobalKey<FormState> _keyForm = GlobalKey();

  @override
  Widget build(BuildContext context) {
    SalesReturnsCubit.get(context).getOrderDetails(widget.item!.id, context);

    return Scaffold(
        appBar: AppBar(
          title: Text("${widget.item!.id}"),
        ),
        body: _buildBody());
  }

  _buildBody() {
    return BlocConsumer<SalesReturnsCubit, SalesReturnsState>(
        listener: (context, state) {
      // TODO: implement listener
    }, builder: (context, state) {
      var cubit = SalesReturnsCubit.get(context);
      return SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Container(
          margin: const EdgeInsets.all(20),
          child: Column(
            children: [
              SizedBox(
                height: 10.h,
              ),
              Text("Products"),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) => Card(
                  child: ListTile(
                      title: Text(cubit.orderProducts[index].name!),
                      subtitle: Text(
                          "${cubit.orderDetails.firstWhere((element) => cubit.orderProducts[index].prodId == element.prodId).quantity}"),
                      trailing: SizedBox(
                        width: 150.w,
                        height: 50.h,
                        child: cubit.orderDetails
                                    .firstWhere((element) =>
                                        cubit.orderProducts[index].prodId ==
                                        element.prodId)
                                    .isReturn! &&
                                cubit.orderDetails
                                        .firstWhere((element) =>
                                            cubit.orderProducts[index].prodId ==
                                            element.prodId)
                                        .quantity ==
                                    0
                            ? Container()
                            : TextButton(
                                onPressed: () {
                                  _showDialog(context, cubit, index);
                                },
                                child: Text("Return This Product")),
                      )),
                ),
                itemCount: cubit.orderProducts.length,
              ),
            ],
          ),
        ),
      );
    });
  }

  _showDialog(BuildContext context, SalesReturnsCubit cubit, int index) {
    reasonReturnController!.text = "";
    quantityReturnController!.text = "";
    showDialog(
      context: context,
      builder: (context) => Dialog(
        child: Form(
          key: _keyForm,
          child: Container(
            width: getx.Get.width * .7,
            height: getx.Get.height * .7,
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                DefaultTextField(
                  labelText:
                      "enter quantity for returning product ${cubit.orderProducts[index].name}",
                  keyboardType: TextInputType.number,
                  controller: quantityReturnController,
                  validator: (p0) {
                    if (p0!.isEmpty) {
                      return "cannot be empty";
                    }
                  },
                ),
                DefaultTextField(
                  labelText:
                      "reason for returning product ${cubit.orderProducts[index].name}",
                  keyboardType: TextInputType.text,
                  controller: reasonReturnController,
                  validator: (p0) {
                    if (p0!.isEmpty) {
                      return "cannot be empty";
                    }
                  },
                  lines: 3,
                ),
                DefaultButton(
                  onPress: () {
                    _returnProduct(context, cubit, index);
                  },
                  buttonText: "Return This Product",
                  buttonHeight: 40.h,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  _returnProduct(
      BuildContext context, SalesReturnsCubit cubit, int index) async {
    if (_keyForm.currentState!.validate()) {
      if (cubit.orderDetails
                  .firstWhere((element) =>
                      cubit.orderProducts[index].prodId == element.prodId)
                  .quantity! >=
              int.parse(quantityReturnController!.text.toString()) &&
          reasonReturnController!.text.toString().isNotEmpty) {
        double? totalPrice = cubit.orderDetails
                .firstWhere((element) =>
                    cubit.orderProducts[index].prodId == element.prodId)
                .unitPrice! *
            int.parse(quantityReturnController!.text.toString());

        DataCubit.get(context)
            .orderModels
            .firstWhere((element) => element.id == widget.item!.id)
            .payAmount = DataCubit.get(context)
                .orderModels
                .firstWhere((element) => element.id == widget.item!.id)
                .payAmount! -
            totalPrice;

        DataCubit.get(context)
            .orderModels
            .firstWhere((element) => element.id == widget.item!.id)
            .totalCost = DataCubit.get(context)
                .orderModels
                .firstWhere((element) => element.id == widget.item!.id)
                .totalCost! -
            totalPrice;

        DataCubit.get(context)
            .orderModels
            .firstWhere((element) => element.id == widget.item!.id)
            .costNet = DataCubit.get(context)
                .orderModels
                .firstWhere((element) => element.id == widget.item!.id)
                .costNet! -
            totalPrice;

        DataCubit.get(context)
            .orderModels
            .firstWhere((element) => element.id == widget.item!.id)
            .isReturn = true;

        DataCubit.get(context)
            .orderModels
            .firstWhere((element) => element.id == widget.item!.id)
            .offlineDatabase = false;

        DataCubit.get(context)
            .orderModels
            .firstWhere((element) => element.id == widget.item!.id)
            .updateDataBase = false;

        DataCubit.get(context)
                .orderModels
                .firstWhere((element) => element.id == widget.item!.id)
                .returnDesc =
            "${DataCubit.get(context).orderModels.firstWhere((element) => element.id == widget.item!.id).returnDesc!} ${reasonReturnController!.text.toString()}";

        cubit.orderDetails
            .firstWhere((element) =>
                cubit.orderProducts[index].prodId == element.prodId)
            .isReturn = true;

        cubit.orderDetails
                .firstWhere((element) =>
                    cubit.orderProducts[index].prodId == element.prodId)
                .quantReturns =
            int.parse(quantityReturnController!.text.toString());

        cubit.orderDetails
            .firstWhere((element) =>
                cubit.orderProducts[index].prodId == element.prodId)
            .quantity = cubit.orderDetails
                .firstWhere((element) =>
                    cubit.orderProducts[index].prodId == element.prodId)
                .quantity! -
            int.parse(quantityReturnController!.text.toString());

        cubit.orderDetails
            .firstWhere((element) =>
                cubit.orderProducts[index].prodId == element.prodId)
            .reasonForReturn = reasonReturnController!.text.toString();

        cubit.orderDetails
            .firstWhere((element) =>
                cubit.orderProducts[index].prodId == element.prodId)
            .offlineDatabase = false;

        cubit.orderDetails
            .firstWhere((element) =>
                cubit.orderProducts[index].prodId == element.prodId)
            .updateDataBase = false;

        await DataCubit.get(context).updateOrderModel(DataCubit.get(context)
            .orderModels
            .firstWhere((element) => element.id == widget.item!.id));

        await DataCubit.get(context).updateInvoiceDetailsModel(
            cubit.orderDetails.firstWhere((element) =>
                cubit.orderProducts[index].prodId == element.prodId));
        SalesReturnsCubit.get(context)
            .getOrderDetails(widget.item!.id, context);

        getx.Get.back();
      } else {
        getx.Get.showSnackbar(getx.GetSnackBar(
          message: "enter valid quantity and reason",
          duration: Duration(seconds: 2),
        ));
      }
    }
  }
}
