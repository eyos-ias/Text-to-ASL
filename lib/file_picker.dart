import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:file_picker/file_picker.dart';

class FilePickerExample extends StatefulWidget {
  @override
  _FilePickerExampleState createState() => _FilePickerExampleState();
}

class _FilePickerExampleState extends State<FilePickerExample> {
  String _filePath = '';

  Future<void> _openFileExplorer() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.any,
      );

      if (result != null) {
        String? name = result.files.first.name;
        String? path = result.files.first.path;
        setState(() {
          _filePath = path!;
        });
        print(_filePath);
      }
    } on PlatformException catch (e) {
      print('Error while picking the file: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('File Explorer'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: _openFileExplorer,
              child: Text('Open File Explorer'),
            ),
            SizedBox(height: 16),
            Text(
              'Selected File: $_filePath',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
