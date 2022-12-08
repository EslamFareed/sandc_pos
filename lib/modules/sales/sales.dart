import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart' as getx;
import 'package:group_radio_button/group_radio_button.dart';
import 'package:sandc_pos/core/style/color/app_colors.dart';
import 'package:sandc_pos/layouts/main_screen/main_screen.dart';
import 'package:sandc_pos/modules/home/widgets/item_setting_data.dart';
import 'package:sandc_pos/modules/sales/search_sales/categories_screen.dart';
import 'package:sandc_pos/modules/sales/print_screen.dart';
import 'package:sandc_pos/modules/sales/search_sales/scan_code.dart';
import 'package:sandc_pos/modules/sales/search_sales/search_products.dart';
import 'package:sandc_pos/modules/sales/widgets/item_view_finish_order.dart';
import 'package:sandc_pos/online_models/order_response_model.dart';
import 'package:uuid/uuid.dart';

import '../../core/components/build_popup.dart';
import '../../core/components/default_buttons.dart';
import '../../core/style/text/app_text_style.dart';
import '../../cubits/data_cubit/data_cubit.dart';
import '../../cubits/sales_cubit/sales_cubit.dart';
import '../../online_models/client_response_model.dart';
import '../customers/add_customer.dart';
import 'widgets/table_sales.dart';

class SalesScreen extends StatefulWidget {
  SalesScreen({Key? key}) : super(key: key);

  @override
  State<SalesScreen> createState() => _SalesScreenState();
}

class _SalesScreenState extends State<SalesScreen> {
  TextEditingController? discountController;
  TextEditingController? totalController;
  TextEditingController? paidController;
  TextEditingController? restController;

  @override
  void initState() {
    DataCubit.get(context).itemsCurrentOrder = [];
    DataCubit.get(context).productsCurrentOrder = [];
    DataCubit.get(context).currentOrder = OrderResponseModel(id: Uuid().v4());
    DataCubit.get(context).total = 0;
    DataCubit.get(context).afterDiscount = 0;
    DataCubit.get(context).afterTaxes = 0;
    DataCubit.get(context).discount = 0;
    _clearEveryThing();
    super.initState();
  }

  _clearEveryThing() {
    discountController = TextEditingController();
    totalController = TextEditingController();
    paidController = TextEditingController();
    restController = TextEditingController();
  }

  _buildAppBar() {
    return AppBar(
      title: Text("Sales"),
      centerTitle: true,
    );
  }

  _onWillPop(BuildContext context) {
    buildPopUpMessage(
      context: context,
      content: Text(
        "Want To Exit",
        style: AppTextStyle.bodyText(),
      ),
      title: Image.asset("assets/images/logo.png"),
      actions: [
        DefaultButton(
          onPress: () {
            getx.Get.back(closeOverlays: true);
            getx.Get.back();
          },
          buttonText: "yes",
          buttonWidth: 70.w,
          buttonHeight: 30.h,
        ),
        DefaultButton(
          onPress: () {
            getx.Get.back();
          },
          buttonText: "No",
          buttonWidth: 70.w,
          buttonHeight: 30.h,
        ),
      ],
    ) as Future<bool>;
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DataCubit, DataState>(
      builder: (context, state) {
        return Scaffold(
          appBar: _buildAppBar(),
          body: WillPopScope(
              child: _buildBody(), onWillPop: () => _onWillPop(context)),
        );
      },
      listener: (context, state) {},
    );
  }

