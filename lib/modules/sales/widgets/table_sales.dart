import 'package:custom_pop_up_menu/custom_pop_up_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:group_radio_button/group_radio_button.dart';
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

  //! Todo

  showDialogAboutQuantity(BuildContext context, int index) {
    quantityController = TextEditingController(
        text: DataCubit.get(context)
            .itemsCurrentOrder[index]
            .quantity
            .toString());
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        String? _selectedPrice = DataCubit.get(context)
                    .itemsCurrentOrder[index]
                    .unitPrice ==
                DataCubit.get(context)
                    .productsCurrentOrder
                    .where((element) =>
                        element.prodId ==
                        DataCubit.get(context).itemsCurrentOrder[index].prodId)
                    .first
                    .priceOne
            ? "price1"
            : DataCubit.get(context).itemsCurrentOrder[index].unitPrice ==
                    DataCubit.get(context)
                        .productsCurrentOrder
                        .where((element) =>
                            element.prodId ==
                            DataCubit.get(context)
                                .itemsCurrentOrder[index]
                                .prodId)
                        .first
                        .priceTwo
                ? "price2"
                : DataCubit.get(context).itemsCurrentOrder[index].unitPrice ==
                        DataCubit.get(context)
                            .productsCurrentOrder
                            .where((element) =>
                                element.prodId ==
                                DataCubit.get(context)
                                    .itemsCurrentOrder[index]
                                    .prodId)
                            .first
                            .priceThree
                    ? "price3"
                    : "price1";
        return AlertDialog(
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Container(
                width: Get.width * .8,
                height: Get.height * .5,
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
                                    color: const Color.fromARGB(
                                        255, 221, 221, 221)),
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
                            child: RadioListTile<String>(
                              title: Text(
                                getLang(context).priceone,
                                style: AppTextStyle.caption(),
                              ),
                              value: 'price1',
                              groupValue: _selectedPrice,
                              onChanged: (String? value) {
                                setState(() => _selectedPrice = value);
                              },
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                                width: Get.width,
                                padding: EdgeInsets.all(15),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16),
                                    color: const Color.fromARGB(
                                        255, 221, 221, 221)),
                                child: Text(
                                    DataCubit.get(context)
                                        .productsCurrentOrder
                                        .where((element) =>
                                            element.prodId ==
                                            DataCubit.get(context)
                                                .itemsCurrentOrder[index]
                                                .prodId)
                                        .first
                                        .priceTwo
                                        .toString(),
                                    style: AppTextStyle.bodyText())),
                          ),
                          Expanded(
                            child: RadioListTile<String>(
                              title: Text(
                                getLang(context).pricetwo,
                                style: AppTextStyle.caption(),
                              ),
                              value: 'price2',
                              groupValue: _selectedPrice,
                              onChanged: (String? value) {
                                setState(() => _selectedPrice = value);
                              },
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                                width: Get.width,
                                padding: EdgeInsets.all(15),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16),
                                    color: const Color.fromARGB(
                                        255, 221, 221, 221)),
                                child: Text(
                                    DataCubit.get(context)
                                        .productsCurrentOrder
                                        .where((element) =>
                                            element.prodId ==
                                            DataCubit.get(context)
                                                .itemsCurrentOrder[index]
                                                .prodId)
                                        .first
                                        .priceThree
                                        .toString(),
                                    style: AppTextStyle.bodyText())),
                          ),
                          Expanded(
                            child: RadioListTile<String>(
                              title: Text(
                                getLang(context).pricethree,
                                style: AppTextStyle.caption(),
                              ),
                              value: 'price3',
                              groupValue: _selectedPrice,
                              onChanged: (String? value) {
                                setState(() => _selectedPrice = value);
                              },
                            ),
                          ),
                        ],
                      ),
                      DefaultButton(
                        onPress: () {
                          double price = _selectedPrice == "price1"
                              ? DataCubit.get(context)
                                  .productsCurrentOrder
                                  .where((element) =>
                                      element.prodId ==
                                      DataCubit.get(context)
                                          .itemsCurrentOrder[index]
                                          .prodId)
                                  .first
                                  .priceOne!
                              : _selectedPrice == "price2"
                                  ? DataCubit.get(context)
                                      .productsCurrentOrder
                                      .where((element) =>
                                          element.prodId ==
                                          DataCubit.get(context)
                                              .itemsCurrentOrder[index]
                                              .prodId)
                                      .first
                                      .priceTwo!
                                  : _selectedPrice == "price3"
                                      ? DataCubit.get(context)
                                          .productsCurrentOrder
                                          .where((element) =>
                                              element.prodId ==
                                              DataCubit.get(context)
                                                  .itemsCurrentOrder[index]
                                                  .prodId)
                                          .first
                                          .priceThree!
                                      : 0;

                          int quanitiy =
                              int.parse(quantityController!.text.toString());

                          DataCubit.get(context).changeProductDesc(
                              quantity: quanitiy, price: price, index: index);

                          Get.back();
                        },
                        buttonText: "save",
                        buttonHeight: 50,
                      )
                    ],
                  ),
                ),
              );
              // return Column(
              //   mainAxisSize: MainAxisSize.min,
              //   children: List<Widget>.generate(4, (int index) {
              // return Radio<int>(
              //   value: index,
              //   groupValue: selectedRadio,
              //   onChanged: (int? value) {
              //     setState(() => selectedRadio = value!);
              //   },
              // );
              //   }),
              // );
            },
          ),
        );
      },
    );

    // String _chosenPrice = "price1";
    // // DataCubit.get(context).itemsCurrentOrder[index].unitPrice.toString();

    // return Dialog(
    //   child: Container(
    //       width: Get.width * .7,
    //       height: Get.height * .5,
    //       margin: const EdgeInsets.all(20),
    //       child: BlocBuilder<DataCubit, DataState>(
    //         builder: (context, state) {
    //           return Form(
    //             key: _keyQuantity,
    //             child: Column(
    //               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //               children: [
    //                 Text(
    //                   getLang(context).prodcut,
    //                   style: AppTextStyle.bodyText(),
    //                 ),
    //                 DefaultTextField(
    //                   labelText: getLang(context).quantity,
    //                   controller: quantityController,
    //                   lines: 1,
    //                   keyboardType: TextInputType.number,
    //                   onChanged: (p0) {
    //                     _keyQuantity.currentState!.validate();
    //                   },
    //                   validator: (p0) {
    //                     if (p0!.isEmpty) {
    //                       return getLang(context).cannotbeempty;
    //                     }
    //                   },
    //                 ),

    //                 RadioButton<String>(
    //                     description: "price 1",
    //                     value: "price1",
    //                     groupValue: _chosenPrice,
    //                     onChanged: (value) {
    //                       setState(
    //                         () {
    //                           _chosenPrice = value!;
    //                         },
    //                       );
    //                     }),
    //                 RadioButton<String>(
    //                     description: "price 2",
    //                     value: "price2",
    //                     groupValue: _chosenPrice,
    //                     onChanged: (value) {
    //                       setState(
    //                         () {
    //                           _chosenPrice = value!;
    //                         },
    //                       );
    //                     }),
    //                 RadioButton<String>(
    //                     description: "price 3",
    //                     value: "price3",
    //                     groupValue: _chosenPrice,
    //                     onChanged: (value) {
    //                       setState(
    //                         () {
    //                           _chosenPrice = value!;
    //                         },
    //                       );
    //                     }),
    // Row(
    //   children: [
    //     Expanded(
    //       child: Container(
    //           width: Get.width,
    //           padding: EdgeInsets.all(15),
    //           decoration: BoxDecoration(
    //               borderRadius: BorderRadius.circular(16),
    //               color:
    //                   const Color.fromARGB(255, 221, 221, 221)),
    //           child: Text(
    // DataCubit.get(context)
    //     .productsCurrentOrder
    //     .where((element) =>
    //         element.prodId ==
    //         DataCubit.get(context)
    //             .itemsCurrentOrder[index]
    //             .prodId)
    //     .first
    //     .priceOne
    //                   .toString(),
    //               style: AppTextStyle.bodyText())),
    //     ),
    //     Expanded(
    //       child: RadioListTile(
    //         // selected: DataCubit.get(context).chosenPrice ==
    //         //     DataCubit.get(context)
    //         //         .productsCurrentOrder
    //         //         .where((element) =>
    //         //             element.prodId ==
    //         //             DataCubit.get(context)
    //         //                 .itemsCurrentOrder[index]
    //         //                 .prodId)
    //         //         .first
    //         //         .priceOne
    //         //         .toString(),
    //         title: Text(
    //           getLang(context).priceone,
    //           style: AppTextStyle.caption(),
    //         ),
    // value: DataCubit.get(context)
    //     .productsCurrentOrder
    //     .where((element) =>
    //         element.prodId ==
    //         DataCubit.get(context)
    //             .itemsCurrentOrder[index]
    //             .prodId)
    //     .first
    //     .priceOne
    //     .toString(),
    //         groupValue: DataCubit.get(context).chosenPrice,
    //         onChanged: (value) async {
    //           await DataCubit.get(context).changePrice(
    //               index, double.parse(value.toString()));
    //         },
    //       ),
    //     ),
    //   ],
    // ),
    // Row(
    //   children: [
    //     Expanded(
    //       child: Container(
    //           width: Get.width,
    //           padding: EdgeInsets.all(15),
    //           decoration: BoxDecoration(
    //               borderRadius: BorderRadius.circular(16),
    //               color:
    //                   const Color.fromARGB(255, 221, 221, 221)),
    //           child: Text(
    //               DataCubit.get(context)
    //                   .productsCurrentOrder
    //                   .where((element) =>
    //                       element.prodId ==
    //                       DataCubit.get(context)
    //                           .itemsCurrentOrder[index]
    //                           .prodId)
    //                   .first
    //                   .priceTwo
    //                   .toString(),
    //               style: AppTextStyle.bodyText())),
    //     ),
    //     Expanded(
    //       child: RadioListTile(
    //         // selected: DataCubit.get(context).chosenPrice ==
    //         //     DataCubit.get(context)
    //         //         .productsCurrentOrder
    //         //         .where((element) =>
    //         //             element.prodId ==
    //         //             DataCubit.get(context)
    //         //                 .itemsCurrentOrder[index]
    //         //                 .prodId)
    //         //         .first
    //         //         .priceTwo
    //         //         .toString(),
    //         title: Text(
    //           getLang(context).pricetwo,
    //           style: AppTextStyle.caption(),
    //         ),
    //         value: DataCubit.get(context)
    //             .productsCurrentOrder
    //             .where((element) =>
    //                 element.prodId ==
    //                 DataCubit.get(context)
    //                     .itemsCurrentOrder[index]
    //                     .prodId)
    //             .first
    //             .priceTwo
    //             .toString(),
    //         groupValue: DataCubit.get(context).chosenPrice,
    //         onChanged: (value) async {
    //           await DataCubit.get(context).changePrice(
    //               index, double.parse(value.toString()));
    //         },
    //       ),
    //     ),
    //   ],
    // ),
    // Row(
    //   children: [
    //     Expanded(
    //       child: Container(
    //           width: Get.width,
    //           padding: EdgeInsets.all(15),
    //           decoration: BoxDecoration(
    //               borderRadius: BorderRadius.circular(16),
    //               color:
    //                   const Color.fromARGB(255, 221, 221, 221)),
    //           child: Text(
    //               DataCubit.get(context)
    //                   .productsCurrentOrder
    //                   .where((element) =>
    //                       element.prodId ==
    //                       DataCubit.get(context)
    //                           .itemsCurrentOrder[index]
    //                           .prodId)
    //                   .first
    //                   .priceThree
    //                   .toString(),
    //               style: AppTextStyle.bodyText())),
    //     ),
    //     Expanded(
    //       child: RadioListTile(
    //         title: Text(
    //           getLang(context).pricethree,
    //           style: AppTextStyle.caption(),
    //         ),
    //         // selected: DataCubit.get(context).chosenPrice ==
    //         //     DataCubit.get(context)
    //         //         .productsCurrentOrder
    //         //         .where((element) =>
    //         //             element.prodId ==
    //         //             DataCubit.get(context)
    //         //                 .itemsCurrentOrder[index]
    //         //                 .prodId)
    //         //         .first
    //         //         .priceThree
    //         //         .toString(),
    //         value: DataCubit.get(context)
    //             .productsCurrentOrder
    //             .where((element) =>
    //                 element.prodId ==
    //                 DataCubit.get(context)
    //                     .itemsCurrentOrder[index]
    //                     .prodId)
    //             .first
    //             .priceThree
    //             .toString(),
    //         groupValue: DataCubit.get(context).chosenPrice,
    //         onChanged: (value) async {
    //           await DataCubit.get(context).changePrice(
    //               index, double.parse(value.toString()));
    //         },
    //       ),
    //     ),
    //   ],
    // ),

    //                 DefaultButton(
    //                   onPress: () {},
    //                   buttonText: "save",
    //                   buttonHeight: 50,
    //                 )
    //               ],
    //             ),
    //           );
    //         },
    //       )),
    // );
  }

  Widget _generateRightHandSideColumnRow(BuildContext context, int index) {
    return GestureDetector(
      onTap: () {
        showDialogAboutQuantity(context, index);
        // showDialog(
        //   context: context,
        //   builder: (context) {
        //     return StatefulBuilder(
        //       builder: (BuildContext context, setState) {
        //         return showDialogAboutQuantity(context, index, setState);
        //       },
        //     );
        //   },
        // );
        // Get.dialog(
        //   ,
        //   // barrierDismissible: false,
        // );
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
