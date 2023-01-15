import 'package:flutter/material.dart';
import 'package:inshot/screens/login_otp.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Login_Screen extends StatefulWidget {
  static String verify = "";
  const Login_Screen({Key? key}) : super(key: key);

  @override
  State<Login_Screen> createState() => _Login_ScreenState();
}

class _Login_ScreenState extends State<Login_Screen> {
  var phone = "";
  TextEditingController countrycode = TextEditingController();

  @override
  void initState() {
    countrycode.text = "+91";
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("InShot"),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        height: MediaQuery.of(context).size.height * .9,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              onChanged: (value) {
                phone = value;
              },
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                hintText: 'Mobile Number?',
                labelText: 'Enter Your Number',
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
                style: const ButtonStyle(
                    elevation: MaterialStatePropertyAll(2),
                    backgroundColor: MaterialStatePropertyAll(Colors.black12)),
                onPressed: () async {
                  await FirebaseAuth.instance.verifyPhoneNumber(
                    phoneNumber: countrycode.text + phone,
                    verificationCompleted: (PhoneAuthCredential credential) {},
                    verificationFailed: (FirebaseAuthException e) {},
                    codeSent: (String verificationId, int? resendToken) {
                      Login_Screen.verify = verificationId;
                      Navigator.pushNamed(context, "/second");
                    },
                    codeAutoRetrievalTimeout: (String verificationId) {},
                  );
                  // ignore: use_build_context_synchronously
                },
                child: const Text(
                  "NEXT",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Colors.lightBlue),
                ))
          ],
        ),
      ),
    );
  }
}
