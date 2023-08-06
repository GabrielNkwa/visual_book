import 'package:flutter/material.dart';

import 'gift_setup.dart';

class GiftMessagePhotos extends StatefulWidget {
  const GiftMessagePhotos({super.key});

  @override
  State<GiftMessagePhotos> createState() => _GiftMessagePhotosState();
}

class _GiftMessagePhotosState extends State<GiftMessagePhotos> {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text('The Visual Book'),
          centerTitle: true,
        ),
        body: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Padding(
                  padding: EdgeInsets.all(15), //apply padding to all four sides
                  child: Text(
                    "Send a personal message with the gift",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19),
                  )),
              const Padding(
                padding: EdgeInsets.all(15), //apply padding to all four sides
                child: Text(
                  "The message will be delivered to the recipient when the Visual Book is connected at its final destination",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              const TextField(
                // controller: textarea,
                keyboardType: TextInputType.multiline,
                maxLines: 4,
                decoration: InputDecoration(
                    hintText: "Please type in your message here...",
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(width: 1, color: Colors.redAccent))),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Prepare()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.brown, // Background color
                ),
                child: const Text(
                  'Save',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ],
          ),
        ),
      );
}
