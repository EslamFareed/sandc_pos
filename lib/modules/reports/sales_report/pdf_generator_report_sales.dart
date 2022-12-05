import 'dart:typed_data';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:printing/printing.dart';
import 'package:sandc_pos/online_models/order_response_model.dart';

Future<Uint8List> makePdf(List<OrderResponseModel> orders, double total) async {
  final pdf = Document();

  pdf.addPage(
    Page(
      build: (context) {
        return Column(
          children: [
            Container(height: 50),
            Header(
                decoration: BoxDecoration(
                  border: Border.all(width: 1),
                ),
                child: Column(children: [
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    Expanded(child: PaddedText("id")),
                    Expanded(child: PaddedText("date")),
                    Expanded(child: PaddedText("total cost")),
                    Expanded(child: PaddedText("pay amount")),
                  ]),
                  Table(
                    border: TableBorder.all(color: PdfColors.black),
                    children: [
                      ...orders.map(
                        (e) => TableRow(
                          children: [
                            Expanded(
                              child: PaddedText(e.id!),
                            ),
                            Expanded(
                              child: PaddedText("${e.createDate}"),
                            ),
                            Expanded(
                              child: PaddedText("${e.totalCost}"),
                            ),
                            Expanded(
                              child: PaddedText("${e.payAmount}"),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Text("total : $total", style: TextStyle(fontSize: 25))
                ])),
          ],
        );
      },
    ),
  );
  return pdf.save();
}

Widget PaddedText(
  final String text, {
  final TextAlign align = TextAlign.left,
}) {
  return Text(
    text,
    textAlign: align,
  );
}
