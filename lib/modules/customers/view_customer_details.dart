import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sandc_pos/modules/home/widgets/item_setting_data.dart';
import 'package:sandc_pos/online_models/client_response_model.dart';

class ViewCustomerDetails extends StatelessWidget {
  ViewCustomerDetails({super.key, this.item});

  ClientResponseModel? item;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(item!.name!),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Container(
          margin: const EdgeInsets.all(20),
          child: Column(
            children: [
              ItemSettingData(title: "Name", data: item!.name!),
              ItemSettingData(title: "Phone", data: item!.phone!),
              ItemSettingData(title: "Address", data: item!.address!),
              ItemSettingData(title: "Note", data: item!.comment!),
              ItemSettingData(
                  title: "Debit Amount", data: "${item!.ammountTobePaid!}"),
              ItemSettingData(
                  title: "Max Debit Limit Amount",
                  data: "${item!.maxDebitLimit!}"),
              ItemSettingData(
                  title: "Max Debit Limit Reciets",
                  data: "${item!.maxLimtDebitRecietCount!}"),
              ItemSettingData(title: "Tax Number", data: item!.taxNumber!),
            ],
          ),
        ),
      ),
    );
  }
}
