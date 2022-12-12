import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import '../../../cubits/data_cubit/data_cubit.dart';
import '../../../reposetories/shared_pref/cache_keys.dart';
import '../../categories/pdf_generator_categories.dart';

// class CreatePdf {
Future<Uint8List> makePdf(DataCubit cubit) async {
  final pdf = pw.Document();

  pw.Font? arFont =
      pw.Font.ttf((await rootBundle.load("assets/fonts/Cairo-Bold.ttf")));

  Uint8List _bytesImage = const Base64Decoder().convert(
      cubit.companyModels[0].logo!.split("data:image/png;base64,").last);

  pdf.addPage(
    pw.Page(
      textDirection: pw.TextDirection.rtl,
      theme: pw.ThemeData.withFont(
        base: arFont,
      ),
      pageFormat: CacheKeysManger.getPrinterWidthPaperFromCache() == "80"
          ? PdfPageFormat.roll80
          : PdfPageFormat.roll57,
      build: (context) {
        return pw.Column(
          children: [
            pw.Column(
              children: [
                pw.Image(
                    pw.MemoryImage(
                      _bytesImage,
                    ),
                    width: 50,
                    height: 50),
                pw.Text(
                  cubit.companyModels[0].companyName!,
                ),
                pw.Text(
                  cubit.companyModels[0].compAddress!,
                ),
                pw.Text(
                  cubit.companyModels[0].compPhone!,
                ),
                pw.Divider(),
                pw.Text(
                  "reciet",
                ),
                pw.Divider(),
                pw.Header(
                  // decoration: pw.BoxDecoration(
                  //   border: pw.Border.all(width: 1),
                  // ),
                  child: pw.Column(
                    children: [
                      pw.Row(children: [
                        pw.Expanded(
                          child: pw.Text("qty"),
                          flex: 1,
                        ),
                        pw.Expanded(
                          child:
                              pw.Text("item", textAlign: pw.TextAlign.center),
                          flex: 5,
                        ),
                        pw.Expanded(
                          child: pw.Text("price"),
                          flex: 2,
                        ),
                        pw.Expanded(
                          child: pw.Text("total"),
                          flex: 2,
                        ),
                      ]),
                      pw.Table(
                        // border: pw.TableBorder.all(color: PdfColors.black),
                        children: [
                          ...cubit.itemsCurrentOrder.map(
                            (e) => pw.TableRow(
                              children: [
                                pw.Expanded(
                                  child: pw.Text(e.quantity!.toString(),
                                      textAlign: pw.TextAlign.center),
                                  flex: 1,
                                ),
                                pw.Expanded(
                                  child: pw.Text(
                                      cubit.productModels
                                          .firstWhere((element) =>
                                              element.prodId == e.prodId)
                                          .name!,
                                      textAlign: pw.TextAlign.center),
                                  flex: 5,
                                ),
                                pw.Expanded(
                                  child: pw.Text(e.unitPrice!.toString(),
                                      textAlign: pw.TextAlign.center),
                                  flex: 2,
                                ),
                                pw.Expanded(
                                  child: pw.Text(e.totalCost!.toString(),
                                      textAlign: pw.TextAlign.center),
                                  flex: 2,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      pw.Divider(),
                      pw.Text(
                        "Total : ${cubit.currentOrder!.totalCost}",
                      ),
                      pw.Divider(),
                      pw.Text(
                        "pay : ${cubit.currentOrder!.payAmount}",
                      ),
                      pw.Divider(),
                      pw.Text(
                        "debit : ${cubit.currentOrder!.debitPay}",
                      ),
                      pw.Divider(),
                      pw.Text(
                        "discount : ${cubit.currentOrder!.discount}",
                      ),
                      pw.Divider(),
                      pw.Text(
                        "taxes : ${cubit.currentOrder!.taxes}",
                      ),
                      pw.Divider(),
                      pw.Text(
                        "net cost : ${cubit.currentOrder!.costNet}",
                      ),
                      pw.Divider(),
                      pw.Text(
                        "Thank You",
                      ),
                      pw.Divider(),
                      pw.BarcodeWidget(
                          height: 50,
                          width: 50,
                          data: cubit.currentOrder!.id!,
                          barcode: pw.Barcode.qrCode()),
                    ],
                  ),
                ),
              ],
            ),
          ],
        );
      },
    ),
  );
  return pdf.save();
}
