import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:printing/printing.dart';
import 'package:sandc_pos/online_models/order_response_model.dart';

import '../../../online_models/company_info_response_model.dart';

Future<Uint8List> makePdf(List<OrderResponseModel> orders, double total,
    CompanyInfoResponseModel company) async {
  final pdf = Document();
  var font = Font.ttf(await rootBundle.load("assets/fonts/Hacen-Tunisia.ttf"));
  Uint8List _bytesImage = const Base64Decoder()
      .convert(company.logo!.split("data:image/png;base64,").last);
  pdf.addPage(
    MultiPage(
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
                    Expanded(child: PaddedText("id")),
                    Expanded(child: PaddedText("date")),
                    Expanded(child: PaddedText("total cost")),
                    Expanded(child: PaddedText("pay amount")),
                  ]),
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
        ];
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
