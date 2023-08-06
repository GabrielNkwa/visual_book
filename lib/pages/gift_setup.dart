// ignore_for_file: use_build_context_synchronously, prefer_const_constructors, prefer_interpolation_to_compose_strings, avoid_function_literals_in_foreach_calls

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:visual_book/pages/photo_gallery.dart';
import 'package:visual_book/pages/prepare_visual_book.dart';
import 'package:visual_book/pages/qrcode_scanner.dart';
import 'package:visual_book/read%20data/get_recipient_title.dart';
import 'dart:math';

import '../components/my_textfield.dart';
import '../firebase_options.dart';
import '../main.dart';
import 'home_page.dart';
import 'invite_family.dart';
import '../reusable_widgets/reusable_widget.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class GiftSetup extends StatelessWidget {
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
                'Let`s connect the Visual Book',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24.0),
              ),
              const Text(
                'Kindly choose how you wish to pair the Visual Book',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => VirtualCode()),
                  );
                },
                child: Text('GENERATE A VIRTUAL CODE'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => scanBarcode(),
                child: Text('SET UP USING QR CODE'),
              ),
            ],
          ),
        ),
      );
}

class VirtualCode extends StatefulWidget {
  const VirtualCode({super.key});

  @override
  State<VirtualCode> createState() => _VirtualCodeState();
}

class _VirtualCodeState extends State<VirtualCode> {
  final _titleController = TextEditingController();

  void _saveDataToFirestore() async {
    String title = _titleController.text;

    if (title.isNotEmpty) {
      try {
        // Save data to Firestore
        await FirebaseFirestore.instance.collection('recipient').add({
          'title': title,
          'createdOn': FieldValue.serverTimestamp(),
        });

        // Clear the input field after successful storage
        _titleController.clear();

        // Show a success message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Data stored successfully!')),
        );

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Code()),
        );
      } catch (e) {
        // Handle any errors that occur during storage
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error storing data: $e')),
        );
      }
    } else {
      // Show an error message if the input field is empty
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter some data first!')),
      );
    }
  }

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
              Padding(
                padding: EdgeInsets.all(15), //apply padding to all four sides
                child: Text(
                  "Who are you preparing the Visual Book for?",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(15), //apply padding to all four sides
                child: Text(
                  "Set the recipient's name or add title, they can rename the book later",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              MyTextField(
                  controller: _titleController,
                  hintText: "Enter Recipient's name or title",
                  obscureText: false),
              SizedBox(height: 20),
              GestureDetector(
                onTap: _saveDataToFirestore,
                child: Container(
                  padding: const EdgeInsets.all(25),
                  margin: const EdgeInsets.symmetric(horizontal: 25),
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(8)),
                  child: const Center(
                    child: Text(
                      'Next',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
}

class Code extends StatefulWidget {
  const Code({super.key});

  @override
  State<Code> createState() => _CodeState();
}

class _CodeState extends State<Code> {
  CollectionReference title =
      FirebaseFirestore.instance.collection('receipient');

  final recipientTitle = FirebaseFirestore.instance
      .collection('recipient')
      .orderBy('timestamp', descending: true)
      .limit(1)
      .get();

  List<String> docIDs = [];

  Future getRecipientID() async {
    await FirebaseFirestore.instance
        .collection('recipient')
        .orderBy('timestamp', descending: true)
        .limit(1)
        .get()
        .then(
          (snapshot) => snapshot.docs.forEach(
            (document) {
              print(document.reference);
              docIDs.add(document.reference.id);
            },
          ),
        );
  }

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
              Padding(
                padding: EdgeInsets.all(15), //apply padding to all four sides
                child: Text(
                  'We have emailed you the claim code for ',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19),
                ),
              ),
              Text(
                '${}',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19),
              ),
              SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.all(15), //apply padding to all four sides
                child: Text(
                  "Now, prepare a gift by adding a message, photo or video. Then share the code below with ......",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
              ),
              SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Prepare()),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.all(25),
                  margin: const EdgeInsets.symmetric(horizontal: 25),
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(8)),
                  child: Center(
                    child: Text(
                      'Next',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
}

class Prepare extends StatefulWidget {
  const Prepare({super.key});

  @override
  State<Prepare> createState() => _PrepareState();
}

class _PrepareState extends State<Prepare> {
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
              Padding(
                padding: EdgeInsets.all(15), //apply padding to all four sides
                child: Text(
                  "Prepare the Visual Book for its destination",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(15), //apply padding to all four sides
                child: Text(
                  "For the best surprise, complete all the options before the recipient connects to their book",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => GiftMessagePhotos()),
                  );
                },
                child: Text('GIFT MESSAGE PHOTOS'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => InviteFamily()),
                  );
                },
                child: Text('INVITE FAMILY AND FRIENDS'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ImagePickerScreen()),
                  );
                },
                child: Text('ADD PHOTOS AND ALBUMS'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //       builder: (context) => ImagePickerScreen()),
                  // );
                },
                child: Text('CHOOSE WIFI CONNECTION'),
              ),
              SizedBox(height: 20),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomeScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.brown, // Background color
                ),
                child: const Text(
                  'Done',
                  style: TextStyle(fontSize: 20),
                ),
              )
            ],
          ),
        ),
      );
}
