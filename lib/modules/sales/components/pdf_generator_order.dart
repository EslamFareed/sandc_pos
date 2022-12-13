import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import '../../../cubits/data_cubit/data_cubit.dart';
import '../../../reposetories/shared_pref/cache_keys.dart';
import '../../categories/pdf_generator_categories.dart';
import 'pdf_cronvertor.dart';

class PdfGenerator {
  Future<Uint8List> createPdf(DataCubit cubit) async {
    pw.Font? arFont =
        pw.Font.ttf((await rootBundle.load("assets/fonts/Cairo-Bold.ttf")));

    Uint8List bytesImage = const Base64Decoder().convert(
        cubit.companyModels[0].logo!.split("data:image/png;base64,").last);

    // String credentials =
    //     "${cubit.companyModels[0].companyName} ${cubit.companyModels[0].compTaxNumber} ${cubit.currentOrder!.createDate} ${cubit.currentOrder!.costNet} ${cubit.currentOrder!.taxes}";
    // Codec<String, String> stringToBase64 = utf8.fuse(base64);
    // String qrCode = stringToBase64.encode(credentials);

    BytesBuilder bytesBuilder = BytesBuilder();

    //company name
    bytesBuilder.addByte(1);
    List<int> sellerNameBytes =
        utf8.encode(cubit.companyModels[0].companyName!);
    bytesBuilder.addByte(sellerNameBytes.length);
    bytesBuilder.add(sellerNameBytes);

    //tax number
    bytesBuilder.addByte(2);
    List<int> taxNumberBytes =
        utf8.encode(cubit.companyModels[0].compTaxNumber!);
    bytesBuilder.addByte(taxNumberBytes.length);
    bytesBuilder.add(taxNumberBytes);

    //order Date
    bytesBuilder.addByte(3);
    List<int> orderDateBytes = utf8.encode(cubit.currentOrder!.createDate!);
    bytesBuilder.addByte(orderDateBytes.length);
    bytesBuilder.add(orderDateBytes);

    //order cost
    bytesBuilder.addByte(4);
    List<int> orderCostBytes =
        utf8.encode(cubit.currentOrder!.costNet!.toString());
    bytesBuilder.addByte(orderCostBytes.length);
    bytesBuilder.add(orderCostBytes);

    //order taxes
    bytesBuilder.addByte(5);
    List<int> orderTaxesBytes =
        utf8.encode(cubit.currentOrder!.taxes!.toString());
    bytesBuilder.addByte(orderTaxesBytes.length);
    bytesBuilder.add(orderTaxesBytes);

    Uint8List qrCodeAsBytes = bytesBuilder.toBytes();
    final Base64Encoder b64Encoder = Base64Encoder();
    String? qrCode = b64Encoder.convert(qrCodeAsBytes);

    String path = (await getApplicationDocumentsDirectory()).path;
    File file = File("$path/${cubit.currentOrder!.id}.pdf");

    pw.Document pdf = pw.Document();
    pdf.addPage(_createPage(cubit, arFont, bytesImage, qrCode));

    Uint8List bytes = await pdf.save();
    await file.writeAsBytes(bytes);
    Uint8List imageFile = await createImg(file.path, cubit);
    return imageFile;
  }

  Future<Uint8List> createImg(String path, DataCubit cubit) {
    return PdfConverter().convertToImage(path, cubit);
  }

