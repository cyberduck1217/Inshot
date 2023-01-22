import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:inshot/screens/login_otp.dart';
import 'package:inshot/screens/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:inshot/screens/video_player.dart';
import 'package:inshot/screens/video_record.dart';
import 'package:path/path.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // Obtain a list of the available cameras on the device.
  final cameras = await availableCameras();
  // Get a specific camera from the list of available cameras.
  final firstCamera = cameras.first;
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: "InShot",
    initialRoute: '/third',
    routes: {
      // When navigating to the "/" route, build the FirstScreen widget.
      '/': (context) => const Login_Screen(),
      // When navigating to the "/second" route, build the SecondScreen widget.
      '/second': (context) => const LoginOtp(),
      // ignore: prefer_const_constructors
      '/third': (context) => RecordVid(
            camera: cameras.first,
          ),
      '/fourth': (context) => const VideoApp(
            filePath: 'videoPath',
          )
    },
  ));
}

class Main extends StatelessWidget {
  const Main({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("InShot"),
      ),
    );
  }
}
