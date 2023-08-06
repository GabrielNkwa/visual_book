// ignore_for_file: deprecated_member_use

import 'package:get/get.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

class BluetoothController extends GetxController {
  // FlutterBluePlus flutterBlue = FlutterBluePlus.instance;

  Future scanDevices() async {
    FlutterBluePlus.startScan(timeout: const Duration(seconds: 5));

    FlutterBluePlus.stopScan();
  }

  Stream<List<ScanResult>> get scanResults => FlutterBluePlus.scanResults;
}
