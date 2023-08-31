import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class VoiceInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Voice to Text',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: VoiceToTextPage(),
    );
  }
}

class VoiceToTextPage extends StatefulWidget {
  @override
  _VoiceToTextPageState createState() => _VoiceToTextPageState();
}

class _VoiceToTextPageState extends State<VoiceToTextPage> {
  late stt.SpeechToText _speech;
  bool _isListening = false;
  String _text = '';

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
  }

  void _listen() async {
    if (!_isListening) {
      bool available = await _speech.initialize(
        onStatus: (status) {
          print('onStatus: $status');
          setState(() {
            _isListening = status == 'listening';
          });
        },
        onError: (error) {
          print('onError: $error');
          setState(() {
            _isListening = false;
          });
        },
      );
      if (available) {
        setState(() {
          _isListening = true;
        });
        _speech.listen(
          onResult: (result) {
            setState(() {
              _text = result.recognizedWords;
            });
          },
        );
      }
    } else {
      setState(() {
        _isListening = false;
        _speech.stop();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Voice to Text'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: Text(
                _text,
                style: TextStyle(fontSize: 24.0),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _listen,
        child: Icon(
          _isListening ? Icons.mic : Icons.mic_none,
          color: _isListening ? Colors.black : Colors.red,
        ),
      ),
    );
  }
}
