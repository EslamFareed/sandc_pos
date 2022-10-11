import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sandc_pos/core/components/app_currency.dart';
import 'package:sandc_pos/cubits/data_cubit/data_cubit.dart';
import 'package:sandc_pos/models/company.dart';

import '../../core/components/app_language.dart';
import '../../core/components/default_buttons.dart';
import '../../core/components/text_form_field.dart';
import '../../core/style/color/app_colors.dart';
import '../../models/currency.dart';

class SettingsScreen extends StatefulWidget {
  SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool? isPriceIncludesTaxes = false;
  bool? mustChooseCustomerWhenPayCash = false;
  bool? cancelTaxes = false;

  TextEditingController companyNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController notesController = TextEditingController();
  TextEditingController valueAddedTaxesController = TextEditingController();
  TextEditingController taxesNumberController = TextEditingController();

  GlobalKey<FormState> _keyForm = GlobalKey();

  @override
  void initState() {
    _getData();

    super.initState();
  }

  _getData() async {
    // await DataCubit.get(context).getCurrentCompany();
    // await DataCubit.get(context)
    //     .insertCurrencyTable(CurrencyModel(id: 1, name: "USD"));
    // await DataCubit.get(context)
    //     .insertCurrencyTable(CurrencyModel(id: 2, name: "SAR"));
    // await DataCubit.get(context).insertCompanyTable(CompanyModel(
    //     id: 1,
    //     address: "address",
    //     companyDescription: "desc",
    //     companyName: "name",
    //     currencyId: 1,
    //     createDate: "date",
    //     email: "email",
    //     verifiedAt: "date",
    //     isAdmin: true,
    //     isConfirmed: true,
    //     isTaxes: true,
    //     isMustChoosePayCash: true,
    //     language: "language",
    //     logo: "logo",
    //     password: "password",
    //     passwordResetToken: "token",
    //     passwordSalt: "salt",
    //     phone: "01016361173",
    //     taxAmount: 50,
    //     taxNumber: "tax",
    //     restTokenExpires: "token",
    //     verificationToken: "token"));

    // await DataCubit.get(context).getAllCurrencyTable();
    // await DataCubit.get(context).getAllCompanyTable();
    // companyModel = await DataCubit.get(context).getCompanyModelById(1);
    // print(companyModel.toJson());
    // print(DataCubit.get(context).currencyModels);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DataCubit, DataState>(
        builder: (context, state) {
          var cubit = DataCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: const Text("Settings"),
            ),
            body: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Stack(
                children: [
                  Align(
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
                        child: _buildForm(context, cubit)),
                  ),
                ],
              ),
            ),
          );
        },
        listener: (context, state) {});
  }

  _buildForm(BuildContext context, DataCubit cubit) {
    if (cubit.companyModel != null) {
      companyNameController.text = cubit.companyModel!.companyName!;
      phoneController.text = cubit.companyModel!.phone!;
      addressController.text = cubit.companyModel!.address!;
      notesController.text = cubit.companyModel!.companyDescription!;
      valueAddedTaxesController.text =
          cubit.companyModel!.taxAmount!.toString();
      taxesNumberController.text = cubit.companyModel!.taxNumber!;
      cancelTaxes = !(cubit.companyModel!.isTaxes!);
      mustChooseCustomerWhenPayCash = cubit.companyModel!.isMustChoosePayCash!;
    }
    return Form(
      key: _keyForm,
      child: Column(
        children: [
          const Text("Company Logo"),
          GestureDetector(
            onTap: () {},
            child: Icon(
              Icons.add_photo_alternate_outlined,
              size: 100,
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Company Name That shown in sales bill"),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: const Color.fromARGB(255, 221, 221, 221)),
                child: TextFormField(
                  enabled: false,
                  decoration: const InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.all(10)),
                  minLines: 1,
                  maxLines: 1,
                  controller: companyNameController,
                ),
              )
            ],
          )
          // DefaultTextField(
          //   labelText: "Company Name That shown in sales bill",
          //   controller: companyNameController,
          // ),
          ,
          SizedBox(height: 10.h),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Phone"),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: const Color.fromARGB(255, 221, 221, 221)),
                child: TextFormField(
                  enabled: false,
                  decoration: const InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.all(10)),
                  minLines: 1,
                  maxLines: 1,
                  controller: phoneController,
                ),
              )
            ],
          ),
          SizedBox(height: 10.h),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Address"),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: const Color.fromARGB(255, 221, 221, 221)),
                child: TextFormField(
                  enabled: false,
                  decoration: const InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.all(10)),
                  minLines: 1,
                  maxLines: 1,
                  controller: addressController,
                ),
              )
            ],
          ),
          SizedBox(height: 10.h),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Notes Writen in the last of bill"),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: const Color.fromARGB(255, 221, 221, 221)),
                child: TextFormField(
                  enabled: false,
                  decoration: const InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.all(10)),
                  minLines: 1,
                  maxLines: 1,
                  controller: notesController,
                ),
              )
            ],
          ),
          SizedBox(height: 10.h),
          Container(
            alignment: getLang(context).localeName == "ar"
                ? Alignment.centerRight
                : Alignment.centerLeft,
            child: Text(
              "Language",
            ),
          ),
          LangSwitch(isExpanded: true, width: Get.width),
          SizedBox(height: 10.h),
          Container(
            alignment: getLang(context).localeName == "ar"
                ? Alignment.centerRight
                : Alignment.centerLeft,
            child: Text(
              "Currency",
            ),
          ),
          CurrencySwitch(isExpanded: true, width: Get.width),
          SizedBox(height: 10.h),
          CheckboxListTile(
            enabled: false,
            value: cancelTaxes,
            onChanged: (val) {
              setState(() {
                cancelTaxes = val;
              });
            },
            title: Text("Cancel Taxes"),
          ),
          SizedBox(height: 5.h),
          Row(
            children: [
              Text("value added tax"),
              SizedBox(width: 10.w),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: const Color.fromARGB(255, 221, 221, 221)),
                  child: TextFormField(
                    enabled: false,
                    controller: valueAddedTaxesController,
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.all(10),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 10.w),
              Text(
                "%",
                style: TextStyle(color: AppColors.primaryColor),
              )
            ],
          ),
          SizedBox(height: 5.h),
          Row(
            children: [
              Text("Taxes Number"),
              SizedBox(width: 10.w),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: const Color.fromARGB(255, 221, 221, 221)),
                  child: TextFormField(
                    controller: taxesNumberController,
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.all(10),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 10.h),
          CheckboxListTile(
            enabled: false,
            value: isPriceIncludesTaxes,
            onChanged: (val) {
              setState(() {
                isPriceIncludesTaxes = val;
              });
            },
            title: Text("Price includes Taxes"),
          ),
          SizedBox(height: 10.h),
          CheckboxListTile(
            enabled: false,
            value: mustChooseCustomerWhenPayCash,
            onChanged: (val) {
              setState(() {
                mustChooseCustomerWhenPayCash = val;
              });
            },
            title: Text("must choose customer when pay cash"),
          ),
          SizedBox(height: 50.h),
          // DefaultButton(
          //   onPress: () {},
          //   buttonText: "Save Data",
          //   buttonBorderCircular: 16,
          //   buttonHeight: 35.h,
          // ),
          // SizedBox(height: 25.h),
        ],
      ),
    );
  }
}
