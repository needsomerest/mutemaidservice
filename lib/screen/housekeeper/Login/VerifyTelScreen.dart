import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:mutemaidservice/screen/housekeeper/HomeScreen/HomeMaidScreen.dart';

class VerifyTelScreen extends StatefulWidget {
  const VerifyTelScreen({super.key});

  @override
  State<VerifyTelScreen> createState() => _VerifyTelScreenState();
}

class _VerifyTelScreenState extends State<VerifyTelScreen> {
  late String _verificationId;
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  FirebaseAuth auth = FirebaseAuth.instance;

  TextEditingController phoneController = TextEditingController();
  TextEditingController smsController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          title:
              Text("Phone verification", style: TextStyle(color: Colors.white)),
          iconTheme: IconThemeData(
            color: Colors.white, //change your color here
          ),
        ),
        body: Container(
            color: Colors.green[50],
            child: Center(
              child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      gradient: LinearGradient(
                          colors: [Colors.yellow, Colors.green])),
                  margin: EdgeInsets.all(32),
                  padding: EdgeInsets.all(24),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Row(children: <Widget>[
                        Container(
                            padding: EdgeInsets.all(12),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                color: Colors.green[100]),
                            child: Text("+66",
                                style: TextStyle(
                                    fontSize: 18, color: Colors.black54))),
                        Expanded(child: buildTextFieldPhoneNumber()),
                        buildButtonSendSms()
                      ]),
                      buildTextFieldSmsVerification(),
                      buildButtonVerify()
                    ],
                  )),
            )));
  }

  Widget buildButtonVerify() {
    return InkWell(
        child: Container(
            constraints: BoxConstraints.expand(height: 50),
            child: Text("Sign in with Phone",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, color: Colors.white)),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Colors.green[200]),
            margin: EdgeInsets.only(top: 16),
            padding: EdgeInsets.all(12)),
        onTap: () => verifyPhone());
  }

  Widget buildButtonSendSms() {
    return InkWell(
        child: Container(
            height: 50,
            width: 100,
            child: Text("Send",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, color: Colors.white)),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Colors.orange[300]),
            padding: EdgeInsets.all(12),
            margin: EdgeInsets.only(left: 8)),
        onTap: () => requestVerifyCode());
  }

  Container buildTextFieldPhoneNumber() {
    return Container(
        padding: EdgeInsets.all(12),
        margin: EdgeInsets.only(left: 8),
        constraints: BoxConstraints.expand(height: 50),
        decoration: BoxDecoration(
            color: Colors.yellow[50], borderRadius: BorderRadius.circular(16)),
        child: TextField(
            controller: phoneController,
            decoration: InputDecoration.collapsed(hintText: "xx-xxx-xxxx"),
            keyboardType: TextInputType.phone,
            style: TextStyle(fontSize: 18)));
  }

  Container buildTextFieldSmsVerification() {
    return Container(
        padding: EdgeInsets.all(12),
        margin: EdgeInsets.only(top: 12),
        decoration: BoxDecoration(
            color: Colors.yellow[50], borderRadius: BorderRadius.circular(16)),
        child: TextField(
            controller: smsController,
            keyboardType: TextInputType.numberWithOptions(),
            decoration: InputDecoration.collapsed(hintText: "SMS verify"),
            style: TextStyle(fontSize: 18)));
  }

  // requestVerifyCode() {
  //   auth.verifyPhoneNumber(
  //       phoneNumber: "+66" + phoneController.text,
  //       timeout: const Duration(seconds: 40),
  //       verificationCompleted: (firebaseUser) {
  //         //
  //       },
  //       verificationFailed: (error) {
  //         print(
  //             'Phone number verification failed. Code: ${error.code}. Message: ${error.message}');
  //       },
  //       codeSent: (verificationId, [forceResendingToken]) {
  //         setState(() {
  //           _verificationId = verificationId;
  //         });
  //         print(verificationId);
  //       },
  //       codeAutoRetrievalTimeout: (verificationId) {
  //         //
  //       });
  // }

  requestVerifyCode() async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: "+66" + phoneController.text,
      // phoneNumber: '+66 92 345 6789',
      verificationCompleted: (PhoneAuthCredential credential) async {
        // ANDROID ONLY!
        // Sign the user in (or link) with the auto-generated credential
        // await auth.signInWithCredential(credential);
        //
      },
      verificationFailed: (FirebaseAuthException e) {
        if (e.code == 'invalid-phone-number') {
          print('The provided phone number is not valid.');
        }
      },
      codeSent: (String verificationId, int? resendToken) async {
        // String smsCode = 'xxxx';
        setState(() {
          _verificationId = verificationId;
        });
        // // Create a PhoneAuthCredential with the code
        // PhoneAuthCredential credential = PhoneAuthProvider.credential(
        //     verificationId: verificationId, smsCode: smsCode);

        // // Sign the user in (or link) with the credential
        // await auth.signInWithCredential(credential);
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        //
      },
    );
  }

  // ConfirmationResult confirmationResult = await auth.signInWithPhoneNumber('+44 7123 123 456', RecaptchaVerifier(
//   container: 'recaptcha',
//   size: RecaptchaVerifierSize.compact,
//   theme: RecaptchaVerifierTheme.dark,
// ));
// RecaptchaVerifier(
//   onSuccess: () => print('reCAPTCHA Completed!'),
//   onError: (FirebaseAuthException error) => print(error),
//   onExpired: () => print('reCAPTCHA Expired!'),
// );
  verifyPhone() async {
    final UserCredential user = await auth.signInWithCredential(
        PhoneAuthProvider.credential(
            verificationId: _verificationId, smsCode: smsController.text));
    navigateToHomepage(context, user);
  }

  void navigateToHomepage(BuildContext context, UserCredential user) {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => HomeMaidScreen()),
        ModalRoute.withName('/'));
  }
}
