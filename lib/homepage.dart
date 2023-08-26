import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _textEditingController = TextEditingController();
  List<String> words = [];

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  void _submitForm() {
    String input = _textEditingController.text.trim();
    if (input.isNotEmpty) {
      List<String> inputWords = input.split(' ');
      setState(() {
        words.addAll(inputWords);
      });
      _textEditingController.clear();
    }
  }

  String getGifPath(String word) {
    return 'images/$word.gif';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter App'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            children: [
              GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 10.0,
                ),
                itemCount: words.length,
                itemBuilder: (context, index) {
                  String word = words[index];
                  String gifPath = getGifPath(word);
                  return Image.asset(
                    gifPath,
                    width: 200.0,
                    height: 200.0,
                  );
                },
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: _textEditingController,
                decoration: InputDecoration(
                  labelText: 'Enter multiple words',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: _submitForm,
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}