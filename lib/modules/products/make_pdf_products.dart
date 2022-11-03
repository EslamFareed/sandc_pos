import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:printing/printing.dart';
import 'package:sandc_pos/cubits/data_cubit/data_cubit.dart';

import 'pdf_generator_products.dart';

class MakePdfProducts extends StatelessWidget {
  const MakePdfProducts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PDF Preview'),
      ),
      // body: PdfPreview(
      //   build: (ctx) => makePdf(DataCubit.get(context).productModels),
      // ),
    );
  }
}
