import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:sandc_pos/cubits/data_cubit/data_cubit.dart';
import 'package:sandc_pos/modules/products/product_details.dart';

class ScanCodeProductDetailsScreen extends StatefulWidget {
  const ScanCodeProductDetailsScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ScanCodeProductDetailsScreenState();
}

class _ScanCodeProductDetailsScreenState
    extends State<ScanCodeProductDetailsScreen> {
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Scan Code"),
      ),
      body: Column(
        children: <Widget>[
          Expanded(child: _buildQrView(context)),
        ],
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 250.0
        : 400.0;
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      cameraFacing: CameraFacing.back,
      overlay: QrScannerOverlayShape(
          borderColor: Colors.red,
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: scanArea),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      Get.back(closeOverlays: true);

      Get.to(
          ProductDetails(
            item: DataCubit.get(context)
                .productModels
                .where((element) => element.prodId == scanData.code)
                .first,
          ),
          transition: Transition.zoom);

      controller.stopCamera();
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    ctrl.resumeCamera();
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
