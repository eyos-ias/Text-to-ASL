import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:first/main.dart';
import 'package:flutter/material.dart';



File file = File("");

class filePicker extends StatefulWidget {
  const filePicker({super.key});

  @override
  State<filePicker> createState() => _filePickerState();
}

class _filePickerState extends State<filePicker> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Column(
          children: [
            Image.file(file),
            TextButton(
                onPressed: () {
                  pickFile();
                },
                child: const Text("pick file"))
          ],
        ),
      ),
    );
  }

  void pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

  }
}
