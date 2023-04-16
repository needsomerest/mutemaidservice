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

  final snackBarSucess = SnackBar(
    content: const Text('สำเร็จ กรุณาตรวจสอบอีเมลเพื่อสร้างรหัสผ่านใหม่'),
    backgroundColor: HexColor("#489934"),
  );

  final snackLoginEmailFail = SnackBar(
    content: const Text('ไม่พบอีเมลดังกล่าวในระบบ'),
    backgroundColor: HexColor("#5D5FEF"),
  );

  final snackLoginUnknowFail = SnackBar(
    content: const Text('กรุณาใส่อีเมลเพื่อทำการกู้รหัสผ่าน'),
    backgroundColor: HexColor("#5D5FEF"),
  );

  Future resetPassword() async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: emailController.text.trim());
      //Utils.showSnackBar('Password Reset Email sent');
      ScaffoldMessenger.of(context).showSnackBar(snackBarSucess);
      //Navigator.of(context).popUntil((route) => route.isFirst);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(context).showSnackBar(snackLoginEmailFail);
      } else if (e.code == 'unknown') {
        ScaffoldMessenger.of(context).showSnackBar(snackLoginUnknowFail);
      }
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Failed with error code: ${e.code}'),
        backgroundColor: HexColor("#5D5FEF"),
      ));
    }
  }

  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(
            "ลืมรหัสผ่าน",
            style: TextStyle(
                color: HexColor("#000000"),
                fontSize: 20,
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
              HeaderAccount("ค้นหาบัญชีของคุณ", 30, "#5D5FEF"),
              const SizedBox(height: 50),
              Text(
                "โปรดป้อนอีเมลเพื่อค้นหาบัญชีของคุณ",
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
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  resetPassword();
                },
                child: const Text('ส่ง', style: TextStyle(fontSize: 18)),
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
