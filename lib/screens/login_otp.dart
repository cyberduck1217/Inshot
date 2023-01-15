// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:inshot/screens/login_screen.dart';
import 'package:pinput/pinput.dart';

class LoginOtp extends StatefulWidget {
  const LoginOtp({Key? key}) : super(key: key);

  @override
  State<LoginOtp> createState() => _LoginOtpState();
}

class _LoginOtpState extends State<LoginOtp> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  var code = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("InShot"),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        height: MediaQuery.of(context).size.height * .9,
        width: MediaQuery.of(context).size.width * .9,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(
              height: 20,
            ),
            Pinput(
              length: 6,
              showCursor: true,
              onChanged: (value) {
                code = value;
              },
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
                style: ButtonStyle(elevation: MaterialStatePropertyAll(2)),
                onPressed: () async {
                  PhoneAuthCredential credential = PhoneAuthProvider.credential(
                      verificationId: Login_Screen.verify, smsCode: code);

                  // Sign the user in (or link) with the credential
                  await auth.signInWithCredential(credential);
                  // ignore: use_build_context_synchronously
                  Navigator.pushNamed(context, '/third');
                },
                child: Text(
                  "Get Started",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Colors.blueAccent),
                ))
          ],
        ),
      ),
    );
  }
}
