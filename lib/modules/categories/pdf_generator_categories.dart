import 'dart:typed_data';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:sandc_pos/online_models/category_response_model.dart';

Future<Uint8List> makePdf(List<CategoryResponseModel> categories) async {
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
                      child: PaddedText("desc"),
                      flex: 1,
                    ),
                  ]),
                  Table(
                    border: TableBorder.all(color: PdfColors.black),
                    children: [
                      ...categories.map(
                        (e) => TableRow(
                          children: [
                            Expanded(
                              child: PaddedText(e.name!),
                              flex: 2,
                            ),
                            Expanded(
                              child: PaddedText("\$${e.description}"),
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