  _buildBottom(BuildContext context) {
    return Card(
      elevation: 16,
      child: Container(
        width: getx.Get.width * .9,
        padding: EdgeInsets.all(10),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ItemViewFinishOrder(
                        title: "Total",
                        data: "${DataCubit.get(context).total}",
                      ),
                      const Text("Sale Type"),
                      DropdownButton(
                        value: DataCubit.get(context).chosenSale,
                        items: const [
                          DropdownMenuItem(
                            value: "precentage",
                            child: Text("Sale %"),
                          ),
                          DropdownMenuItem(
                            value: "amount",
                            child: Text("Sale Amount"),
                          ),
                        ],
                        onChanged: (String? value) {
                          if (discountController!.text.isNotEmpty) {
                            DataCubit.get(context).setDiscount(
                                double.parse(discountController!.text));
                          }
                          DataCubit.get(context).chooseSale(value!);
                        },
                      )
                    ],
                  )),
                  Container(width: 50.w),
                  Expanded(
                      child: Column(
                    children: [
                      TextFormField(
                        onChanged: (value) {
                          DataCubit.get(context).setDiscount(
                              value.isNotEmpty ? double.parse(value) : 0);

                          DataCubit.get(context).calcDiscount();
                        },
                        controller: discountController,
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                            floatingLabelAlignment:
                                FloatingLabelAlignment.center,
                            contentPadding: EdgeInsets.all(5),
                            border: OutlineInputBorder(),
                            label: Text("Discount")),
                      ),
                      SizedBox(height: 5.h),
                      ItemViewFinishOrder(
                        title: "After Discount",
                        data:
                            "${DataCubit.get(context).afterDiscount.toStringAsFixed(2)}",
                      ),
                      SizedBox(height: 5.h),
                      ItemViewFinishOrder(
                        title: "After Added Taxes",
                        data:
                            "${DataCubit.get(context).afterTaxes.toStringAsFixed(2)}",
                      ),
                    ],
                  ))
                ],
              ),
              ElevatedButton(
                  onPressed: () {
                    _showDialogFinishOrder();
                  },
                  child: Text("Finish Order"))
            ],
          ),
        ),
      ),
    );
  }

  GlobalKey<FormState> _keyFinishOrder = GlobalKey();

  _showDialogFinishOrder() {
    if (DataCubit.get(context).itemsCurrentOrder.isNotEmpty) {
      DataCubit.get(context).isPayingCash = "Cash";
      DataCubit.get(context).payingType =
          DataCubit.get(context).payTypeModels[0].name;
      totalController!.text =
          DataCubit.get(context).afterTaxes.toStringAsFixed(2);
      paidController!.text = "";
      restController!.text = "";
      DataCubit.get(context).chosenClient = null;
      getx.Get.dialog(
        Dialog(
          child: BlocConsumer<DataCubit, DataState>(
            listener: (context, state) {},
            builder: (context, state) {
              return Form(
                key: _keyFinishOrder,
                child: Container(
                  margin: const EdgeInsets.all(25),
                  width: getx.Get.width * .95,
                  height: getx.Get.height * .8,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Text(
                          "Reciet Details",
                          style: AppTextStyle.bodyText(),
                        ),
                        SizedBox(height: 25.h),
                        FittedBox(
                          child: RadioGroup<String>.builder(
                            groupValue: DataCubit.get(context).isPayingCash!,
                            direction: Axis.horizontal,
                            onChanged: (value) {
                              DataCubit.get(context).changeIsPayingCash(value);
                            },
                            items: ["Cash", "Deferred payment"],
                            itemBuilder: (item) => RadioButtonBuilder(
                              item,
                            ),
                          ),
                        ),
                        SizedBox(height: 25.h),
                        FittedBox(
                          child: RadioGroup<String>.builder(
                            groupValue: DataCubit.get(context).payingType!,
                            direction: Axis.horizontal,
                            onChanged: (value) {
                              DataCubit.get(context).changePayingType(value);
                            },
                            items: DataCubit.get(context)
                                .payTypeModels
                                .map((e) => e.name!)
                                .toList(),
                            itemBuilder: (item) => RadioButtonBuilder(
                              item,
                            ),
                          ),
                        ),
                        SizedBox(height: 25.h),
                        Row(
                          children: [
                            Text(
                              "Total",
                              style: AppTextStyle.bodyText(),
                            ),
                            SizedBox(width: 10.w),
                            Expanded(
                              child: TextFormField(
                                controller: totalController,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                    border: OutlineInputBorder()),
                              ),
                            )
                          ],
                        ),
                        ElevatedButton(
                            onPressed: () {
                              paidController!.text = totalController!.text;
                              restController!.text =
                                  (double.parse(totalController!.text) -
                                          double.parse(paidController!.text))
                                      .toString();
                            },
                            child: Text("Pay All")),
                        SizedBox(height: 25.h),
                        Row(
                          children: [
                            Text(
                              "Paid",
                              style: AppTextStyle.bodyText(),
                            ),
                            SizedBox(width: 10.w),
                            Expanded(
                              child: TextFormField(
                                keyboardType: TextInputType.number,
                                controller: paidController,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "please enter paid amount";
                                  }
                                },
                                onChanged: (value) {
                                  restController!.text =
                                      (double.parse(totalController!.text) -
                                              double.parse(value))
                                          .toString();
                                },
                                decoration: InputDecoration(
                                    border: OutlineInputBorder()),
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: 25.h),
                        Row(
                          children: [
                            Text(
                              "Rest",
                              style: AppTextStyle.bodyText(),
                            ),
                            SizedBox(width: 10.w),
                            Expanded(
                              child: TextFormField(
                                keyboardType: TextInputType.number,
                                controller: restController,
                                decoration: InputDecoration(
                                    border: OutlineInputBorder()),
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: 25.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text("Make reciet for customer"),
                            GestureDetector(
                                onTap: () {
                                  DataCubit.get(context).chooseClient(null);
                                  getx.Get.to(AddCustomer(),
                                      transition: getx.Transition.zoom);
                                },
                                child: Text(
                                  "New Customer",
                                  style: AppTextStyle.caption(),
                                )),
                          ],
                        ),
                        DropdownButton<ClientResponseModel>(
                          isExpanded: true,
                          value: DataCubit.get(context).chosenClient,
                          hint: const Text("Choose Customer"),
                          items: DataCubit.get(context)
                              .clientModels
                              .map((e) => DropdownMenuItem(
                                    value: e,
                                    child: Text(e.name!),
                                  ))
                              .toList(),
                          onChanged: (ClientResponseModel? value) {
                            DataCubit.get(context).chooseClient(value);
                          },
                        ),
                        SizedBox(height: 25.h),
                        Row(
                          children: [
                            Expanded(
                                child: ElevatedButton(
                              child: Text("Save Reciet"),
                              onPressed: () async {
                                await _validateAndFinishOrder();
                              },
                            )),
                            SizedBox(width: 10.w),
                            Expanded(
                                child: ElevatedButton(
                              child: Text("Cancel"),
                              onPressed: () {
                                getx.Get.back();
                              },
                            ))
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        barrierDismissible: false,
      );
    } else {
      getx.Get.showSnackbar(const getx.GetSnackBar(
        message: "Add Some Products",
        duration: Duration(seconds: 1),
        animationDuration: Duration(milliseconds: 200),
      ));
    }
  }

  Widget _customPopupItemBuilderExample2(
    BuildContext context,
    ClientResponseModel? item,
    bool isSelected,
  ) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8),
      decoration: !isSelected
          ? null
          : BoxDecoration(
              border: Border.all(color: Theme.of(context).primaryColor),
              borderRadius: BorderRadius.circular(5),
              color: Colors.white,
            ),
      child: ListTile(
        selected: isSelected,
        title: Text(item?.name ?? ''),
        subtitle: Text(item?.address?.toString() ?? ''),
        leading: CircleAvatar(
            // this does not work - throws 404 error
            // backgroundImage: NetworkImage(item.avatar ?? ''),
            ),
      ),
    );
  }

  _validateAndFinishOrder() async {
    if (_keyFinishOrder.currentState!.validate()) {
      if (double.parse(totalController!.text.toString()) ==
          double.parse(paidController!.text.toString())) {
        //? paying all no debits ///////////////////////////////////////////////////////
        DataCubit.get(context).currentOrder!.debitPay = 0;

        await _finishOrder();
      } else if (double.parse(totalController!.text.toString()) >
          double.parse(paidController!.text.toString())) {
        //? debit paying ///////////////////////////////////////////////////////
        DataCubit.get(context).currentOrder!.debitPay =
            double.parse(restController!.text.toString());
        //? ///////////////////////////////////////////////////////
        await _finishOrder();
      } else {
        getx.Get.showSnackbar(const getx.GetSnackBar(
          message: "must paid amount equal or less than total",
          duration: Duration(seconds: 1),
          animationDuration: Duration(milliseconds: 200),
        ));
      }
    }
  }

  _finishOrder() async {
    //? validate true ///////////////////////////////////////////////////////
    DataCubit.get(context).currentOrder!.payAmount =
        double.parse(paidController!.text.toString());
    //? ///////////////////////////////////////////////////////
    DataCubit.get(context).currentOrder!.discount =
        DataCubit.get(context).chosenSale == "precentage"
            ? (DataCubit.get(context).discount * .01) *
                DataCubit.get(context).total
            : DataCubit.get(context).discount;
    //? ///////////////////////////////////////////////////////
    DataCubit.get(context).currentOrder!.costNet =
        DataCubit.get(context).afterTaxes;
    //? ///////////////////////////////////////////////////////
    DataCubit.get(context).currentOrder!.taxes =
        (double.parse(DataCubit.get(context).companyModels[0].compTaxAmount!) *
                .01) *
            DataCubit.get(context).afterDiscount;
    //? ///////////////////////////////////////////////////////
    DataCubit.get(context).currentOrder!.isPayCash =
        DataCubit.get(context).isPayingCash == "Cash";
    //? ///////////////////////////////////////////////////////
    DataCubit.get(context).currentOrder!.totalCost =
        DataCubit.get(context).total;
    //? ///////////////////////////////////////////////////////
    DataCubit.get(context).currentOrder!.payTypeID = DataCubit.get(context)
        .payTypeModels
        .where((element) => DataCubit.get(context).payingType == element.name)
        .first
        .id;
    //? ///////////////////////////////////////////////////////
    if (DataCubit.get(context).companyModels[0].isMustChoosePayCash!) {
      //? must choose customer ///////////////////////////////////////////////////////

      if (DataCubit.get(context).chosenClient != null) {
        //? choose customer ///////////////////////////////////////////////////////

        DataCubit.get(context).currentOrder!.clientID =
            DataCubit.get(context).chosenClient!.id;
        //? ///////////////////////////////////////////////////////

        _validateIfClientHasAmountinHisPocket();
      } else {
        getx.Get.showSnackbar(const getx.GetSnackBar(
          message: "must choose customer",
          duration: Duration(seconds: 1),
          animationDuration: Duration(milliseconds: 200),
        ));
      }
    } else {
      _validateIfClientHasAmountinHisPocket();
    }
  }

  _validateIfClientHasAmountinHisPocket() async {
    if (!DataCubit.get(context).currentOrder!.isPayCash!) {
      if (DataCubit.get(context).chosenClient!.maxLimtDebitRecietCount != 0 &&
          DataCubit.get(context).chosenClient!.maxDebitLimit! >=
              double.parse(restController!.text.toString())) {
        buildPopUpMessage(
          context: context,
          content: Text(
            "Make Sure this reciet paying debit and not cash",
            style: AppTextStyle.bodyText(),
          ),
          title: Text("Warning"),
          actions: [
            DefaultButton(
              onPress: () async {
                DataCubit.get(context)
                    .clientModels[DataCubit.get(context)
                        .clientModels
                        .indexOf(DataCubit.get(context).chosenClient!)]
                    .updateDataBase = false;

                DataCubit.get(context)
                    .clientModels[DataCubit.get(context)
                        .clientModels
                        .indexOf(DataCubit.get(context).chosenClient!)]
                    .offlineDatabase = false;

                // DataCubit.get(context)
                //     .clientModels[DataCubit.get(context)
                //         .clientModels
                //         .indexOf(DataCubit.get(context).chosenClient!)]
                //     .maxDebitLimit = DataCubit.get(context)
                //         .clientModels[DataCubit.get(context)
                //             .clientModels
                //             .indexOf(DataCubit.get(context).chosenClient!)]
                //         .maxDebitLimit! -
                //     double.parse(restController!.text.toString());

                DataCubit.get(context)
                    .clientModels[DataCubit.get(context)
                        .clientModels
                        .indexOf(DataCubit.get(context).chosenClient!)]
                    .ammountTobePaid = DataCubit.get(context)
                        .clientModels[DataCubit.get(context)
                            .clientModels
                            .indexOf(DataCubit.get(context).chosenClient!)]
                        .ammountTobePaid! +
                    double.parse(restController!.text.toString());

                DataCubit.get(context)
                    .clientModels[DataCubit.get(context)
                        .clientModels
                        .indexOf(DataCubit.get(context).chosenClient!)]
                    .maxLimtDebitRecietCount = DataCubit.get(context)
                        .clientModels[DataCubit.get(context)
                            .clientModels
                            .indexOf(DataCubit.get(context).chosenClient!)]
                        .maxLimtDebitRecietCount! -
                    1;
                await DataCubit.get(context).finishCurrentOrder();
                getx.Get.back(closeOverlays: true);
                getx.Get.showSnackbar(const getx.GetSnackBar(
                  message: "Order Saved Successfully",
                  duration: Duration(seconds: 2),
                  animationDuration: Duration(milliseconds: 200),
                ));
                //Todo
                //! Printer receit
              },
              buttonText: "yes",
              buttonWidth: 70.w,
              buttonHeight: 30.h,
            ),
            DefaultButton(
              onPress: () {
                getx.Get.back();
              },
              buttonText: "No",
              buttonWidth: 70.w,
              buttonHeight: 30.h,
            ),
          ],
        );
      } else {
        getx.Get.showSnackbar(const getx.GetSnackBar(
          message: "no reciets rest for this client",
          duration: Duration(seconds: 2),
          animationDuration: Duration(milliseconds: 200),
        ));
      }
    } else {
      if (double.parse(restController!.text.toString()) == 0) {
        await DataCubit.get(context).finishCurrentOrder();

        getx.Get.back();
        getx.Get.showSnackbar(const getx.GetSnackBar(
          message: "Order Saved Successfully",
          duration: Duration(seconds: 2),
          animationDuration: Duration(milliseconds: 200),
        ));

        _clearEveryThing();

        //Todo
        //! Printer receit
      } else {
        getx.Get.showSnackbar(const getx.GetSnackBar(
          message: "you choose paying cash",
          duration: Duration(seconds: 2),
          animationDuration: Duration(milliseconds: 200),
        ));
      }
    }
  }

  _buildSearchBar() {
    return Container(
      width: getx.Get.width,
      margin: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.primaryColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          //open search
          Expanded(
            child: GestureDetector(
              onTap: () {
                getx.Get.to(
                  SearchProductsScreen(),
                  transition: getx.Transition.fadeIn,
                );
              },
              child: Container(
                margin: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        "Search Product",
                        style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Icon(
                        Icons.search,
                        color: Colors.grey,
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          //open camera scanner
          IconButton(
            icon: const Icon(
              Icons.qr_code_scanner,
              color: Colors.white,
              size: 30,
            ),
            onPressed: () {
              getx.Get.to(const ScanCodeScreen(),
                  transition: getx.Transition.zoom);
            },
          ),
          //open categories
          IconButton(
            icon: const Icon(
              Icons.category_outlined,
              color: Colors.white,
              size: 30,
            ),
            onPressed: () {
              getx.Get.to(CategoriesSearchProductsScreen(),
                  transition: getx.Transition.zoom);
            },
          ),
        ],
      ),
    );
  }

  _buildBody() {
    return Column(
      children: [
        _buildSearchBar(),
        Expanded(child: TableSales()),
        _buildBottom(context)
      ],
    );
  }
}
