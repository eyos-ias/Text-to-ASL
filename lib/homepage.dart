import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _textEditingController = TextEditingController();
  bool _isDisplayVisible = false;
  String imageName = '';
  Map<String, String> imageMap = {
    'image': 'images/image.jpg',
    'all': 'images/all.gif',
    // Add mappings for the remaining images here
    // 'image3': 'images/image3.jpg',
    // 'image4': 'images/image4.jpg',
    // ...
    // 'image25': 'images/image25.jpg',
  };

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  void _submitForm() {
    FocusScope.of(context).unfocus(); // Hide the keyboard
    if (imageName.isNotEmpty) {
      setState(() {
        _isDisplayVisible = true;
      });
    }
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
              Visibility(
                visible: _isDisplayVisible,
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 200.0,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.blue),
                      ),
                      child: Image.asset(
                        imageMap[imageName] ?? '',
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(height: 16.0),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _isDisplayVisible = false;
                        });
                      },
                      child: Text('Return to Homepage'),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 100.0),
              TextField(
                controller: _textEditingController,
                decoration: InputDecoration(
                  labelText: 'Enter image name',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(Icons.clear),
                    onPressed: () {
                      setState(() {
                        _textEditingController.clear();
                        imageName = '';
                        _isDisplayVisible =
                            false; // Hide display box and button
                      });
                    },
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    imageName = value;
                  });
                },
              ),
              SizedBox(height: 16.0),
              Container(
                width: 150.0,
                height: 50.0,
                child: Opacity(
                  opacity: imageName.isNotEmpty ? 1.0 : 0.5,
                  child: ElevatedButton(
                    onPressed: _submitForm,
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    child: Text('Submit'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
