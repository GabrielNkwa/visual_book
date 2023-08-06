import 'package:flutter/material.dart';

import '../reusable_widgets/reusable_widget.dart';

class InviteFamily extends StatefulWidget {
  const InviteFamily({super.key});

  @override
  State<InviteFamily> createState() => _InviteFamilyState();
}

class _InviteFamilyState extends State<InviteFamily> {
  TextEditingController _contactTextController = TextEditingController();
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
              const Padding(
                padding: EdgeInsets.all(15), //apply padding to all four sides
              ),
              const Padding(
                padding: EdgeInsets.all(15), //apply padding to all four sides
                child: Text(
                  "Send an invite to someone to join in experencing the good time",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19),
                ),
              ),
              reusableTextField("Recipient Contact", Icons.person_2_outlined,
                  false, _contactTextController),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(builder: (context) => Code()),
                  // );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.brown, // Background color
                ),
                child: const Text(
                  'SMS INVITE',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ],
          ),
        ),
      );
}

class PhotosAlbumbs extends StatefulWidget {
  const PhotosAlbumbs({super.key});

  @override
  State<PhotosAlbumbs> createState() => _PhotosAlbumbsState();
}

class _PhotosAlbumbsState extends State<PhotosAlbumbs> {
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
              const Padding(
                padding: EdgeInsets.all(15), //apply padding to all four sides
              ),
              const Padding(
                padding: EdgeInsets.all(15), //apply padding to all four sides
                child: Text(
                  "Choose an image to attach as part of the gift",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //       builder: (context) => ImagePickerScreen()),
                  // );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.brown, // Background color
                ),
                child: const Text(
                  'CHOOSE',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ],
          ),
        ),
      );
}
