import 'package:flutter/material.dart';
import 'dart:io';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/services.dart';
import 'package:flutter_scan_bluetooth/flutter_scan_bluetooth.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sandc_pos/cubits/main_cubit/main_cubit.dart';
import 'package:sandc_pos/reposetories/shared_pref/cache_helper.dart';
import 'package:sandc_pos/reposetories/shared_pref/cache_keys.dart';

import '../../core/utils/printer_manager.dart';

class SettingsPrinter extends StatefulWidget {
  const SettingsPrinter({Key? key}) : super(key: key);

  @override
  State<SettingsPrinter> createState() => _SettingsPrinterState();
}

class _SettingsPrinterState extends State<SettingsPrinter> {
  late FlutterScanBluetooth _scanBluetooth;
  late List<BluetoothDevice> _devices;
  BluetoothDevice? _selectedDevice;

  // late File imgFile;
  bool isScanning = true;

  List<String> widthPapers = ["57", "80"];
  String? _selectedWidth = "";

  @override
  void initState() {
    super.initState();
    _devices = [];
    _scanBluetooth = FlutterScanBluetooth();
    _selectedWidth = CacheKeysManger.getPrinterWidthPaperFromCache();
    _startScan();
    // _initImg();
  }

  _startScan() async {
    setState(() {
      isScanning = true;
    });
    await _scanBluetooth.startScan();

    _scanBluetooth.devices.listen((dev) {
      if (!_isDeviceAdded(dev)) {
        setState(() {
          _devices.add(dev);
        });
      }
      if (dev == MainCubit.get(context).selectedDevice) {
        setState(() {
          _selectedDevice = dev;
        });
        PrinterManager.connect(_selectedDevice!.address);
        MainCubit.get(context).isConnectedToPrinter = true;
        MainCubit.get(context).selectedDevice = _selectedDevice;
        CacheHelper.saveData(key: "printer", value: _selectedDevice!.address);

        _stopScan();
      } else if (CacheKeysManger.getPrinterFromCache() == dev.address) {
        setState(() {
          _selectedDevice = dev;
        });
        PrinterManager.connect(_selectedDevice!.address);
        MainCubit.get(context).isConnectedToPrinter = true;
        MainCubit.get(context).selectedDevice = _selectedDevice;
      }
    });

    await Future.delayed(const Duration(seconds: 10));
    _stopScan();
  }

  _stopScan() {
    _scanBluetooth.stopScan();
    setState(() {
      isScanning = false;
    });
  }

  bool _isDeviceAdded(BluetoothDevice device) => _devices.contains(device);

  // _initImg() async {
  //   try {
  //     ByteData byteData = await rootBundle.load("images/flutter.png");
  //     Uint8List buffer = byteData.buffer.asUint8List();
  //     String path = (await getTemporaryDirectory()).path;
  //     imgFile = File("$path/img.png");
  //     imgFile.writeAsBytes(buffer);
  //   } catch (e) {
  //     rethrow;
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: ConditionalBuilder(
          condition: !isScanning,
          builder: (context) => FloatingActionButton(
                onPressed: () {
                  _startScan();
                },
                child: const Icon(
                  Icons.search,
                ),
              ),
          fallback: (context) => Container()),
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          _selectedDevice != null
              ? "${_selectedDevice!.name} selected"
              : "No printer Selected",
        ),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 15,
          ),
          ConditionalBuilder(
              condition: isScanning,
              builder: (context) => CircularProgressIndicator(),
              fallback: (context) => Container()),
          const SizedBox(
            height: 15,
          ),
          ConditionalBuilder(
              condition: _selectedDevice != null,
              builder: (context) => Column(
                    children: [
                      _buildDev(_selectedDevice!),
                      const SizedBox(height: 15),
                      MaterialButton(
                        onPressed: () {
                          PrinterManager.connect(_selectedDevice!.address);
                          MainCubit.get(context).isConnectedToPrinter = true;
                          MainCubit.get(context).selectedDevice =
                              _selectedDevice;
                          CacheHelper.saveData(
                              key: "printer", value: _selectedDevice!.address);
                        },
                        color: Colors.lightBlue,
                        child: const Text(
                          "Connect",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      DropdownButton<String>(
                        value: _selectedWidth,
                        items: widthPapers
                            .map((e) => DropdownMenuItem<String>(
                                  value: e,
                                  child: Text(e),
                                ))
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            _selectedWidth = value;
                          });
                          CacheHelper.saveData(
                              key: "printerWidthPaper", value: _selectedWidth);
                        },
                      )
                    ],
                  ),
              fallback: (context) => Container()),
          const SizedBox(
            height: 15,
          ),
          Container(
            height: 1,
            width: double.infinity,
            color: Colors.lightBlue,
          ),
          const SizedBox(
            height: 15,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ..._devices.map(
                    (dev) => _buildDev(dev),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDev(BluetoothDevice dev) => GestureDetector(
        onTap: () {
          setState(() {
            _selectedDevice = dev;
          });
        },
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(10),
          margin: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.125),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            children: [
              Text(dev.name,
                  style: const TextStyle(
                      color: Colors.lightBlue,
                      fontSize: 16,
                      fontWeight: FontWeight.bold)),
              const SizedBox(
                height: 10,
              ),
              Text(dev.address,
                  style: const TextStyle(color: Colors.grey, fontSize: 14))
            ],
          ),
        ),
      );
}
