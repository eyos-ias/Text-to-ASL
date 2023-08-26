import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _textEditingController = TextEditingController();
  List<String> words = [];
  bool displayBoxVisible = false;
  String lastSubmittedText = '';

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  void _submitForm() {
    String input = _textEditingController.text.trim();
    if (input.isNotEmpty && input != lastSubmittedText) {
      List<String> inputWords = input.split(' ');
      setState(() {
        words.addAll(inputWords);
        displayBoxVisible = true;
        lastSubmittedText = input;
      });
    }
  }

  void _clearForm() {
    setState(() {
      words.clear();
      displayBoxVisible = false;
      lastSubmittedText = '';
    });
    _textEditingController.clear();
  }

  String getGifPath(String word) {
    return 'images/$word.gif';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: AssetImage('images/ear.jpg'),
              radius: 20.0,
            ),
            SizedBox(width: 10.0),
            Text('Commusign'),
          ],
        ),
      ),
      body: Container(
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/ASL.jpeg'),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
              children: [
                if (displayBoxVisible)
                  Column(
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
                      ElevatedButton(
                        onPressed: _clearForm,
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          minimumSize: Size(150.0, 50.0),
                        ),
                        child: Text('Close display'),
                      ),
                    ],
                  ),
                SizedBox(height: 16.0),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    color: Colors.grey.withOpacity(0.7),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(right: 16.0),
                    child: TextField(
                      controller: _textEditingController,
                      maxLines: null,
                      decoration: InputDecoration(
                        hintText: 'Enter text',
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.all(16.0),
                        suffixIcon: _textEditingController.text.isNotEmpty
                            ? IconButton(
                                icon: Icon(
                                  Icons.clear,
                                  color: Colors.black,
                                ),
                                onPressed: () {
                                  _textEditingController.clear();
                                },
                              )
                            : null,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: _submitForm,
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    minimumSize: Size(150.0, 50.0),
                  ),
                  child: Text('Translate'),
                ),
                SizedBox(height: 100.0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}