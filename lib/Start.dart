import 'package:first/Text_ASL.dart';
import 'package:first/file_picker.dart';
import 'package:flutter/material.dart';

class Start extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Commusign'),
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
                  MaterialPageRoute(builder: (context) => FilePickerExample()),
                );
              },
              child: Text('Upload File'),
            ),
          ],
        ),
      ),
    );
  }
}
