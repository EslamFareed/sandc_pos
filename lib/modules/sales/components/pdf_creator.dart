// import 'dart:io';
// import 'dart:typed_data';

// import 'package:flutter/services.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:open_file/open_file.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:pdf/pdf.dart';
// import 'package:pdf/widgets.dart';
// import 'package:qr_flutter/qr_flutter.dart';

// // import 'pdf_to_img_conveter.dart';

// class PdfGenerator {
//   static late Font arFont;

//   static init() async {
//     arFont = Font.ttf((await rootBundle.load("assets/fonts/Cairo-Bold.ttf")));
//   }

//   static createPdf() async {
//     String path = (await getApplicationDocumentsDirectory()).path;
//     File file = File(path + "MY_PDF.pdf");

//     Document pdf = Document();
//     pdf.addPage(_createPage());

//     Uint8List bytes = await pdf.save();
//     await file.writeAsBytes(bytes);
//     // createImg(file.path);
//     // await OpenFile.open(file.path);
//   }

//   static Page _createPage() {
//     return Page(
//         textDirection: TextDirection.rtl,
//         theme: ThemeData.withFont(
//           base: arFont,
//         ),
//         pageFormat: PdfPageFormat.roll80,
//         build: (context) {
//           return Container(
//                   width: 140,
//                   child: Column(
//                     children: [
//                       CircleAvatar(
//                         backgroundImage: MemoryImage(_bytesImage),
//                         radius: 50.r,
//                       ),
//                       Text(
//                         DataCubit.get(context).companyModels[0].companyName!,
//                         style: const TextStyle(
//                             fontSize: 10, fontWeight: FontWeight.bold),
//                       ),
//                       Text(
//                         DataCubit.get(context).companyModels[0].compAddress!,
//                         style: const TextStyle(
//                             fontSize: 10, fontWeight: FontWeight.bold),
//                       ),
//                       Text(
//                         DataCubit.get(context).companyModels[0].compPhone!,
//                         style: const TextStyle(
//                             fontSize: 10, fontWeight: FontWeight.bold),
//                       ),
//                       const Divider(),
//                       const Text(
//                         "reciet",
//                         style: TextStyle(
//                             fontSize: 10, fontWeight: FontWeight.bold),
//                       ),
//                       // const SizedBox(
//                       //   height: 20,
//                       //   child: Text(
//                       //       "--------------------------------------------------------------------"),
//                       // ),
//                       const Divider(),

//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: const [
//                           Expanded(
//                             flex: 2,
//                             child: Center(
//                               child: Text(
//                                 "Qty ",
//                                 style: TextStyle(
//                                     fontSize: 10, fontWeight: FontWeight.bold),
//                               ),
//                             ),
//                           ),
//                           Expanded(
//                             flex: 6,
//                             child: Center(
//                               child: Text(
//                                 "Item",
//                                 style: TextStyle(
//                                     fontSize: 10, fontWeight: FontWeight.bold),
//                               ),
//                             ),
//                           ),
//                           Expanded(
//                             flex: 3,
//                             child: Center(
//                               child: Text(
//                                 "Price",
//                                 style: TextStyle(
//                                     fontSize: 10, fontWeight: FontWeight.bold),
//                               ),
//                             ),
//                           ),
//                           Expanded(
//                             flex: 3,
//                             child: Center(
//                               child: Text(
//                                 "Total",
//                                 style: TextStyle(
//                                     fontSize: 10, fontWeight: FontWeight.bold),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                       ListView.builder(
//                         scrollDirection: Axis.vertical,
//                         shrinkWrap: true,
//                         physics: const ScrollPhysics(),
//                         itemCount:
//                             DataCubit.get(context).itemsCurrentOrder.length,
//                         itemBuilder: (context, index) {
//                           return Card(
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Expanded(
//                                   flex: 2,
//                                   child: Center(
//                                     child: Text(
//                                       DataCubit.get(context)
//                                           .itemsCurrentOrder[index]
//                                           .quantity!
//                                           .toString(),
//                                       style: const TextStyle(fontSize: 10),
//                                     ),
//                                   ),
//                                 ),
//                                 Expanded(
//                                   flex: 6,
//                                   child: Center(
//                                     child: Text(
//                                       DataCubit.get(context)
//                                           .productModels
//                                           .firstWhere((element) =>
//                                               element.prodId ==
//                                               DataCubit.get(context)
//                                                   .itemsCurrentOrder[index]
//                                                   .prodId)
//                                           .name!,
//                                       style: const TextStyle(fontSize: 10),
//                                     ),
//                                   ),
//                                 ),
//                                 Expanded(
//                                   flex: 3,
//                                   child: Center(
//                                     child: Text(
//                                       DataCubit.get(context)
//                                           .itemsCurrentOrder[index]
//                                           .unitPrice!
//                                           .toString(),
//                                       style: const TextStyle(fontSize: 10),
//                                     ),
//                                   ),
//                                 ),
//                                 Expanded(
//                                   flex: 3,
//                                   child: Center(
//                                     child: Text(
//                                       DataCubit.get(context)
//                                           .itemsCurrentOrder[index]
//                                           .totalCost!
//                                           .toString(),
//                                       style: const TextStyle(fontSize: 10),
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           );
//                         },
//                       ),
//                       const Divider(),
//                       Text(
//                         "Total : ${DataCubit.get(context).currentOrder!.totalCost}",
//                         style: const TextStyle(
//                             fontSize: 15, fontWeight: FontWeight.bold),
//                       ),
//                       const Divider(),
//                       Text(
//                         "pay : ${DataCubit.get(context).currentOrder!.payAmount}",
//                         style: const TextStyle(
//                             fontSize: 10, fontWeight: FontWeight.bold),
//                       ),
//                       const Divider(),
//                       Text(
//                         "debit : ${DataCubit.get(context).currentOrder!.debitPay}",
//                         style: const TextStyle(
//                             fontSize: 10, fontWeight: FontWeight.bold),
//                       ),
//                       const Divider(),
//                       Text(
//                         "discount : ${DataCubit.get(context).currentOrder!.discount}",
//                         style: const TextStyle(
//                             fontSize: 10, fontWeight: FontWeight.bold),
//                       ),
//                       const Divider(),
//                       Text(
//                         "taxes : ${DataCubit.get(context).currentOrder!.taxes}",
//                         style:  TextStyle(
//                             fontSize: 10, fontWeight: FontWeight.bold),
//                       ),
//                        Divider(),
//                       Text(
//                         "net cost : ${DataCubit.get(context).currentOrder!.costNet}",
//                         style:  TextStyle(
//                             fontSize: 15, fontWeight: FontWeight.bold),
//                       ),
//                        Divider(),
//                        Text(
//                         "Thank You",
//                         style: TextStyle(
//                             fontSize: 10, fontWeight: FontWeight.bold),
//                       ),
//                       Divider(height: 2.h),
//                       Center(
                        
//                           child: QrImageView(
//                             data: DataCubit.get(context).currentOrder!.id!,
//                             version: QrVersions.auto,
//                             gapless: true,
//                             size: 100,
//                             errorCorrectionLevel: QrErrorCorrectLevel.L,
//                           ),
                        
//                       )
//                       // QrImageView(
//                       //   data: DataCubit.get(context).currentOrder!.id!,
//                       //   version: QrVersions.auto,
//                       //   size: 100.0,
//                       // ),
//                     ],
//                   )),);
//         });
//   }

//   // static createImg(String path) {
//   //   PdfConverter.convertToImage(path);
//   // }
// }
