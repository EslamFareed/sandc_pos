import 'package:flutter/material.dart';
import 'package:printing/printing.dart';
import 'package:sandc_pos/cubits/data_cubit/data_cubit.dart';

import 'pdf_generator_customer.dart';

class MakePdfClients extends StatelessWidget {
  const MakePdfClients({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: PdfPreview(
        build: (ctx) => makePdf(DataCubit.get(context).clientModels,
            DataCubit.get(context).companyModels[0]),
      ),
    );
  }
}
