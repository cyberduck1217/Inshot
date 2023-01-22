import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:inshot/screens/video_player.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class RecordVid extends StatefulWidget {
  const RecordVid({Key? key, required this.camera}) : super(key: key);
  final CameraDescription camera;

  @override
  State<RecordVid> createState() => _RecordVidState();
}

late String videoPath;

class _RecordVidState extends State<RecordVid> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;
  bool isDisabled = false;

  @override
  void initState() {
    super.initState();
    // To display the current output from the Camera,
    // create a CameraController.
    _controller = CameraController(
      // Get a specific camera from the list of available cameras.
      widget.camera,
      // Define the resolution to use.
      ResolutionPreset.medium,
    );

    // Next, initialize the controller. This returns a Future.
    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    // Dispose of the controller when the widget is disposed.
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: _initializeControllerFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          // If the Future is complete, display the preview.
          return Stack(
            children: [
              Container(
                alignment: Alignment.center,
                child: CameraPreview(_controller),
              ),
              Align(
                  alignment: Alignment.bottomCenter,
                  child: !_controller.value.isRecordingVideo
                      ? RawMaterialButton(
                          onPressed: () async {
                            try {
                              await _initializeControllerFuture;

                              videoPath = join(
                                  (await getApplicationDocumentsDirectory())
                                      .path,
                                  '${DateTime.now()}.mp4');
                              // ignore: use_build_context_synchronously

                              setState(() {
                                _controller.startVideoRecording();
                                isDisabled = true;
                                isDisabled = !isDisabled;
                              });
                            } catch (e) {
                              print(e);
                            }
                          },
                          padding: EdgeInsets.all(10),
                          shape: CircleBorder(),
                          child: const Icon(
                            Icons.camera,
                            size: 50.0,
                            color: Colors.yellow,
                          ),
                        )
                      : null),
              Align(
                  alignment: Alignment.bottomCenter,
                  child: isDisabled == !_controller.value.isRecordingVideo
                      ? RawMaterialButton(
                          onPressed: () {
                            setState(() {
                              if (_controller.value.isRecordingVideo) {
                                _controller.stopVideoRecording();
                                isDisabled = false;
                                isDisabled = !isDisabled;
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        VideoApp(filePath: videoPath),
                                  ),
                                );
                              }
                            });
                          },
                          padding: EdgeInsets.all(10),
                          shape: CircleBorder(),
                          child: const Icon(
                            Icons.stop,
                            size: 50.0,
                            color: Colors.red,
                          ),
                        )
                      : null)
            ],
          );
        } else {
          // Otherwise, display a loading indicator.
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
