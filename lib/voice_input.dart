import 'dart:io';
import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

// void main() {
//   runApp(VoiceToGifApp());
// }

// class VoiceToGifApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Voice to GIF',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: VoiceToGifScreen(),
//     );
//   }
// }

class VoiceToGifScreen extends StatefulWidget {
  @override
  _VoiceToGifScreenState createState() => _VoiceToGifScreenState();
}

class _VoiceToGifScreenState extends State<VoiceToGifScreen> {
  late stt.SpeechToText _speech;
  bool _isRecording = false;
  String _text = '';
  List<String> _gifPaths = [];
  final TextEditingController _textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
    _textEditingController.addListener(_updateClearIconVisibility);
  }

  @override
  void dispose() {
    _speech.stop();
    _textEditingController.dispose();
    super.dispose();
  }

  void _updateClearIconVisibility() {
    setState(() {
      _text = _textEditingController.text;
    });
  }

  void _listen() async {
    if (!_isRecording) {
      bool available = await _speech.initialize(
        onStatus: (status) {
          if (status == 'notListening') {
            setState(() {
              _isRecording = false;
            });
          }
        },
        onError: (error) {
          print('Error: $error');
          setState(() {
            _isRecording = false;
          });
        },
      );
      if (available) {
        setState(() {
          _isRecording = true;
          _gifPaths = [];
        });
        _speech.listen(
          onResult: (result) {
            setState(() {
              _textEditingController.text = result.recognizedWords;
              _text = result.recognizedWords;
            });
            _displayGifs();
          },
        );
      }
    } else {
      setState(() {
        _isRecording = false;
      });
      _speech.stop();
    }
  }

  void _displayGifs() {
    String gifFolderPath = 'images/'; // Path to the folder containing the GIFs
    String inputWord =
        _text.toLowerCase(); // Convert the input word to lowercase
    String gifFilename = '$inputWord.gif'; // Append '.gif' to the input word
    String gifPath =
        gifFolderPath + gifFilename; // Construct the path to the GIF

    // Check if the GIF file exists
    bool gifExists = File(gifPath).existsSync();

    setState(() {
      _gifPaths = gifExists
          ? [gifPath]
          : []; // Display the GIF if it exists, else clear the list
    });
  }

  void _clearText() {
    setState(() {
      _textEditingController.clear();
      _text = '';
      _gifPaths = [];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Voice to GIF'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: _listen,
                    child: Icon(
                      _isRecording ? Icons.mic : Icons.mic_none,
                      size: 40,
                    ),
                    style: ElevatedButton.styleFrom(
                      shape: CircleBorder(),
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    _text,
                    style: TextStyle(fontSize: 20),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _clearText,
                    child: Icon(Icons.clear),
                  ),
                ],
              ),
            ),
          ),
          Container(
            height: 200,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _gifPaths.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Image.asset(_gifPaths[index]),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
