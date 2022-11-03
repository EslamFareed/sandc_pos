import 'dart:typed_data';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:sandc_pos/online_models/client_response_model.dart';

Future<Uint8List> makePdf(List<ClientResponseModel> clients) async {
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
                      child: PaddedText("name"),
                      flex: 1,
                    ),
                    Expanded(
                      child: PaddedText("phone"),
                      flex: 1,
                    ),
                    Expanded(
                      child: PaddedText("address"),
                      flex: 1,
                    ),
                    Expanded(
                      child: PaddedText("amount to be paid"),
                      flex: 1,
                    ),
                    Expanded(
                      child: PaddedText("max Debit Limit"),
                      flex: 1,
                    ),
                    Expanded(
                      child: PaddedText("max Limt Debit Reciet Count"),
                      flex: 1,
                    ),
                  ]),
                  Table(
                    border: TableBorder.all(color: PdfColors.black),
                    children: [
                      ...clients.map(
                        (e) => TableRow(
                          children: [
                            Expanded(
                              child: PaddedText(e.name!),
                              flex: 1,
                            ),
                            Expanded(
                              child: PaddedText("${e.phone}"),
                              flex: 1,
                            ),
                            Expanded(
                              child: PaddedText("${e.address}"),
                              flex: 1,
                            ),
                            Expanded(
                              child: PaddedText("${e.ammountTobePaid}"),
                              flex: 1,
                            ),
                            Expanded(
                              child: PaddedText("${e.maxDebitLimit}"),
                              flex: 1,
                            ),
                            Expanded(
                              child: PaddedText("${e.maxLimtDebitRecietCount}"),
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
