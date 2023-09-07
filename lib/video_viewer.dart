import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:file_picker/file_picker.dart';
import 'package:video_player/video_player.dart';
import 'dart:io';

class VideoPage extends StatefulWidget {
  @override
  _VideoPageState createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;
  late VideoPlayerController _videoPlayerController;

  List<CameraDescription> cameras = [];

  @override
  void initState() {
    super.initState();
    // Retrieve the available cameras
    availableCameras().then((availableCameras) {
      cameras = availableCameras;
      // Initialize the camera controller
      _controller = CameraController(
        cameras[0],
        ResolutionPreset.medium,
      );
      // Initialize the camera controller future
      _initializeControllerFuture = _controller.initialize();
      setState(() {});
    });
  }

  @override
  void dispose() {
    // Dispose of the camera controller and video player controller
    _controller.dispose();
    _videoPlayerController.dispose();
    super.dispose();
  }

  Future<void> _selectVideoFromStorage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.video,
    );

    if (result != null) {
      File videoFile = File(result.files.first.path!);
      _videoPlayerController = VideoPlayerController.file(videoFile)
        ..initialize().then((_) {
          setState(() {});
        });
    }
  }

  Widget _buildVideoPlayer() {
    if (_videoPlayerController.value.isInitialized) {
      return AspectRatio(
        aspectRatio: _videoPlayerController.value.aspectRatio,
        child: VideoPlayer(_videoPlayerController),
      );
    } else {
      return CircularProgressIndicator();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (cameras.isEmpty) {
      return CircularProgressIndicator();
    } else {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          leading: IconButton(
            icon: Image.asset(
              'images/Vectorback.png',
              width: 10,
            ),
            onPressed: () {
              Navigator.pop(context); // Navigates to the previous page
            },
          ),
          title: Container(
            width: 200.0,
            child: Row(
              children: [
                Image.asset(
                  'images/Icon1.png',
                  width: 30,
                  height: 30,
                ),
                SizedBox(width: 8),
                Text(
                  'Video',
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: FutureBuilder<void>(
                future: _initializeControllerFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    // If the Future is complete, display the camera preview
                    return CameraPreview(_controller);
                  } else {
                    // Otherwise, display a loading spinner
                    return Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ),
            ElevatedButton(
              onPressed: _selectVideoFromStorage,
              child: Text('Select Video from Storage'),
            ),
            SizedBox(height: 16),
            _buildVideoPlayer(),
          ],
        ),
      );
    }
  }
}
