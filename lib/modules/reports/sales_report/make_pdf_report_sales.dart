import 'package:flutter/material.dart';
import 'package:printing/printing.dart';
import 'package:sandc_pos/online_models/order_response_model.dart';

import 'pdf_generator_report_sales.dart';

class MakePdfReportSales extends StatelessWidget {
  MakePdfReportSales({Key? key, this.list, this.total}) : super(key: key);
  List<OrderResponseModel>? list;
  double? total;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PDF Preview'),
      ),
      body: PdfPreview(
        build: (ctx) => makePdf(list!, total!),
      ),
    );
  }
}
