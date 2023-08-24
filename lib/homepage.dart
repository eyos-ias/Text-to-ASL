import 'dart:io';

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _textEditingController = TextEditingController();
  final FocusNode _textFocusNode = FocusNode();
  bool _displayImage = false;
  String _imageName = '';

  void _toggleDisplayImage() {
    setState(() {
      _displayImage = !_displayImage;
    });
  }

  void _clearText() {
    setState(() {
      _textEditingController.clear();
      _displayImage = false; // Hide the image when clearing text
    });
  }

  void _dismissKeyboard() {
    _textFocusNode.unfocus();
  }

  Future<void> _checkImageExists(String imageName) async {
    final directory = Directory('../images');
    final files = await directory.list().toList();

    bool exists = false;
    for (var file in files) {
      final fileName = file.path.split('/').last;
      final nameWithoutExtension = fileName.split('.').first;
      if (nameWithoutExtension == imageName) {
        exists = true;
        break;
      }
    }

    setState(() {
      _displayImage = exists;
    });
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    _textFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My App'),
      ),
      body: GestureDetector(
        onTap:
            _dismissKeyboard, // Dismiss keyboard when tapping outside of TextField
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(20.0), // Add 20px padding on all sides
            child: Column(
              children: [
                if (_displayImage)
                  Padding(
                    padding:
                        EdgeInsets.all(20.0), // Add 20px padding to the Image
                    child: Image.asset(
                      'images/$_imageName.jpg',
                      height: 200, // Set the height of the image
                    ),
                  ),
                SizedBox(height: 20),
                TextField(
                  controller: _textEditingController,
                  focusNode: _textFocusNode,
                  decoration: InputDecoration(
                    labelText: 'Enter Text',
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue, width: 2.0),
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(Icons.clear),
                      onPressed: () {
                        _clearText();
                        _dismissKeyboard(); // Dismiss keyboard when clear button is pressed
                      },
                    ),
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    final enteredText = _textEditingController.text.trim();
                    if (enteredText.isNotEmpty) {
                      _imageName = enteredText;
                      _checkImageExists(enteredText);
                      _dismissKeyboard(); // Dismiss keyboard when button is pressed
                    }
                  },
                  child: Text('Button'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
