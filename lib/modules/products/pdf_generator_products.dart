import 'dart:typed_data';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

import '../../models/products.dart';

Future<Uint8List> makePdf(List<ProductModel> products) async {
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
                      flex: 2,
                    ),
                    Expanded(
                      child: PaddedText("price 1"),
                      flex: 1,
                    ),
                    Expanded(
                      child: PaddedText("price 2"),
                      flex: 1,
                    ),
                    Expanded(
                      child: PaddedText("price 3"),
                      flex: 1,
                    ),
                  ]),
                  Table(
                    border: TableBorder.all(color: PdfColors.black),
                    children: [
                      ...products.map(
                        (e) => TableRow(
                          children: [
                            Expanded(
                              child: PaddedText(e.name!),
                              flex: 2,
                            ),
                            Expanded(
                              child: PaddedText("\$${e.priceOne}"),
                              flex: 1,
                            ),
                            Expanded(
                              child: PaddedText("\$${e.priceTwo}"),
                              flex: 1,
                            ),
                            Expanded(
                              child: PaddedText("\$${e.priceThree}"),
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
