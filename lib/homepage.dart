import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _textEditingController = TextEditingController();
  String imageName = '';
  Map<String, String> imageMap = {
    'image': 'images/image.jpg',
    'image2': 'images/image2.jpg',
    // Add mappings for the remaining images here
    // 'image3': 'images/image3.jpg',
    // 'image4': 'images/image4.jpg',
    // ...
    // 'image25': 'images/image25.jpg',
  };

  Widget _buildImageDisplay(String imagePath) {
    if (imagePath.isEmpty) {
      return Container();
    }

    return Container(
      width: double.infinity,
      height: 200.0,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.blue),
      ),
      child: Image.asset(
        imagePath,
        fit: BoxFit.cover,
      ),
    );
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
                visible: imageMap[imageName]?.isNotEmpty ?? false,
                child: _buildImageDisplay(imageMap[imageName] ?? ''),
              ),
              SizedBox(height: 100.0),
              Visibility(
                visible: imageMap[imageName]?.isEmpty ?? true,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextField(
                      controller: _textEditingController,
                      decoration: InputDecoration(
                        labelText: 'Enter image name',
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue),
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
                        opacity: 0.5,
                        child: ElevatedButton(
                          onPressed: () {
                            // Do something when the button is pressed
                          },
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
            ],
          ),
        ),
      ),
    );
  }
}