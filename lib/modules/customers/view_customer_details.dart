import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sandc_pos/modules/home/widgets/item_setting_data.dart';
import 'package:sandc_pos/online_models/client_response_model.dart';

import '../../core/components/app_language.dart';

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
              ItemSettingData(
                  title: getLang(context).fullName, data: item!.name!),
              ItemSettingData(
                  title: getLang(context).phone, data: item!.phone!),
              ItemSettingData(
                  title: getLang(context).address, data: item!.address!),
              ItemSettingData(
                  title: getLang(context).notes, data: item!.comment!),
              ItemSettingData(
                  title: getLang(context).debitamount,
                  data: "${item!.ammountTobePaid!}"),
              ItemSettingData(
                  title: getLang(context).maximumindebtedness,
                  data: "${item!.maxDebitLimit!}"),
              ItemSettingData(
                  title: getLang(context).maximumindebtednessbills,
                  data: "${item!.maxLimtDebitRecietCount!}"),
              ItemSettingData(
                  title: getLang(context).taxnumber, data: item!.taxNumber!),
            ],
          ),
        ),
      ),
    );
  }
}
