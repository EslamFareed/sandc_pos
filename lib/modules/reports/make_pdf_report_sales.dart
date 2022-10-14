import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:printing/printing.dart';
import 'package:sandc_pos/cubits/data_cubit/data_cubit.dart';
import 'package:sandc_pos/models/order.dart';
import 'package:sandc_pos/models/products.dart';

import 'pdf_generator_report_sales.dart';

class MakePdfReportSales extends StatelessWidget {
  MakePdfReportSales({Key? key, this.list}) : super(key: key);
  List<OrderModel>? list;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PDF Preview'),
      ),
      body: PdfPreview(
        build: (ctx) => makePdf(list!),
      ),
    );
  }
}
