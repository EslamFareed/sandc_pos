import 'package:flutter/material.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:sandc_pos/cubits/data_cubit/data_cubit.dart';

import 'pdf_generator_products.dart';

class MakePdfProducts extends StatelessWidget {
  MakePdfProducts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: PdfPreview(
        build: (ctx) => makePdf(DataCubit.get(context).productModels,
            DataCubit.get(context).companyModels[0], context),
      ),
    );
  }
}
