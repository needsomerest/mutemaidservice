import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:mutemaidservice/component/HeaderAccount.dart';
import 'package:mutemaidservice/screen/housekeeper/SigninMaid/MaidForgotPasswordScreen.dart';
import 'package:mutemaidservice/screen/housekeeper/SigninMaid/MaidSigninScreen.dart';
import 'package:mutemaidservice/screen/housekeeper/SigninMaid/PinLoginScreen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

final snackLoginPhoneFail = SnackBar(
  content: const Text('เบอร์โทรศัพท์ไม่ถูกต้อง กรุณาตรวจสอบข้อมูล'),
  backgroundColor: HexColor("#5D5FEF"),
);

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _controllerPhone = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    controller: _controllerPhone,
                    cursorColor: HexColor("#5D5FEF"),
                    textAlign: TextAlign.left,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.phone,
                          color: Colors.black,
                        ),
                        hintText: 'เบอร์โทรศัพท์',
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
                ],
              ),
            ),
            const SizedBox(height: 20),
            Container(
              child: ElevatedButton(
                onPressed: () {
                  String phone = _controllerPhone.text;
                  print("ohha");
                  FirebaseFirestore.instance
                      .collection('Housekeeper')
                      .where('PhoneNumber', isEqualTo: phone)
                      .get()
                      .then((QuerySnapshot querySnapshot) {
                    if (querySnapshot.size != 0) {
                      querySnapshot.docs.forEach((doc) {
                        if (doc['Pin'] != "") {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PinLoginScreen(
                                        phone,
                                      )));
                        } else {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MaidSigninScreen(
                                        phone,
                                      )));
                        }
                      });
                    } else {
                      ScaffoldMessenger.of(context)
                          .showSnackBar(snackLoginPhoneFail);
                    }
                  });
                },
                child: const Icon(
                  Icons.arrow_forward,
                ),
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
            SizedBox(
              height: 50,
            ),
            Column(
              children: [
                Image.asset(
                  "assets/images/forgot-password.png",
                  height: 80,
                  width: 80,
                ),
                GestureDetector(
                  child: Text(
                    'ลืมรหัสผ่าน',
                    style: TextStyle(
                        color: HexColor("#5D5FEF"),
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => MaidForgotPasswordScreen())),
                ),
              ],
            ),
            // const SizedBox(height: 40),
            // const SizedBox(height: 30),
          ]),
        ),
      ),
    );
  }
}
