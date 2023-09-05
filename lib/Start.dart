import 'package:first/Text_ASL.dart';
import 'package:first/FilePicker.dart';
import 'package:first/profile.dart';
import 'package:first/voice_input.dart';
import 'package:flutter/material.dart';

class Start extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: PreferredSize(
        preferredSize:
            Size.fromHeight(60.0), // Set a fixed height for the app bar
        child: AppBar(
          backgroundColor: Colors.black,
          leading: Container(
            width: 40.0,
            child: IconButton(
              icon: Image.asset(
                'images/Vectorback.png',
                width: 10,
              ),
              onPressed: () {
                Navigator.pop(context); // Navigates to the previous page
              },
            ),
          ),
          title: Container(
            width: 200.0,
            child: Row(
              children: [
                Image.asset(
                  'images/Icon1.png',
                  width: 30,
                  height: 30,
                ),
                SizedBox(width: 8),
                Text(
                  'Commusign',
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Communicate with everyone',
              style: TextStyle(fontSize: 25),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Text_ASL()),
                );
              },
              child: Text('Input Text'),
            ),
            SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FilePickerPage()),
                );
              },
              child: Text('Upload File'),
            ),
            SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => VoiceInput()),
                );
              },
              child: Text('Input voice'),
            ),
             SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => profilePage()),
                );
              },
              child: Text('Profile'),
            ),
          ],
        ),
      ),
    );
  }
}
