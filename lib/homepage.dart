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
  TextEditingController _textEditingController = TextEditingController();
  bool _displayBoxVisible = false;

  void _toggleDisplayBox() {
    setState(() {
      _displayBoxVisible = !_displayBoxVisible;
    });
  }

  void _clearText() {
    setState(() {
      _textEditingController.clear();
      _displayBoxVisible = false; // Hide the display box when clearing text
    });
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My App'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20.0), // Add 20px padding on all sides
          child: Column(
            children: [
              Padding(
                padding:
                    EdgeInsets.all(20.0), // Add 20px padding to the Display Box
                child: Visibility(
                  visible: _displayBoxVisible,
                  child: Container(
                    height: 500, // Set the height to 500 pixels
                    color: Colors.blue.withOpacity(0.5),
                    child: Center(
                      child: Text(
                        'Display Box',
                        style: TextStyle(fontSize: 30, color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: _textEditingController,
                decoration: InputDecoration(
                  labelText: 'Enter Text',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue, width: 2.0),
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(Icons.clear),
                    onPressed: _clearText,
                  ),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_textEditingController.text.isNotEmpty) {
                    _toggleDisplayBox();
                  }
                },
                child: Text('Button'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
