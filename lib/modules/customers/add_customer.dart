import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sandc_pos/cubits/data_cubit/data_cubit.dart';
import 'package:sandc_pos/online_models/client_response_model.dart';
import 'package:uuid/uuid.dart';

import '../../core/components/app_language.dart';
import '../../core/components/default_buttons.dart';
import '../../core/components/text_form_field.dart';
import '../../core/style/color/app_colors.dart';

class AddCustomer extends StatelessWidget {
  AddCustomer({super.key});

  GlobalKey<FormState> _keyForm = GlobalKey();

  TextEditingController fullnameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController amountOnHimController = TextEditingController();
  TextEditingController maxDebitController = TextEditingController();
  TextEditingController maxDebitBillsController = TextEditingController();
  TextEditingController taxNumberController = TextEditingController();
  TextEditingController notesController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(getLang(context).addMewCustomer),
      ),
      body: Form(
        key: _keyForm,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Stack(
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                    width: Get.width * .8,
                    margin: EdgeInsets.only(top: 50.h, bottom: 50.h),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: AppColors.whitBackGroundColor,
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.grey,
                          blurRadius: 8,
                          blurStyle: BlurStyle.outer,
                          offset: Offset(0, 0),
                          spreadRadius: 10,
                        ),
                      ],
                    ),
                    child: _buildForm(context)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _buildForm(BuildContext context) {
    return Column(
      children: [
        Image.asset("assets/icons/add_customer.png"),
        DefaultTextField(
          labelText: getLang(context).fullName,
          lines: 1,
          controller: fullnameController,
          onChanged: (value) {
            if (!_keyForm.currentState!.validate()) {
              if (kDebugMode) {
                print("validate error");
              }
            }
          },
          validator: (value) {
            if (value!.isEmpty) {
              return getLang(context).fullnamemustbenotempty;
            }
          },
        ),
        SizedBox(height: 10.h),
        DefaultTextField(
          labelText: getLang(context).address,
          lines: 1,
          controller: addressController,
          onChanged: (value) {
            if (!_keyForm.currentState!.validate()) {
              if (kDebugMode) {
                print("validate error");
              }
            }
          },
          validator: (value) {
            if (value!.isEmpty) {
              return getLang(context).addressmustbenotempty;
            }
          },
        ),
        SizedBox(height: 10.h),
        DefaultTextField(
          labelText: getLang(context).phone,
          lines: 1,
          controller: phoneController,
          keyboardType: TextInputType.phone,
          onChanged: (value) {
            if (!_keyForm.currentState!.validate()) {
              if (kDebugMode) {
                print("validate error");
              }
            }
          },
          validator: (value) {
            if (value!.isEmpty) {
              return getLang(context).phonemustbenotempty;
            }
          },
        ),
        SizedBox(height: 10.h),
        DefaultTextField(
          labelText: getLang(context).amountonhim,
          lines: 1,
          controller: amountOnHimController,
          keyboardType: TextInputType.number,
        ),
        SizedBox(height: 10.h),
        DefaultTextField(
          labelText: getLang(context).maximumindebtedness,
          lines: 1,
          controller: maxDebitController,
          keyboardType: TextInputType.number,
          onChanged: (value) {
            if (!_keyForm.currentState!.validate()) {
              if (kDebugMode) {
                print("validate error");
              }
            }
          },
          validator: (value) {
            if (value!.isEmpty) {
              return getLang(context).maximumindebtednessmustbenotempty;
            }
          },
        ),
        SizedBox(height: 10.h),
        DefaultTextField(
          labelText: getLang(context).maximumindebtednessbills,
          keyboardType: TextInputType.number,
          lines: 1,
          controller: maxDebitBillsController,
          onChanged: (value) {
            if (!_keyForm.currentState!.validate()) {
              if (kDebugMode) {
                print("validate error");
              }
            }
          },
          validator: (value) {
            if (value!.isEmpty) {
              return getLang(context).maximumindebtednessbillsmustbenotempty;
            }
          },
        ),
        SizedBox(height: 10.h),
        DefaultTextField(
          labelText: getLang(context).taxnumber,
          lines: 1,
          controller: taxNumberController,
          keyboardType: TextInputType.number,
        ),
        SizedBox(height: 10.h),
        // Column(
        //   mainAxisAlignment: MainAxisAlignment.start,
        //   crossAxisAlignment: CrossAxisAlignment.start,
        //   children: [
        //     const Text("Address on map"),
        //     Image.asset("assets/images/map_choose.png"),
        //   ],
        // ),
        DefaultTextField(
          labelText: getLang(context).notes,
          lines: 3,
          controller: notesController,
        ),
        SizedBox(height: 50.h),
        DefaultButton(
          onPress: () async {
            if (_keyForm.currentState!.validate()) {
              if (double.parse(amountOnHimController.text) <=
                      double.parse(maxDebitController.text) &&
                  int.parse(maxDebitBillsController.text) > 0) {
                if (DataCubit.get(context).clientModels.length == 10 &&
                    DataCubit.get(context).companyModels[0].isDemo!) {
                  Get.showSnackbar(
                    const GetSnackBar(
                      title: "limited access",
                    ),
                  );
                } else {
                  _saveOffline(context);
                }
              } else {
                Get.showSnackbar(GetSnackBar(
                  message: getLang(context).createError,
                  duration: const Duration(seconds: 2),
                ));
              }
            } else {
              Get.showSnackbar(GetSnackBar(
                message: getLang(context).createError,
                duration: const Duration(seconds: 2),
              ));
            }
          },
          buttonText: getLang(context).saveCustomerData,
          buttonBorderCircular: 16,
          buttonHeight: 35.h,
        ),
        SizedBox(height: 25.h),
      ],
    );
  }

  _saveOffline(BuildContext context) async {
    ClientResponseModel item = ClientResponseModel(
      offlineDatabase: false,
      updateDataBase: false,
      id: Uuid().v4(),
      name: fullnameController.text,
      phone: phoneController.text,
      address: addressController.text,
      ammountTobePaid: double.parse(amountOnHimController.text),
      comment: notesController.text,
      isActive: true,
      loacation: "location",
      maxDebitLimit: double.parse(maxDebitController.text),
      maxLimtDebitRecietCount: int.parse(maxDebitBillsController.text),
      taxNumber: taxNumberController.text,
      companyId: DataCubit.get(context).companyModels[0].compId,
      empID: DataCubit.get(context).companyModels[0].empId,
    );
    await DataCubit.get(context).insertClientInSaleScreen(item);
    await DataCubit.get(context).getAllClientTable();

    Get.back();
  }
}
