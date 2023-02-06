import 'package:custom_pop_up_menu/custom_pop_up_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'dart:io';
import 'package:horizontal_data_table/horizontal_data_table.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sandc_pos/core/components/app_language.dart';
import 'package:sandc_pos/core/components/default_buttons.dart';
import 'package:sandc_pos/core/components/text_form_field.dart';
import 'package:sandc_pos/core/style/color/app_colors.dart';
import 'package:sandc_pos/core/style/text/app_text_style.dart';
import 'package:sandc_pos/cubits/data_cubit/data_cubit.dart';
import 'package:sandc_pos/modules/home/widgets/item_setting_data.dart';

import 'package:uuid/uuid.dart';

class ItemModel {
  String title;
  IconData icon;
  void onPress;

  ItemModel(this.title, this.icon, this.onPress);
}

class TableSales extends StatefulWidget {
  TableSales({Key? key}) : super(key: key);

  @override
  State<TableSales> createState() => _TableSalesState();
}

class _TableSalesState extends State<TableSales> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DataCubit, DataState>(
      listener: ((context, state) {}),
      builder: (context, state) {
        return DataCubit.get(context).itemsCurrentOrder.isNotEmpty
            ? HorizontalDataTable(
                leftHandSideColumnWidth: Get.width * .40,
                rightHandSideColumnWidth: Get.width * .60,
                isFixedHeader: true,
                headerWidgets: _getTitleWidget(),
                leftSideItemBuilder: _generateFirstColumnRow,
                rightSideItemBuilder: _generateRightHandSideColumnRow,
                itemCount: DataCubit.get(context).itemsCurrentOrder.length,
                rowSeparatorWidget: const Divider(
                  color: Colors.black54,
                  height: 1.0,
                  thickness: 0.0,
                ),
                leftHandSideColBackgroundColor: const Color(0xFFFFFFFF),
                rightHandSideColBackgroundColor: const Color(0xFFFFFFFF),
              )
            : Scaffold(
                body: Center(child: Text(getLang(context).noitems)),
              );
      },
    );
  }

  List<Widget> _getTitleWidget() {
    return [
      _getTitleItemWidget(getLang(context).prodcut, Get.width * .40),
      _getTitleItemWidget(getLang(context).price, Get.width * .20),
      _getTitleItemWidget(getLang(context).quantity, Get.width * .20),
      _getTitleItemWidget(getLang(context).total, Get.width * .20),
    ];
  }

  Widget _getTitleItemWidget(String label, double width) {
    return Container(
      width: width,
      height: 56,
      color: AppColors.primaryColor,
      padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
      alignment: Alignment.centerLeft,
      child: Text(label,
          style: const TextStyle(
              fontWeight: FontWeight.bold, color: Colors.white)),
    );
  }

  Widget _generateFirstColumnRow(BuildContext context, int index) {
    return Container(
      width: Get.width * .40,
      height: 52.h,
      padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
      alignment: Alignment.centerLeft,
      child: Text(DataCubit.get(context)
          .productsCurrentOrder
          .where((element) =>
              element.prodId ==
              DataCubit.get(context).itemsCurrentOrder[index].prodId)
          .first
          .name!),
    );
  }

  TextEditingController? quantityController;
  var _keyQuantity = GlobalKey<FormState>();
  var priceChosen = "price1";


    //! Todo

  Widget showDialogAboutQuantity(BuildContext context, int index) {
    quantityController = TextEditingController(
        text: DataCubit.get(context)
            .itemsCurrentOrder[index]
            .quantity
            .toString());
    return Dialog(
      child: Container(
        width: Get.width * .7,
        height: Get.height * .5,
        margin: const EdgeInsets.all(5),
        child: Form(
          key: _keyQuantity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                getLang(context).prodcut,
                style: AppTextStyle.bodyText(),
              ),
              DefaultTextField(
                labelText: getLang(context).quantity,
                controller: quantityController,
                lines: 1,
                keyboardType: TextInputType.number,
                onChanged: (p0) {
                  _keyQuantity.currentState!.validate();
                },
                validator: (p0) {
                  if (p0!.isEmpty) {
                    return getLang(context).cannotbeempty;
                  }
                },
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                        width: Get.width,
                        padding: EdgeInsets.all(15),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: const Color.fromARGB(255, 221, 221, 221)),
                        child: Text(
                            DataCubit.get(context)
                                .productsCurrentOrder
                                .where((element) =>
                                    element.prodId ==
                                    DataCubit.get(context)
                                        .itemsCurrentOrder[index]
                                        .prodId)
                                .first
                                .priceOne
                                .toString(),
                            style: AppTextStyle.bodyText())),
                  ),
                  Expanded(
                    child: RadioListTile(
                      title: Text(getLang(context).priceone),
                      value: "price1",
                      groupValue: "price",
                      onChanged: (value) async {
                        await DataCubit.get(context).changePrice();
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _generateRightHandSideColumnRow(BuildContext context, int index) {
    return GestureDetector(
      onTap: () {
        Get.dialog(
          showDialogAboutQuantity(context, index),
          // barrierDismissible: false,
        );
      },
      child: Row(
        children: [
          Container(
              width: Get.width * .20,
              height: 52.h,
              padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
              alignment: Alignment.centerLeft,
              child: Text(DataCubit.get(context)
                      .companyModels[0]
                      .isPriceIncludeTaxes!
                  ? "${DataCubit.get(context).itemsCurrentOrder[index].unitPrice! - (DataCubit.get(context).itemsCurrentOrder[index].unitPrice! * (double.parse(DataCubit.get(context).companyModels[0].taxAmount!) * .01))}"
                  : "${DataCubit.get(context).itemsCurrentOrder[index].unitPrice}")
              // "${DataCubit.get(context).productsCurrentOrder.where((element) => element.prodId == DataCubit.get(context).itemsCurrentOrder[index].prodId).first.priceOne!}"),
              ),
          GestureDetector(
            // onTapDown: (details) {
            //   showMenu(
            //     context: context,
            //     position: RelativeRect.fromLTRB(
            //       details.globalPosition.dx,
            //       details.globalPosition.dy,
            //       details.globalPosition.dx,
            //       details.globalPosition.dy,
            //     ),
            //     items: [
            //       const PopupMenuItem(child: Text('+'), value: '1'),
            //       const PopupMenuItem(child: Text('-'), value: '2'),
            //     ],
            //     elevation: 8.0,
            //   ).then(
            //     (value) {
            //       if (value == "1") {
            //         DataCubit.get(context).addQuantityProdcutFromHome(
            // DataCubit.get(context)
            //     .productsCurrentOrder
            //     .where((element) =>
            //         element.prodId ==
            //         DataCubit.get(context)
            //             .itemsCurrentOrder[index]
            //             .prodId)
            //                 .first,
            //             context);
            //       } else {
            //         if (DataCubit.get(context)
            //                 .itemsCurrentOrder[index]
            //                 .quantity ==
            //             1) {
            //           Get.dialog(
            //               AlertDialog(
            //                 actions: [
            //                   Row(
            //                     children: [
            //                       Expanded(
            //                         child: DefaultButton(
            //                             buttonHeight: 25.h,
            //                             onPress: () {
            //                               DataCubit.get(context)
            //                                   .deleteProdcutFromCart(
            //                                       DataCubit.get(context)
            //                                           .productsCurrentOrder
            //                                           .where((element) =>
            //                                               element.prodId ==
            //                                               DataCubit.get(context)
            //                                                   .itemsCurrentOrder[
            //                                                       index]
            //                                                   .prodId)
            //                                           .first,
            //                                       context);
            //                               Get.back();
            //                             },
            //                             buttonText: getLang(context).yes),
            //                       ),
            //                       Expanded(
            //                         child: DefaultButton(
            //                             buttonHeight: 25.h,
            //                             onPress: () {
            //                               Get.back();
            //                             },
            //                             buttonText: getLang(context).no),
            //                       ),
            //                     ],
            //                   )
            //                 ],
            //                 title: Text(
            //                     "${getLang(context).wanttodeletethisproductfromcart} ${DataCubit.get(context).productsCurrentOrder.where((element) => element.prodId == DataCubit.get(context).itemsCurrentOrder[index].prodId).first.name!}"),
            //               ),
            //               barrierDismissible: false);
            //         } else {
            //           DataCubit.get(context).mineseQuantityProdcutFromHome(
            //               DataCubit.get(context)
            //                   .productsCurrentOrder
            //                   .where((element) =>
            //                       element.prodId ==
            //                       DataCubit.get(context)
            //                           .itemsCurrentOrder[index]
            //                           .prodId)
            //                   .first,
            //               context);
            //         }
            //       }
            //     },
            //   );
            // },
            child: Container(
              width: Get.width * .20,
              height: 52.h,
              padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
              alignment: Alignment.centerLeft,
              child: Text(
                  "${DataCubit.get(context).itemsCurrentOrder[index].quantity}"),
            ),
          ),
          Container(
              width: Get.width * .20,
              height: 52.h,
              padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
              alignment: Alignment.centerLeft,
              child: Text(DataCubit.get(context)
                      .companyModels[0]
                      .isPriceIncludeTaxes!
                  ? "${DataCubit.get(context).itemsCurrentOrder[index].totalCost}"
                  : "${DataCubit.get(context).itemsCurrentOrder[index].totalCost! - (DataCubit.get(context).itemsCurrentOrder[index].totalCost! * (double.parse(DataCubit.get(context).companyModels[0].taxAmount!) * .01))}")
              // "${DataCubit.get(context).itemsCurrentOrder[index].totalCost!}"),
              ),
        ],
      ),
    );
  }
}