  static pw.Page _createPage(
      DataCubit cubit, pw.Font? arFont, Uint8List _bytesImage, String qrCode) {
    return pw.Page(
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
                pw.Text(cubit.currentOrder!.clientID == null
                    ? "فاتورة ضريبية مبسطة"
                    : "فاتورة ضريبية"),
                pw.Image(
                    pw.MemoryImage(
                      _bytesImage,
                    ),
                    width: 50,
                    height: 50),
                pw.Text(
                  cubit.companyModels[0].companyName!,
                  style: const pw.TextStyle(fontSize: 8),
                ),
                pw.Text(
                  cubit.companyModels[0].compAddress!,
                  style: const pw.TextStyle(fontSize: 8),
                ),
                pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.center,
                    children: [
                      pw.Text(
                        cubit.companyModels[0].compPhone!,
                        style: const pw.TextStyle(fontSize: 8),
                      ),
                      pw.Text(
                        "الهاتف :",
                        style: const pw.TextStyle(fontSize: 8),
                      ),
                    ]),
                pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.center,
                    children: [
                      pw.Text(
                        cubit.companyModels[0].compTaxNumber!,
                        style: const pw.TextStyle(fontSize: 8),
                      ),
                      pw.Text(
                        "الرقم الضريبي  :",
                        style: const pw.TextStyle(fontSize: 8),
                      ),
                    ]),
                pw.Divider(),
                pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.center,
                    children: [
                      pw.Text(
                        cubit.currentOrder!.id!,
                        style: const pw.TextStyle(fontSize: 8),
                      ),
                      pw.Text(
                        "رقم الفاتورة :",
                        style: const pw.TextStyle(fontSize: 8),
                      ),
                    ]),
                pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.center,
                    children: [
                      pw.Text(
                        DateFormat("yyyy-MM-dd hh:mm aaa").format(
                            DateTime.parse(cubit.currentOrder!.createDate!)),
                        style: const pw.TextStyle(fontSize: 8),
                      ),
                      pw.Text(
                        "تاريخ الفاتورة :",
                        style: const pw.TextStyle(fontSize: 8),
                      ),
                    ]),
                pw.Divider(),
                pw.Header(
                  child: pw.Column(
                    children: [
                      pw.Row(children: [
                        pw.Expanded(
                          child: pw.FittedBox(
                            child: pw.Text(
                              "الكمية",
                              textAlign: pw.TextAlign.center,
                              style: const pw.TextStyle(fontSize: 6),
                            ),
                          ),
                          flex: 1,
                        ),
                        pw.Expanded(
                          child: pw.Text(
                            "الصنف",
                            textAlign: pw.TextAlign.center,
                            style: const pw.TextStyle(fontSize: 6),
                          ),
                          flex: 5,
                        ),
                        pw.Expanded(
                          child: pw.Text(
                            "السعر",
                            textAlign: pw.TextAlign.center,
                            style: const pw.TextStyle(fontSize: 6),
                          ),
                          flex: 2,
                        ),
                        pw.Expanded(
                          child: pw.FittedBox(
                            child: pw.Text(
                              "المجموع شامل  الضريبة",
                              textAlign: pw.TextAlign.center,
                              style: const pw.TextStyle(fontSize: 6),
                            ),
                          ),
                          flex: 2,
                        ),
                      ]),
                      pw.Divider(),
                      pw.Table(
                        children: [
                          ...cubit.itemsCurrentOrder.map(
                            (e) => pw.TableRow(
                              children: [
                                pw.Expanded(
                                  child: pw.Text(
                                    e.quantity!.toString(),
                                    textAlign: pw.TextAlign.center,
                                    style: const pw.TextStyle(fontSize: 8),
                                  ),
                                  flex: 1,
                                ),
                                pw.Expanded(
                                  child: pw.Text(
                                    cubit.productModels
                                        .firstWhere((element) =>
                                            element.prodId == e.prodId)
                                        .name!,
                                    textAlign: pw.TextAlign.center,
                                    style: const pw.TextStyle(fontSize: 8),
                                  ),
                                  flex: 5,
                                ),
                                pw.Expanded(
                                  child: pw.Text(
                                    cubit.companyModels[0].isPriceIncludeTaxes!
                                        ? (e.unitPrice! -
                                                (e.unitPrice! *
                                                    (double.parse(cubit
                                                            .companyModels[0]
                                                            .taxAmount!) *
                                                        .01)))
                                            .toString()
                                        : e.unitPrice!.toStringAsFixed(2),
                                    textAlign: pw.TextAlign.center,
                                    style: const pw.TextStyle(fontSize: 8),
                                  ),
                                  flex: 2,
                                ),
                                pw.Expanded(
                                  child: pw.Text(
                                    (e.totalCost! +
                                            (e.totalCost! *
                                                (double.parse(cubit
                                                        .companyModels[0]
                                                        .taxAmount!) *
                                                    .01)))
                                        .toStringAsFixed(2),
                                    textAlign: pw.TextAlign.center,
                                    style: const pw.TextStyle(fontSize: 8),
                                  ),
                                  flex: 2,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      pw.Divider(),
                      pw.Text("معلومات الدفع : "),
                      pw.Row(
                          mainAxisAlignment: pw.MainAxisAlignment.spaceAround,
                          children: [
                            pw.Text(cubit.currentOrder!.costNet.toString()),
                            pw.Text("كاش"),
                          ]),
                      pw.Table(
                          border: const pw.TableBorder(
                              top: pw.BorderSide(width: 1),
                              // bottom: pw.BorderSide(width: 1),
                              left: pw.BorderSide(width: 1),
                              right: pw.BorderSide(width: 1)),
                          children: [
                            pw.TableRow(children: [
                              pw.Row(
                                  mainAxisAlignment:
                                      pw.MainAxisAlignment.spaceBetween,
                                  children: [
                                    pw.Text(
                                      cubit.companyModels[0].compCurrencyName!,
                                      textAlign: pw.TextAlign.center,
                                      style: const pw.TextStyle(fontSize: 8),
                                    ),
                                    pw.Row(children: [
                                      pw.Text(
                                        cubit.currentOrder!.totalCost!
                                            .toStringAsFixed(2),
                                        textAlign: pw.TextAlign.center,
                                        style: const pw.TextStyle(fontSize: 8),
                                      ),
                                      pw.Text(
                                        "الاجمالي الخاضع للضريبة : ",
                                        textAlign: pw.TextAlign.center,
                                        style: const pw.TextStyle(fontSize: 8),
                                      ),
                                    ]),
                                  ]),
                            ])
                          ]),
                      pw.Table(
                          border: const pw.TableBorder(
                            // top: pw.BorderSide(width: 1),
                            // bottom: pw.BorderSide(width: 1),
                            left: pw.BorderSide(width: 1),
                            right: pw.BorderSide(width: 1),
                          ),
                          children: [
                            pw.TableRow(children: [
                              pw.Row(
                                  mainAxisAlignment:
                                      pw.MainAxisAlignment.spaceBetween,
                                  children: [
                                    pw.Text(
                                      cubit.companyModels[0].compCurrencyName!,
                                      textAlign: pw.TextAlign.center,
                                      style: const pw.TextStyle(fontSize: 8),
                                    ),
                                    pw.Row(children: [
                                      pw.Text(
                                        cubit.currentOrder!.discount!
                                            .toStringAsFixed(2),
                                        textAlign: pw.TextAlign.center,
                                        style: const pw.TextStyle(fontSize: 8),
                                      ),
                                      pw.Text(
                                        "الخصم : ",
                                        textAlign: pw.TextAlign.center,
                                        style: const pw.TextStyle(fontSize: 8),
                                      ),
                                    ]),
                                  ]),
                            ])
                          ]),
                      pw.Table(
                          border: const pw.TableBorder(
                              // top: pw.BorderSide(width: 1),
                              // bottom: pw.BorderSide(width: 1),
                              left: pw.BorderSide(width: 1),
                              right: pw.BorderSide(width: 1)),
                          children: [
                            pw.TableRow(children: [
                              pw.Row(
                                  mainAxisAlignment:
                                      pw.MainAxisAlignment.spaceBetween,
                                  children: [
                                    pw.Text(
                                      cubit.companyModels[0].compCurrencyName!,
                                      textAlign: pw.TextAlign.center,
                                      style: const pw.TextStyle(fontSize: 8),
                                    ),
                                    pw.Text(
                                      "${cubit.companyModels[0].taxAmount!}%",
                                      textAlign: pw.TextAlign.center,
                                      style: const pw.TextStyle(fontSize: 8),
                                    ),
                                    pw.Row(children: [
                                      pw.Text(
                                        cubit.currentOrder!.taxes!
                                            .toStringAsFixed(2),
                                        textAlign: pw.TextAlign.center,
                                        style: const pw.TextStyle(fontSize: 8),
                                      ),
                                      pw.Text(
                                        "ضريبة القيمة المضافة : ",
                                        textAlign: pw.TextAlign.center,
                                        style: const pw.TextStyle(fontSize: 8),
                                      ),
                                    ]),
                                  ]),
                            ])
                          ]),
                      pw.Table(
                          border: const pw.TableBorder(
                            // top: pw.BorderSide(width: 1),
                            bottom: pw.BorderSide(width: 1),
                            left: pw.BorderSide(width: 1),
                            right: pw.BorderSide(width: 1),
                          ),
                          // ),
                          children: [
                            pw.TableRow(children: [
                              pw.Row(
                                  mainAxisAlignment:
                                      pw.MainAxisAlignment.spaceBetween,
                                  children: [
                                    pw.Text(
                                      cubit.companyModels[0].compCurrencyName!,
                                      textAlign: pw.TextAlign.center,
                                      style: const pw.TextStyle(fontSize: 8),
                                    ),
                                    pw.Row(children: [
                                      pw.Text(
                                        cubit.currentOrder!.costNet.toString(),
                                        textAlign: pw.TextAlign.center,
                                        style: const pw.TextStyle(fontSize: 8),
                                      ),
                                      pw.Text(
                                        "اجمالي المبلغ المستحق: ",
                                        textAlign: pw.TextAlign.center,
                                        style: const pw.TextStyle(fontSize: 8),
                                      ),
                                    ]),
                                  ]),
                            ])
                          ]),
                      pw.SizedBox(height: 10),
                      pw.BarcodeWidget(
                        height: 100,
                        width: 100,
                        data: qrCode,
                        barcode: pw.Barcode.qrCode(),
                      ),
                      // pw.Text("شكرا لزيارتكم..... نتطلع لرؤيتكم مرة اخرى",
                      //     style: const pw.TextStyle(fontSize: 5)),
                      pw.Text(cubit.companyModels[0].companyDescription!,
                          style: const pw.TextStyle(fontSize: 5)),
                    ],
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
