import 'dart:typed_data';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:sandc_pos/online_models/order_response_model.dart';

Future<Uint8List> makePdf(List<OrderResponseModel> orders) async {
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
                  Row(children: [
                    Expanded(
                      child: PaddedText("id"),
                      flex: 1,
                    ),
                    Expanded(
                      child: PaddedText("name"),
                      flex: 1,
                    ),
                    Expanded(
                      child: PaddedText("date"),
                      flex: 1,
                    ),
                    Expanded(
                      child: PaddedText("total cost"),
                      flex: 1,
                    ),
                    Expanded(
                      child: PaddedText("pay amount"),
                      flex: 1,
                    ),
                  ]),
                  Table(
                    border: TableBorder.all(color: PdfColors.black),
                    children: [
                      ...orders.map(
                        (e) => TableRow(
                          children: [
                            Expanded(
                              child: PaddedText(e.id!),
                              flex: 1,
                            ),
                            Expanded(
                              child: PaddedText("eslam fareed"),
                              flex: 1,
                            ),
                            Expanded(
                              child: PaddedText("${e.createDate}"),
                              flex: 1,
                            ),
                            Expanded(
                              child: PaddedText("${e.totalCost}"),
                              flex: 1,
                            ),
                            Expanded(
                              child: PaddedText("${e.payAmount}"),
                              flex: 1,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
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
}) =>
    Padding(
      padding: EdgeInsets.all(10),
      child: Text(
        text,
        textAlign: align,
      ),
    );
