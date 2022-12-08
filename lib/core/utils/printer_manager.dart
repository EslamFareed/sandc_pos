import 'package:flutter/services.dart';

class PrinterManager {
  static final _platform = MethodChannel(PrinterStrings.channel);

  static connect(String mac) async {
    _platform.invokeMethod(
        PrinterStrings.connectCommand, {PrinterStrings.macArg: mac});
  }

  static printImg(String imgPath, String widthUsed) async {
    _platform.invokeMethod(PrinterStrings.printCommand, {
      PrinterStrings.imgPathArg: imgPath,
      PrinterStrings.widthUsedArg: widthUsed
    });
  }
}

class PrintersWidth {
  static int mm_3inch = 80;
  static int mm_2inch = 58;
}

class PrinterStrings {
  // channel name
  static String channel = "android.flutter/printer";
  //commands
  static String connectCommand = "printer_connect";
  static String printCommand = "printer_print";
  // arguments
  static String macArg = "printer_mac";
  static String imgPathArg = "img_path";
  static String widthUsedArg = "width_used";
}
