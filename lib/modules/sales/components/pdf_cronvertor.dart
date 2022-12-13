import 'dart:io';
import 'dart:typed_data';

import 'package:native_pdf_renderer/native_pdf_renderer.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sandc_pos/cubits/data_cubit/data_cubit.dart';

import '../../../reposetories/shared_pref/cache_keys.dart';

class PdfConverter {
  Future<Uint8List> convertToImage(String pdfPath, DataCubit cubit) async {
    PdfDocument doc = await PdfDocument.openFile(pdfPath);
    PdfPage page = await doc.getPage(1);

    final PdfPageImage? pageImg = await page.render(
        width: 575, height: page.height + 500, backgroundColor: "#ffffff");

    if (pageImg != null) {
      // String path = (await getApplicationDocumentsDirectory()).path;
      // File file = File("$path${cubit.currentOrder!.id}.png");

      // await file.writeAsBytes(pageImg.bytes);
      // OpenFile.open(file.path);
      return pageImg.bytes;
    }
    return pageImg!.bytes;
  }
}
