import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:mutemaidservice/model/Data/maidData.dart';
import 'package:mutemaidservice/screen/housekeeper/HomeScreen/HomeMaidScreen.dart';
import 'package:mutemaidservice/screen/housekeeper/SigninMaid/MaidForgotPasswordScreen.dart';
import 'package:mutemaidservice/screen/housekeeper/SigninMaid/SetPin.dart';
import 'package:pinput/pinput.dart';

class PinLoginScreen extends StatefulWidget {
  String phone;
  PinLoginScreen(this.phone);
  // const PinLoginScreen({super.key});

  @override
  State<PinLoginScreen> createState() => _PinLoginScreenState();
}

class _PinLoginScreenState extends State<PinLoginScreen> {
  final snackLoginPasswordFail = SnackBar(
    content: const Text('รหัสผ่านไม่ถูกต้อง กรุณาตรวจสอบข้อมูล'),
    backgroundColor: HexColor("#5D5FEF"),
  );
  final snackLoginPhoneFail = SnackBar(
    content: const Text('เบอร์โทรศัพท์ไม่ถูกต้อง กรุณาตรวจสอบข้อมูล'),
    backgroundColor: HexColor("#5D5FEF"),
  );
  final maid = Maid(
    "",
    "",
    "",
    "",
  );
  final TextEditingController _pinPutController = TextEditingController();
  final defaultPinTheme = PinTheme(
    width: 56,
    height: 56,
    textStyle: TextStyle(
        fontSize: 20,
        color: Color.fromRGBO(30, 60, 87, 1),
        fontWeight: FontWeight.w600),
    decoration: BoxDecoration(
      border: Border.all(color: Colors.black),
      borderRadius: BorderRadius.circular(20),
    ),
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('เข้าสู่ระบบ'),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: 700,
          child: Column(
            children: [
              SizedBox(
                height: 50,
              ),
              Image.asset(
                "assets/images/password-entry.png",
                height: 200,
                width: 200,
              ),
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: Pinput(
                  length: 6,
                  defaultPinTheme: defaultPinTheme,
                  controller: _pinPutController,
                  pinAnimationType: PinAnimationType.fade,
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  FirebaseFirestore.instance
                      .collection('Housekeeper')
                      .where('PhoneNumber', isEqualTo: widget.phone)
                      .where('Pin', isEqualTo: _pinPutController.text.trim())
                      .get()
                      .then((QuerySnapshot querySnapshot) {
                    if (querySnapshot.size != 0) {
                      querySnapshot.docs.forEach((doc) {
                        setState(() {
                          maid.HousekeeperID = doc.id;
                          maid.FirstName = doc['FirstName'];
                          maid.LastName = doc['LastName'];
                          maid.ProfileImage = doc['profileImage'];
                        });

                        print(maid.HousekeeperID);
                        print(maid.FirstName);
                        print(maid.LastName);
                        print(maid.ProfileImage);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomeMaidScreen(
                                      maid: maid,
                                    )));
                      });
                    } else {
                      print("4");
                      ScaffoldMessenger.of(context)
                          .showSnackBar(snackLoginPasswordFail);
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
              // SizedBox(
              //   height: 50,
              // ),
              // Column(
              //   children: [
              //     Image.asset(
              //       "assets/images/forgot-password.png",
              //       height: 80,
              //       width: 80,
              //     ),
              //     GestureDetector(
              //       child: Text(
              //         'ลืมรหัสผ่าน',
              //         style: TextStyle(
              //             color: HexColor("#5D5FEF"),
              //             fontSize: 20,
              //             fontWeight: FontWeight.bold),
              //       ),
              //       onTap: () => Navigator.of(context).push(MaterialPageRoute(
              //           builder: (context) => MaidForgotPasswordScreen())),
              //     ),
              //   ],
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
