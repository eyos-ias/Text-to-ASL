import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:video_player/video_player.dart';
import 'dart:async';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Video Player',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: VideoPage(),
    );
  }
}

class VideoPage extends StatefulWidget {
  @override
  _VideoPageState createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;
  late VideoPlayerController _videoPlayerController =
      VideoPlayerController.asset('assets/placeholder_video.mp4');

  List<CameraDescription> cameras = [];
  bool showCameraPreview = false;
  bool isRecording = false;
  int recordingTime = 0;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    availableCameras().then((availableCameras) {
      cameras = availableCameras;
      _controller = CameraController(
        cameras[0],
        ResolutionPreset.medium,
        enableAudio: false,
      );
      _initializeControllerFuture = _controller.initialize();
      setState(() {});
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _videoPlayerController.dispose();
    _timer.cancel();
    super.dispose();
  }

  Future<void> _captureVideo() async {
    if (!_controller.value.isInitialized || !showCameraPreview) {
      return;
    }

    try {
      await _initializeControllerFuture;
      if (!_controller.value.isRecordingVideo) {
        setState(() {
          isRecording = true;
          recordingTime = 0;
        });

        _timer = Timer.periodic(Duration(seconds: 1), (timer) {
          setState(() {
            recordingTime++;
          });
        });

        await _controller.startVideoRecording();
        print('Video recording started');
      } else {
        _timer.cancel();
        await _controller.stopVideoRecording();
        setState(() {
          isRecording = false;
        });
        print('Video recording stopped');
      }
    } catch (e) {
      print('Error capturing video: $e');
    }
  }

  Widget _buildVideoPlayer() {
    if (_videoPlayerController.value.isInitialized) {
      return AspectRatio(
        aspectRatio: _videoPlayerController.value.aspectRatio,
        child: Stack(
          children: [
            VideoPlayer(_videoPlayerController),
            Positioned(
              top: showCameraPreview
                  ? _controller.value.previewSize!.height + 10
                  : 0,
              left: 16,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  'Recording Time: ${_formatRecordingTime(recordingTime)}',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            if (isRecording)
              Positioned.fill(
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Recording in progress',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
          ],
        ),
      );
    } else if (_videoPlayerController.value.hasError) {
      return Text(
        'Error loading video',
        style: TextStyle(color: Colors.red),
      );
    } else {
      return Container();
    }
  }

  String _formatRecordingTime(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    String formattedTime =
        '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
    return formattedTime;
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
                  'Video Input',
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ),
        body: Column(
          children: [
            if (showCameraPreview)
              Expanded(
                child: FutureBuilder<void>(
                  future: _initializeControllerFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      return CameraPreview(_controller);
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  },
                ),
              ),
            ElevatedButton(
              onPressed: _captureVideo,
              child: Text(isRecording ? 'Stop Recording' : 'Start Recording'),
            ),
            SizedBox(height: 16),
            _buildVideoPlayer(),
          ],
        ),
      );
    }
  }
}
