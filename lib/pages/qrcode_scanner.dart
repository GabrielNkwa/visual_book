import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

// Define an async function to use await
Future<void> scanBarcode() async {
  try {
    String cameraScanResult = await FlutterBarcodeScanner.scanBarcode(
      '#ff6666', // Color for the scan UI
      'Cancel', // Button text to cancel the scan
      true, // Whether to show flash option
      ScanMode.BARCODE, // Specify the type of scan (BARCODE, QR_CODE, etc.)
    );

    // Now you can use the scanned result
    print('Scanned result: $cameraScanResult');
  } catch (e) {
    // Handle any errors or exceptions here
    print('Error while scanning: $e');
  }
}
