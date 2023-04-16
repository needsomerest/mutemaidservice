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
import 'package:mutemaidservice/screen/admin/SigninScreen/SignupAdminScreen.dart';
import 'package:mutemaidservice/screen/user/Signin/ForgotPasswordScreen.dart';
import 'package:mutemaidservice/screen/user/UserScreen/Signup/SignupScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class SigninAdminScreen extends StatefulWidget {
  @override
  _SigninAdminScreenState createState() => _SigninAdminScreenState();
}

class _SigninAdminScreenState extends State<SigninAdminScreen> {
  static const String _title = 'Sign In | Mute Maid Service';
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  User? get currentUser => _firebaseAuth.currentUser;
  Stream<User?> get authStateChange => _firebaseAuth.authStateChanges();

  String? errorMessage = '';
  bool isLogin = true;

  final snackLoginPasswordFail = SnackBar(
    content: const Text('รหัสผ่านไม่ถูกต้อง กรุณาตรวจสอบข้อมูล'),
    backgroundColor: HexColor("#5D5FEF"),
  );

  final snackLoginUnknowFail = SnackBar(
    content: const Text('กรุณากรอกข้อมูลเพื่อเข้าสู่ระบบ'),
    backgroundColor: HexColor("#5D5FEF"),
  );

  final snackLoginEmailFail = SnackBar(
    content: const Text('ไม่พบอีเมลดังกล่าวในระบบ กรุณาตรวจสอบข้อมูล'),
    backgroundColor: HexColor("#5D5FEF"),
  );

  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();

  void initState() {
    _loadUserEmailPassword();
    super.initState();
  }

  Future<void> signInWithEmailAndPassword() async {
    try {
      await Auth().signInWithEmailandPassword(
        email: _controllerEmail.text,
        password: _controllerPassword.text,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('ไม่พบอีเมลดังกล่าวในระบบ กรุณาตรวจสอบข้อมูล');
      } else if (e.code == 'wrong-password') {
        print('รหัสผ่านไม่ถูกต้อง กรุณาตรวจสอบข้อมูล');
      } else {
        print('Failed with error code: ${e.code}');
      }
    }
  }

  bool value = false;
  bool _isObscure = true;
  bool RemembermeCheck = false;

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
                child: HeaderAccount("เข้าสู่ระบบ", 40, "#000000"),
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
                          hintText: 'อีเมล',
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
                          hintText: 'รหัสผ่าน',
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
                    value: RemembermeCheck,
                    shouldShowBorder: true,
                    borderColor: HexColor("#5D5FEF"),
                    checkedFillColor: HexColor("#5D5FEF"),
                    borderRadius: 6,
                    borderWidth: 1,
                    checkBoxSize: 20,
                    onChanged: _handleRemeberme,
                  ),
                  Text(
                    "จดจำฉันในระบบ",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w900),
                  ),
                  Spacer(),
                ],
              )),
              const SizedBox(height: 12),
              Container(
                child: ElevatedButton(
                  onPressed: () async {
                    try {
                      final userCredential =
                          await _firebaseAuth.signInWithEmailAndPassword(
                              email: _controllerEmail.text.trim(),
                              password: _controllerPassword.text.trim());
                    } on FirebaseAuthException catch (e) {
                      if (e.code == 'user-not-found') {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(snackLoginEmailFail);
                      } else if (e.code == 'wrong-password') {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(snackLoginPasswordFail);
                      } else if (e.code == 'unknown') {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(snackLoginUnknowFail);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content:
                                Text('Failed with error code: ${e.code}')));
                      }
                    }

                    //signInWithEmailAndPassword();
                    /*Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomeScreen()),
                  );*/
                  },
                  child:
                      const Text('เข้าสู่ระบบ', style: TextStyle(fontSize: 18)),
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
                  'ลืมรหัสผ่าน?',
                  style: TextStyle(
                      color: HexColor("#5D5FEF"),
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
                onTap: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ForgotPasswordScreen())),
              ),
              const SizedBox(height: 30),
              DividerAccount("หรือดำเนินการต่อด้วย", 10),
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
                  "ยังไม่มีบัญชี?    ", "#000000", "ลงทะเบียนผู้ใช้", "#5D5FEF")
            ]),
          ),
        ),
      );

  void _handleRemeberme(bool value) {
    print("Handle Rember Me");
    RemembermeCheck = value;
    SharedPreferences.getInstance().then(
      (prefs) {
        prefs.setBool("remember_me", value);
        prefs.setString('email', _controllerEmail.text);
        prefs.setString('password', _controllerPassword.text);
      },
    );
    setState(() {
      RemembermeCheck = value;
    });
  }

  void _loadUserEmailPassword() async {
    print("Load Email");
    try {
      SharedPreferences _prefs = await SharedPreferences.getInstance();
      var _email = _prefs.getString("email") ?? "";
      var _password = _prefs.getString("password") ?? "";
      var _remeberMe = _prefs.getBool("remember_me") ?? false;

      print(_remeberMe);
      print(_email);
      print(_password);
      if (_remeberMe) {
        setState(() {
          RemembermeCheck = true;
        });
        _controllerEmail.text = _email;
        _controllerPassword.text = _password;
      }
    } catch (e) {
      print(e);
    }
  }
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
                    MaterialPageRoute(
                        builder: (context) => SignupAdminScreen()),
                  );
                }),
        ]),
      ),
    );
  }
}
