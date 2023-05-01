import 'package:cloud_firestore/cloud_firestore.dart';
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
import 'package:mutemaidservice/model/Data/maidData.dart';
import 'package:mutemaidservice/screen/housekeeper/HomeScreen/HomeMaidScreen.dart';
import 'package:mutemaidservice/screen/housekeeper/SigninMaid/LoginScreen.dart';
import 'package:mutemaidservice/screen/housekeeper/SigninMaid/SetPin.dart';
import 'package:pinput/pinput.dart';

class MaidForgotPasswordScreen extends StatefulWidget {
  MaidForgotPasswordScreen();

  @override
  State<MaidForgotPasswordScreen> createState() =>
      _MaidForgotPasswordScreenState();
}

class _MaidForgotPasswordScreenState extends State<MaidForgotPasswordScreen> {
  final formKey = GlobalKey<FormState>();
  final phoneController = TextEditingController();
  final pinController = TextEditingController();
  final ansController = TextEditingController();
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
  // void dispose() {
  //   emailController.dispose();
  // }

  final snackBarSucess =
      SnackBar(content: const Text('แก้ไขรหัสผ่านเสร็จสิ้น'));

  final snackBarFail = SnackBar(
    content: const Text('Faild. Something is wrong'),
    action: SnackBarAction(
      label: 'Undo',
      onPressed: () {
        // Some code to undo the change.
      },
    ),
  );
  final snackLoginAnswerFail = SnackBar(
    content: const Text('อิโมจิยืนยันตัวตนไม่ถูกต้อง กรุณาตรวจสอบข้อมูล'),
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
  // Future updatepin({
  //   required String pin,
  // }) async {
  //   var collection = FirebaseFirestore.instance.collection('Housekeeper');
  //   var querySnapshot = await collection
  //       .where('PhoneNumber', isEqualTo: phoneController.text)
  //       .where('Answer', isEqualTo: ansController.text)
  //       .get();
  //   if (querySnapshot.size > 0) {
  //     var docSnapshot = querySnapshot.docs.first;
  //     await docSnapshot.reference.update({'Pin': pin});
  //     print('set pin success');
  //   } else {
  //     print('no matching document found');
  //   }
  // }

  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(
            "ลืมรหัสผ่าน",
            style: TextStyle(
                color: HexColor("#000000"),
                fontSize: 24,
                fontFamily: 'Kanit',
                fontWeight: FontWeight.bold),
          ),
          backgroundColor: HexColor("#FFFFFF"),
          elevation: 0,
          iconTheme: IconThemeData(color: HexColor("#5D5FEF")),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            //padding: const EdgeInsets.all(22.0),
            child: Column(children: [
              Image.asset("assets/images/maidforget-password.jpg"),
              const SizedBox(height: 30),
              TextFormField(
                controller: phoneController,
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
                      ),
                    )),
              ),
              SizedBox(
                height: 30,
              ),
              TextFormField(
                controller: ansController,
                cursorColor: HexColor("#5D5FEF"),
                textAlign: TextAlign.left,
                // keyboardType: TextInputType.,
                decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.emoji_symbols_outlined,
                      color: Colors.black,
                    ),
                    hintText: 'อิโมจิยืนยันตัวตน',
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
                      ),
                    )),
              ),
              const SizedBox(height: 30),
              // Text(
              //   "รหัสผ่านใหม่",
              //   style: TextStyle(fontSize: 20),
              // ),
              // Padding(
              //   padding: const EdgeInsets.all(30.0),
              //   child: Pinput(
              //     length: 6,
              //     defaultPinTheme: defaultPinTheme,
              //     controller: pinController,
              //     pinAnimationType: PinAnimationType.fade,
              //   ),
              // ),
              ElevatedButton(
                onPressed: () {
                  FirebaseFirestore.instance
                      .collection('Housekeeper')
                      .where('PhoneNumber', isEqualTo: phoneController.text)
                      .get()
                      .then((QuerySnapshot querySnapshot) {
                    if (querySnapshot.size != 0) {
                      querySnapshot.docs.forEach((doc) {
                        if (doc['Answer'] != ansController.text) {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(snackLoginAnswerFail);
                        } else {
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
                                  builder: (context) => SetPin(
                                        maid: maid,
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
            ]),
          ),
        ),
      );
}
