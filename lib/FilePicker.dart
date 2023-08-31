import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:open_file_chooser/open_file_chooser.dart';

class FilePickerExample extends StatefulWidget {
  @override
  _FilePickerExampleState createState() => _FilePickerExampleState();
}

class _FilePickerExampleState extends State<FilePickerExample> {
  String? _fileName;
  String? _filePath;

  Future<void> _openFilePicker() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['*'],
      );

      if (result != null) {
        PlatformFile file = result.files.first;

        setState(() {
          _fileName = file.name;
          _filePath = file.path!;
        });

        print('Selected File: $_fileName');
        print('File Path: $_filePath');

        if (Platform.isAndroid) {
          OpenFile.open(_filePath!);
        } else if (Platform.isIOS) {
          await OpenFile.open(_filePath!);
        } else {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Unsupported Platform'),
                content: Text('File opening is not supported on this platform.'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('OK'),
                  )
                ],
              );
            },
          );
        }
      }
    } catch (e) {
      print('Error while picking or opening the file: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('File Picker Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: _openFilePicker,
              child: Text('Open File Picker'),
            ),
            SizedBox(height: 16),
            Text(
              'Selected File: ${_fileName ?? ''}',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            Text(
              'File Path: ${_filePath ?? ''}',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(FilePickerApp());
}

class FilePickerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'File Picker Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FilePickerExample(),
    );
  }
}