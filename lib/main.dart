import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Python Integration',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _textEditingController = TextEditingController();
  List<String> gifPaths = [];

  Future<void> sendInputToBackend(List<String> inputWords) async {
    final apiUrl = 'http://127.0.0.1:5000/process_input';
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'words': inputWords}),
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      setState(() {
        gifPaths = List<String>.from(responseData['gif_paths']);
      });
    } else {
      throw Exception('Failed to communicate with the backend API.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Python Integration'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.all(16.0),
              child: TextField(
                controller: _textEditingController,
                decoration: InputDecoration(
                  labelText: 'Enter text',
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                // Send the entered text to the backend API
                String enteredText = _textEditingController.text;
                sendInputToBackend([enteredText]);
              },
              child: Text('Submit'),
            ),
            SizedBox(height: 16.0),
            Text('GIF Paths:'),
            Column(
              children: gifPaths.map((path) => Text(path)).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
