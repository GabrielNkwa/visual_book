import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:get/get.dart';

import '../controllers/bluetooth_cntroller.dart';

class BookSetup extends StatelessWidget {
  const BookSetup({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text('The Visual Book'),
          centerTitle: true,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'Exciting Moment',
                style: TextStyle(fontSize: 24.0),
              ),
              const Text('Its time to unlock your Visual Book'),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Book_Setup()),
                  );
                },
                child: Text('ITS READY'),
              ),
            ],
          ),
        ),
      );
}

class Book_Setup extends StatefulWidget {
  const Book_Setup({super.key});

  @override
  State<Book_Setup> createState() => _Book_SetupState();
}

class _Book_SetupState extends State<Book_Setup> {
  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        title: Text('The Visual Book'),
        centerTitle: true,
      ),
      body: GetBuilder<BluetoothController>(
        init: BluetoothController(),
        builder: (controller) {
          return SingleChildScrollView(
              child: Column(
            children: [
              Container(
                height: 180,
                width: double.infinity,
                color: Colors.blue,
                child: const Center(
                    child: Text(
                  "Bluetooth Devices",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold),
                )),
              ),
              const SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: () => controller.scanDevices(),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.blue,
                    minimumSize: const Size(350, 55),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                    ),
                  ),
                  child: Text(
                    "Scan",
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              StreamBuilder<List<ScanResult>>(
                  stream: controller.scanResults,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                          shrinkWrap: true,
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            final data = snapshot.data![index];
                            return Card(
                                elevation: 2,
                                child: ListTile(
                                  title: Text(data.device.name),
                                  subtitle: Text(data.device.id.id),
                                  trailing: Text(data.rssi.toString()),
                                ));
                          });
                    } else {
                      return const Center(
                        child: Text("No Devices Found"),
                      );
                    }
                  })
            ],
          ));
        },
      ));
}
