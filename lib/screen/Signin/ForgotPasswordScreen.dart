import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:email_validator/email_validator.dart';
import 'package:basic_utils/basic_utils.dart';
import 'package:mutemaidservice/component/HeaderAccount.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  @override
  void dispose() {
    emailController.dispose();
  }

  final snackBarSucess =
      SnackBar(content: const Text('Success. Password Reset Email sent'));

  final snackBarFail = SnackBar(
    content: const Text('Faild. Something is wrong'),
    action: SnackBarAction(
      label: 'Undo',
      onPressed: () {
        // Some code to undo the change.
      },
    ),
  );
  Future resetPassword() async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: emailController.text.trim());
      //Utils.showSnackBar('Password Reset Email sent');
      ScaffoldMessenger.of(context).showSnackBar(snackBarSucess);
      Navigator.of(context).popUntil((route) => route.isFirst);
    } on FirebaseAuthException catch (e) {
      print(e);
      Navigator.of(context).pop();
      //Utils.showSnackBar(e.message);
      ScaffoldMessenger.of(context).showSnackBar(snackBarFail);
    }
  }

  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(
            "Forgot password",
            style: TextStyle(
                color: HexColor("#5D5FEF"),
                fontSize: 30,
                fontFamily: 'Kanit',
                fontWeight: FontWeight.bold),
          ),
          backgroundColor: HexColor("#FFFFFF"),
          elevation: 0,
          iconTheme: IconThemeData(color: HexColor("#5D5FEF")),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 60),
            //padding: const EdgeInsets.all(22.0),
            child: Column(children: [
              const SizedBox(height: 30),
              HeaderAccount("Forget Password", 40, "#000000"),
              const SizedBox(height: 50),
              Text(
                "Enter Email Address",
                style: TextStyle(color: HexColor("BDBDBD")),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: emailController,
                cursorColor: HexColor("#5D5FEF"),
                textAlign: TextAlign.left,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.email,
                      color: Colors.black,
                    ),
                    hintText: 'Email',
                    hintStyle: TextStyle(fontSize: 14),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6.0),
                      borderSide: BorderSide(
                        width: 0,
                        style: BorderStyle.none,
                        //fixedSize: MaterialStateProperty.all(const Size(350, 40)),
                      ),
                    ),
                    filled: true,
                    fillColor: HexColor("F1F1F1"),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6.0),
                      borderSide: BorderSide(
                        color: HexColor("#5D5FEF"),

                        //fixedSize: MaterialStateProperty.all(const Size(350, 40)),
                      ),
                    )),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (email) =>
                    email != null && !EmailValidator.validate(email)
                        ? 'Email a valid email'
                        : null,
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  resetPassword();
                  // signInWithEmailAndPassword();
                  /*Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomeScreen()),
                  );*/
                },
                child: const Text('Sign in', style: TextStyle(fontSize: 18)),
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(HexColor("5D5FEF")),
                  fixedSize: MaterialStateProperty.all(const Size(350, 40)),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
              ),
            ]),
          ),
        ),
      );
}
