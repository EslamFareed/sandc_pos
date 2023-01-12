import 'package:flutter/material.dart';
import 'package:printing/printing.dart';
import 'package:sandc_pos/cubits/data_cubit/data_cubit.dart';

import 'pdf_generator_categories.dart';

class MakePdfCategories extends StatelessWidget {
  const MakePdfCategories({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: PdfPreview(
        build: (ctx) => makePdf(DataCubit.get(context).categoryModels,
            DataCubit.get(context).companyModels[0]),
      ),
    );
  }
}
