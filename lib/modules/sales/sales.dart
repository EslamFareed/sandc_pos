import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart' as getx;
import 'package:group_radio_button/group_radio_button.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sandc_pos/core/components/app_language.dart';

import 'package:screenshot/screenshot.dart';
import 'package:uuid/uuid.dart';

import 'package:sandc_pos/core/style/color/app_colors.dart';
import 'package:sandc_pos/core/utils/printer_manager.dart';

import 'package:sandc_pos/modules/sales/search_sales/categories_screen.dart';
import 'package:sandc_pos/modules/sales/search_sales/scan_code.dart';
import 'package:sandc_pos/modules/sales/search_sales/search_products.dart';
import 'package:sandc_pos/modules/sales/widgets/item_view_finish_order.dart';
import 'package:sandc_pos/online_models/order_response_model.dart';
import 'package:sandc_pos/reposetories/shared_pref/cache_keys.dart';

import '../../core/components/build_popup.dart';
import '../../core/components/default_buttons.dart';
import '../../core/style/text/app_text_style.dart';
import '../../cubits/data_cubit/data_cubit.dart';
import '../../online_models/client_response_model.dart';
import '../customers/add_customer.dart';
import 'components/pdf_generator_order.dart';
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
  ScreenshotController screenshotController = ScreenshotController();
  Uint8List? _imageReciet;
  @override
  void initState() {
    DataCubit.get(context).itemsCurrentOrder = [];
    DataCubit.get(context).productsCurrentOrder = [];
    _getCurrentId();
    DataCubit.get(context).total = 0;
    DataCubit.get(context).afterDiscount = 0;
    DataCubit.get(context).afterTaxes = 0;
    DataCubit.get(context).discount = 0;
    _clearEveryThing();
    super.initState();
  }

  _getCurrentId() {
    int lastId = 0;
    DataCubit.get(context).orderModels.forEach((element) {
      if (element.countID! > lastId) {
        lastId = element.countID!;
      }
    });
    lastId++;
    DataCubit.get(context).currentOrder = OrderResponseModel(
        id: "${DataCubit.get(context).companyModels[0].branchId}${DataCubit.get(context).companyModels[0].empId}$lastId",
        countID: lastId);
    print(DataCubit.get(context).currentOrder!.countID);
  }

  _clearEveryThing() {
    discountController = TextEditingController();
    totalController = TextEditingController();
    paidController = TextEditingController();
    restController = TextEditingController();
  }

  _buildAppBar() {
    return AppBar(
      title: Text(getLang(context).sales),
      centerTitle: true,
    );
  }

  _onWillPop(BuildContext context) {
    buildPopUpMessage(
      context: context,
      content: Text(
        getLang(context).wantToExit,
        style: AppTextStyle.bodyText(),
      ),
      title: Image.asset("assets/images/logo.png"),
      actions: [
        DefaultButton(
          onPress: () {
            getx.Get.back(closeOverlays: true);
            getx.Get.back();
          },
          buttonText: getLang(context).yes,
          buttonWidth: 70.w,
          buttonHeight: 30.h,
        ),
        DefaultButton(
          onPress: () {
            getx.Get.back();
          },
          buttonText: getLang(context).no,
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
                        title: getLang(context).total,
                        data: "${DataCubit.get(context).total}",
                      ),
                      Text(getLang(context).saleType),
                      DropdownButton(
                        value: DataCubit.get(context).chosenSale,
                        items: [
                          DropdownMenuItem(
                            value: "precentage",
                            child: Text(getLang(context).sale),
                          ),
                          DropdownMenuItem(
                            value: "amount",
                            child: Text(getLang(context).saleAmount),
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
                        decoration: InputDecoration(
                            floatingLabelAlignment:
                                FloatingLabelAlignment.center,
                            contentPadding: const EdgeInsets.all(5),
                            border: const OutlineInputBorder(),
                            label: Text(getLang(context).discount)),
                      ),
                      SizedBox(height: 5.h),
                      ItemViewFinishOrder(
                        title: getLang(context).afterDiscount,
                        data: DataCubit.get(context)
                            .afterDiscount
                            .toStringAsFixed(2),
                      ),
                      SizedBox(height: 5.h),
                      ItemViewFinishOrder(
                        title: getLang(context).afterAddedTaxes,
                        data: DataCubit.get(context)
                                .companyModels[0]
                                .isPriceIncludeTaxes!
                            ? DataCubit.get(context)
                                .afterDiscount
                                .toStringAsFixed(2)
                            : DataCubit.get(context)
                                .afterTaxes
                                .toStringAsFixed(2),
                      ),
                    ],
                  ))
                ],
              ),
              ElevatedButton(
                  onPressed: () {
                    _showDialogFinishOrder();
                  },
                  child: Text(getLang(context).finishOrder))
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
          DataCubit.get(context).companyModels[0].isPriceIncludeTaxes!
              ? DataCubit.get(context).afterDiscount.toStringAsFixed(2)
              : DataCubit.get(context).afterTaxes.toStringAsFixed(2);
      paidController!.text = "";
      restController!.text = "";
      DataCubit.get(context).chosenClient = null;
      getx.Get.dialog(
        Dialog(
          child: BlocConsumer<DataCubit, DataState>(
            listener: (context, state) {},
            builder: (context, state) {
              return Directionality(
                textDirection: TextDirection.ltr,
                child: Form(
                  key: _keyFinishOrder,
                  child: Container(
                    margin: const EdgeInsets.all(5),
                    width: getx.Get.width,
                    height: getx.Get.height * .8,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Text(
                            getLang(context).recietDetails,
                            style: AppTextStyle.bodyText(),
                          ),
                          SizedBox(height: 15.h),
                          FittedBox(
                            child: RadioGroup<String>.builder(
                              groupValue: DataCubit.get(context).isPayingCash!,
                              direction: Axis.horizontal,
                              onChanged: (value) {
                                DataCubit.get(context)
                                    .changeIsPayingCash(value);
                              },
                              items: ["Cash", "Deferred payment"],
                              itemBuilder: (item) => RadioButtonBuilder(
                                item,
                              ),
                            ),
                          ),
                          SizedBox(height: 15.h),
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
                          SizedBox(height: 15.h),
                          Row(
                            children: [
                              Text(
                                getLang(context).total,
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
                              child: Text(getLang(context).payAll)),
                          SizedBox(height: 25.h),
                          Row(
                            children: [
                              Text(
                                getLang(context).paid,
                                style: AppTextStyle.bodyText(),
                              ),
                              SizedBox(width: 10.w),
                              Expanded(
                                child: TextFormField(
                                  keyboardType: TextInputType.number,
                                  controller: paidController,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return getLang(context)
                                          .pleaseenterpaidamount;
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
                                getLang(context).rest,
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
                              Text(getLang(context).makerecietforcustomer),
                              GestureDetector(
                                  onTap: () {
                                    DataCubit.get(context).chooseClient(null);
                                    getx.Get.to(AddCustomer(),
                                        transition: getx.Transition.zoom);
                                  },
                                  child: Text(
                                    getLang(context).newCustomer,
                                    style: AppTextStyle.caption(),
                                  )),
                            ],
                          ),
                          DropdownButton<ClientResponseModel>(
                            isExpanded: true,
                            value: DataCubit.get(context).chosenClient,
                            hint: Text(getLang(context).chooseCustomer),
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
                                child: Text(getLang(context).saveReciet),
                                onPressed: () async {
                                  await _validateAndFinishOrder();
                                },
                              )),
                              SizedBox(width: 10.w),
                              Expanded(
                                  child: ElevatedButton(
                                child: Text(getLang(context).cancel),
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
                ),
              );
            },
          ),
        ),
        barrierDismissible: false,
      );
    } else {
      getx.Get.showSnackbar(getx.GetSnackBar(
        message: getLang(context).addSomeProducts,
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
        getx.Get.showSnackbar(getx.GetSnackBar(
          message: getLang(context).mustpaidamountequalorlessthantotal,
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
        DataCubit.get(context).companyModels[0].isPriceIncludeTaxes!
            ? DataCubit.get(context).afterDiscount
            : DataCubit.get(context).afterTaxes;
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
        getx.Get.showSnackbar(getx.GetSnackBar(
          message: getLang(context).must_choose_customer_when_pay_cash,
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
            getLang(context).makeSurethisrecietpayingdebitandnotcash,
            style: AppTextStyle.bodyText(),
          ),
          title: Text(getLang(context).warning),
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
                getx.Get.back();
                getx.Get.showSnackbar(getx.GetSnackBar(
                  message: getLang(context).orderSavedSuccessfully,
                  duration: Duration(seconds: 2),
                  animationDuration: Duration(milliseconds: 200),
                ));
                _clearEveryThing();

                //Todo
                //! Printer receit
                _printReciept();
              },
              buttonText: getLang(context).yes,
              buttonWidth: 70.w,
              buttonHeight: 30.h,
            ),
            DefaultButton(
              onPress: () {
                getx.Get.back();
              },
              buttonText: getLang(context).no,
              buttonWidth: 70.w,
              buttonHeight: 30.h,
            ),
          ],
        );
      } else {
        getx.Get.showSnackbar(getx.GetSnackBar(
          message: getLang(context).norecietsrestforthisclient,
          duration: Duration(seconds: 2),
          animationDuration: Duration(milliseconds: 200),
        ));
      }
    } else {
      if (double.parse(restController!.text.toString()) == 0) {
        await DataCubit.get(context).finishCurrentOrder();

        getx.Get.back();
        getx.Get.showSnackbar(getx.GetSnackBar(
          message: getLang(context).orderSavedSuccessfully,
          duration: Duration(seconds: 2),
          animationDuration: Duration(milliseconds: 200),
        ));

        _clearEveryThing();

        //Todo
        //! Printer receit
        _printReciept();
      } else {
        getx.Get.showSnackbar(getx.GetSnackBar(
          message: getLang(context).youchoosepayingcash,
          duration: Duration(seconds: 2),
          animationDuration: Duration(milliseconds: 200),
        ));
      }
    }
  }

  _printReciept() async {
    _imageReciet = await PdfGenerator().createPdf(DataCubit.get(context));

    getx.Get.dialog(Dialog(
      child: Column(
        children: [
          Expanded(child: Image.memory(_imageReciet!)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                  onPressed: () async {
                    String path =
                        (await getApplicationDocumentsDirectory()).path;
                    File file = File(
                        "$path${DataCubit.get(context).currentOrder!.id}.png");

                    await file.writeAsBytes(_imageReciet!);
                    PrinterManager.printImg(file.path,
                        CacheKeysManger.getPrinterWidthPaperFromCache());
                    DataCubit.get(context).clearCurrentOrder();
                  },
                  child: Text(getLang(context).print)),
              ElevatedButton(
                  onPressed: () {
                    DataCubit.get(context).clearCurrentOrder();

                    getx.Get.back();
                  },
                  child: Text(getLang(context).cancel)),
            ],
          )
        ],
      ),
    ));
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
                    children: [
                      Text(
                        getLang(context).searchProduct,
                        style: const TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Icon(
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
