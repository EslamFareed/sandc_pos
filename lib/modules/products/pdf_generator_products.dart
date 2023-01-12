import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:sandc_pos/online_models/product_response_model.dart';

import '../../online_models/company_info_response_model.dart';

Future<Uint8List> makePdf(List<ProductResponseModel> products,
    CompanyInfoResponseModel company) async {
  final pdf = Document();
  var font = Font.ttf(await rootBundle.load("assets/fonts/Hacen-Tunisia.ttf"));
  Uint8List _bytesImage = const Base64Decoder()
      .convert(company.logo!.split("data:image/png;base64,").last);
  pdf.addPage(MultiPage(
      textDirection: TextDirection.rtl,
      theme: ThemeData.withFont(
        base: font,
      ),
      build: (context) {
        return [
          Text(company.companyName!),
          Image(MemoryImage(_bytesImage), width: 100, height: 100),
          Text(company.empName!),
          Text(DateTime.now().toString()),
          Container(height: 50),
          Table(
            border: TableBorder.all(color: PdfColors.black),
            children: [
              TableRow(
                  decoration: BoxDecoration(color: PdfColor.fromHex("#999999")),
                  children: [
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
          )
          // Header(
          //     decoration: BoxDecoration(
          //       border: Border.all(width: 1),
          //     ),
          //     child: )
        ];
      }));
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
