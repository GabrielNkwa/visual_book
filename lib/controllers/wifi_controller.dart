import 'dart:io';

import 'package:esp_smartconfig/esp_smartconfig.dart';

void main(List<String> arguments) async {
  final provisioner = Provisioner.espTouch();

  provisioner.listen((response) {
    print("Device $response has been connected to wifi network");
  });

  await provisioner.start(ProvisioningRequest.fromStrings(
    ssid: "",
    bssid: "",
    password: "",
  ));

  await Future.delayed(Duration(seconds: 15));

  provisioner.stop();
  exit(0);
}
