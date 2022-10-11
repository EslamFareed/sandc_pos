import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sandc_pos/cubits/data_cubit/data_cubit.dart';
import 'package:sandc_pos/models/client.dart';
import 'package:uuid/uuid.dart';

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
        title: const Text("Add Mew Customer"),
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
          labelText: "Full Name",
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
              return "Full name must be not empty";
            }
          },
        ),
        SizedBox(height: 10.h),
        DefaultTextField(
          labelText: "Address",
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
              return "Address must be not empty";
            }
          },
        ),
        SizedBox(height: 10.h),
        DefaultTextField(
          labelText: "Phone",
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
              return "Phone must be not empty";
            }
          },
        ),
        SizedBox(height: 10.h),
        DefaultTextField(
          labelText: "Amount on him",
          lines: 1,
          controller: amountOnHimController,
          keyboardType: TextInputType.number,
        ),
        SizedBox(height: 10.h),
        DefaultTextField(
          labelText: "Maximum indebtedness",
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
              return "Maximum indebtedness must be not empty";
            }
          },
        ),
        SizedBox(height: 10.h),
        DefaultTextField(
          labelText: "Maximum indebtedness bills",
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
              return "Maximum indebtedness bills must be not empty";
            }
          },
        ),
        SizedBox(height: 10.h),
        DefaultTextField(
          labelText: "Tax Number",
          lines: 1,
          controller: taxNumberController,
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
          labelText: "Notes",
          lines: 3,
          controller: notesController,
        ),
        SizedBox(height: 50.h),
        DefaultButton(
          onPress: () async {
            if (_keyForm.currentState!.validate()) {
              ClientModel item = ClientModel(
                  id: Uuid().v1(),
                  name: fullnameController.text,
                  phone: phoneController.text,
                  address: addressController.text,
                  ammountTobePaid: double.parse(amountOnHimController.text),
                  comment: notesController.text,
                  companyId: 1,
                  createDate: "date",
                  empID: 1,
                  isActive: true,
                  loacation: "location",
                  maxDebitLimit: double.parse(maxDebitController.text),
                  maxLimtDebitRecietCount:
                      double.parse(maxDebitBillsController.text),
                  taxNumber: taxNumberController.text,
                  updateDate: "date");
              await DataCubit.get(context).insertClientTable(item);
              await DataCubit.get(context).getAllClientTable();
              Get.showSnackbar(const GetSnackBar(
                message: "Create successfully",
                duration: Duration(seconds: 2),
              ));
              Get.back(closeOverlays: true);
            } else {
              Get.showSnackbar(const GetSnackBar(
                message: "Create Error",
                duration: Duration(seconds: 2),
              ));
            }
          },
          buttonText: "Save Customer Data",
          buttonBorderCircular: 16,
          buttonHeight: 35.h,
        ),
        SizedBox(height: 25.h),
      ],
    );
  }
}
