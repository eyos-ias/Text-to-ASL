import 'dart:io';

import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final cameras = await availableCameras();
  final firstCamera = cameras.first;

  runApp(MyApp(camera: firstCamera));
}

class MyApp extends StatelessWidget {
  final CameraDescription camera;

  const MyApp({required this.camera});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Camera Switch',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CameraScreen(camera: camera),
    );
  }
}

class CameraScreen extends StatefulWidget {
  final CameraDescription camera;

  const CameraScreen({required this.camera});

  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;
  late bool _isFrontCamera;
  late bool _isRecording;
  late String _videoPath;

  @override
  void initState() {
    super.initState();
    _isFrontCamera = false;
    _isRecording = false;
    _controller = CameraController(
      widget.camera,
      ResolutionPreset.medium,
    );
    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _toggleCamera() async {
    final cameras = await availableCameras();
    final newCamera = cameras.firstWhere(
        (camera) => camera.lensDirection != widget.camera.lensDirection);

    if (_controller.value.isRecordingVideo) {
      return;
    }

    await _controller.dispose();
    setState(() {
      _controller = CameraController(
        newCamera,
        ResolutionPreset.medium,
      );
      _initializeControllerFuture = _controller.initialize();
      _isFrontCamera = !_isFrontCamera;
    });

    await _initializeControllerFuture;
  }

  Future<void> _startVideoRecording() async {
    if (!_controller.value.isInitialized ||
        _controller.value.isRecordingVideo) {
      return;
    }

    final Directory appDir = await getTemporaryDirectory();
    final String videoName = '${DateTime.now()}.mp4';
    _videoPath = path.join(appDir.path, videoName);

    await _controller.startVideoRecording(
      // _videoPath  
    );

    setState(() {
      _isRecording = true;
    });
  }

  Future<void> _stopVideoRecording() async {
    if (!_controller.value.isRecordingVideo) {
      return;
    }

    try {
      await _controller.stopVideoRecording();
    } catch (e) {
      print('Error stopping video recording: $e');
      return;
    }

    setState(() {
      _isRecording = false;
    });

    final galleryDir = await getExternalStorageDirectory();
    final galleryPath = path.join(galleryDir!.path, 'Videos');
    final savedVideoPath = path.join(galleryPath, path.basename(_videoPath));

    await Directory(galleryPath).create(recursive: true);
    await File(_videoPath).copy(savedVideoPath);

    // Refresh the gallery to ensure the video is visible
    if (Platform.isAndroid) {
      // Implement your gallery refresh logic for Android
    } else if (Platform.isIOS) {
      // Implement your gallery refresh logic for iOS
    }
  }

  void _toggleRecording() {
    if (_isRecording) {
      _stopVideoRecording();
    } else {
      _startVideoRecording();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Camera Switch')),
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return CameraPreview(_controller);
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _toggleRecording,
        child: Icon(_isRecording ? Icons.stop : Icons.fiber_manual_record),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              onPressed: _toggleCamera,
              icon: Icon(Icons.switch_camera),
            ),
          ],
        ),
      ),
    );
  }
}
