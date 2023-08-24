import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.0), // Adjust the height as needed
        child: AppBar(
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.black),
          title: Row(
            children: [
              ClipOval(
                child: Image.asset(
                  'images/zagolnabuk.png', // Replace with your logo path
                  height: 40, // Adjust the height as needed
                  width: 40, // Adjust the width as needed
                ),
              ),
              SizedBox(width: 8),
              Text(
                'Text Box Example',
                style: TextStyle(color: Colors.black),
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            children: [
              Container(
                height: 500,
                color: Colors.blue,
                // Add any content you want to display in the box
              ),
              SizedBox(height: 100),
              TextField(
                controller: _textEditingController,
                decoration: InputDecoration(
                  labelText: 'Enter Text',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(Icons.clear),
                    onPressed: () {
                      _textEditingController.clear();
                    },
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
