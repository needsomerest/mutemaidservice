import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:custom_check_box/custom_check_box.dart';
import 'package:mutemaidservice/component/DividerAccount.dart';
import 'package:mutemaidservice/component/HeaderAccount.dart';
import 'package:mutemaidservice/model/AuthService/AuthGoogle.dart';
import 'package:mutemaidservice/model/auth.dart';
import 'package:mutemaidservice/screen/Signin/ForgotPasswordScreen.dart';
import 'package:mutemaidservice/screen/UserScreen/Signup/SignupScreen.dart';

class SigninScreen extends StatefulWidget {
  @override
  _SigninScreenState createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  static const String _title = 'Sign In | MCS Service';
  String? errorMessage = '';
  bool isLogin = true;

  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();

  Future<void> signInWithEmailAndPassword() async {
    try {
      await Auth().signInWithEmailandPassword(
        email: _controllerEmail.text,
        password: _controllerPassword.text,
      );
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
    }
  }

  bool value = false;
  bool _isObscure = true;
  bool shouldCheck = false;

  get alignment => null;

  @override
  Widget build(BuildContext context) => Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 60),
            //padding: const EdgeInsets.all(22.0),
            child: Column(children: [
              Container(
                alignment: FractionalOffset.topLeft,
                child: HeaderAccount("Login to your Account", 40, "#000000"),
              ),
              const SizedBox(height: 30),
              Container(
                child: Column(
                  children: [
                    TextFormField(
                      controller: _controllerEmail,
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
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    TextFormField(
                      controller: _controllerPassword,
                      cursorColor: HexColor("#5D5FEF"),
                      textAlign: TextAlign.left,
                      obscureText: _isObscure,
                      keyboardType: TextInputType.visiblePassword,
                      decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.lock,
                            color: Colors.black,
                          ),
                          hintText: 'Password',
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
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(_isObscure
                                ? Icons.visibility
                                : Icons.visibility_off),
                            color: Colors.black,
                            onPressed: () {
                              setState(() {
                                _isObscure = !_isObscure;
                              });
                            },
                          )),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 12),
              Container(
                  child: Row(
                children: <Widget>[
                  Spacer(),
                  CustomCheckBox(
                    value: shouldCheck,
                    shouldShowBorder: true,
                    borderColor: HexColor("#5D5FEF"),
                    checkedFillColor: HexColor("#5D5FEF"),
                    borderRadius: 6,
                    borderWidth: 1,
                    checkBoxSize: 20,
                    onChanged: (val) {
                      //do your stuff here
                      setState(() {
                        shouldCheck = val;
                      });
                    },
                  ),
                  Text(
                    "Remember me",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w900),
                  ),
                  Spacer(),
                ],
              )),
              const SizedBox(height: 12),
              Container(
                child: ElevatedButton(
                  onPressed: () {
                    signInWithEmailAndPassword();
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
              ),
              const SizedBox(height: 10),
              GestureDetector(
                child: Text(
                  'Forgot the password?',
                  style: TextStyle(
                      color: HexColor("#5D5FEF"),
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
                onTap: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ForgotPasswordScreen())),
              ),
              const SizedBox(height: 30),
              DividerAccount("or continue with", 10),
              const SizedBox(height: 10),
              Container(
                child: ButtonBar(
                  alignment: MainAxisAlignment.center,
                  children: [
                    OutlinedButton(
                      // facebook button
                      onPressed: () {
                        AuthGoogle().signInWithGoogle();
                      },
                      child: FaIcon(FontAwesomeIcons.facebook),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.white,
                        onPrimary: HexColor("#5D5FEF"),
                        minimumSize: Size(50, 50),
                      ),
                    ),
                    OutlinedButton(
                      //google button
                      onPressed: () {
                        AuthGoogle().signInWithGoogle();
                      },
                      child: FaIcon(FontAwesomeIcons.google),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.white,
                        onPrimary: HexColor("#5D5FEF"),
                        minimumSize: Size(50, 50),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              BottomSignin(
                  "Don’t have an account?    ", "#000000", "Sign up", "#5D5FEF")
            ]),
          ),
        ),
      );
}

class BottomSignin extends StatelessWidget {
  String FirstTitle;
  String FistTitleColor;
  String SecondTitle;
  String SecondTitleColor;

  BottomSignin(this.FirstTitle, this.FistTitleColor, this.SecondTitle,
      this.SecondTitleColor);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: RichText(
        text: TextSpan(children: [
          TextSpan(
            text: FirstTitle,
            style: TextStyle(
                color: HexColor(FistTitleColor),
                fontSize: 16,
                fontWeight: FontWeight.bold),
          ),
          TextSpan(
              text: SecondTitle,
              style: TextStyle(
                  color: HexColor(SecondTitleColor),
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SignupScreen()),
                  );
                }),
        ]),
      ),
    );
  }
}
