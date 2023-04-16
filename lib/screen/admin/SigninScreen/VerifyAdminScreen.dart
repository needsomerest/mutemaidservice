import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:mutemaidservice/screen/admin/SigninScreen/SignupAdminScreen.dart';

class VerifyAdminScreen extends StatefulWidget {
  const VerifyAdminScreen({super.key});

  @override
  State<VerifyAdminScreen> createState() => _VerifyAdminScreenState();
}

class _VerifyAdminScreenState extends State<VerifyAdminScreen> {
  final TextEditingController _controllersVerifyCode = TextEditingController();
  final snackBarVerifycodeFail =
      SnackBar(content: const Text('รหัสยืนยันตัวตนไม่ถูกต้อง'));
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            color: Colors.green[50],
            child: Center(
              child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      gradient: LinearGradient(
                          colors: [HexColor('#5D5FEF'), Colors.white])),
                  margin: EdgeInsets.all(32),
                  padding: EdgeInsets.all(24),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("ยืนยันตัวตนด้วยรหัสแอดมิน",
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.black54,
                              fontWeight: FontWeight.bold)),
                      SizedBox(height: 20),
                      TextFormField(
                        controller: _controllersVerifyCode,
                        cursorColor: HexColor("#5D5FEF"),
                        textAlign: TextAlign.left,
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(
                            isDense: true, // Added this
                            contentPadding: EdgeInsets.all(14),
                            hintText: 'กรุณาใส่รหัสยืนยันตัวตนสำหรับแอดมิน',
                            hintStyle: TextStyle(fontSize: 14),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(60.0),
                              borderSide: BorderSide(
                                width: 0,
                                style: BorderStyle.none,
                              ),
                            ),
                            filled: true,
                            fillColor: HexColor("DFDFFC"),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(60.0),
                              borderSide: BorderSide(
                                color: HexColor("#5D5FEF"),
                                //fixedSize: MaterialStateProperty.all(const Size(350, 40)),
                              ),
                            )),
                      ),
                      Container(
                        height: 50,
                        width: 100,
                        margin: EdgeInsets.all(20),
                        child: ElevatedButton(
                          onPressed: () {
                            final verifycode = _controllersVerifyCode.text;

                            if (verifycode == "adminmutemaid2299") {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SignupAdminScreen()),
                              );
                            } else {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBarVerifycodeFail);
                            }
                          },
                          child: const Text('ยืนยัน',
                              style: TextStyle(fontSize: 18)),
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(HexColor("5D5FEF")),
                            fixedSize:
                                MaterialStateProperty.all(const Size(300, 50)),
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )),
            )));
  }
}
