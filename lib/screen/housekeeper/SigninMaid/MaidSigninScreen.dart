import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:mutemaidservice/component/HeaderAccount.dart';
import 'package:mutemaidservice/model/Data/maidData.dart';
import 'package:mutemaidservice/screen/housekeeper/SigninMaid/SetPin.dart';
import 'package:mutemaidservice/screen/housekeeper/SigninMaid/Setemoji.dart';

class MaidSigninScreen extends StatefulWidget {
  String phone;
  MaidSigninScreen(this.phone);
  @override
  _MaidSigninScreenState createState() => _MaidSigninScreenState();
}

class _MaidSigninScreenState extends State<MaidSigninScreen> {
  static const String _title = 'Sign In | Mute Maid Service';
  // late Maid maid;
  String? errorMessage = '';
  bool isLogin = true;
  final snackLoginPasswordFail = SnackBar(
    content: const Text('รหัสผ่านไม่ถูกต้อง กรุณาตรวจสอบข้อมูล'),
    backgroundColor: HexColor("#5D5FEF"),
  );
  // final snackLoginPhoneFail = SnackBar(
  //   content: const Text('เบอร์โทรศัพท์ไม่ถูกต้อง กรุณาตรวจสอบข้อมูล'),
  //   backgroundColor: HexColor("#5D5FEF"),
  // );

  // final TextEditingController _controllerPhone = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();

  final maid = Maid(
    "",
    "",
    "",
    "",
  );
  bool _isObscure = true;
  // bool shouldCheck = false;

  // get alignment => null;

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
                    // TextFormField(
                    //   controller: _controllerPhone,
                    //   cursorColor: HexColor("#5D5FEF"),
                    //   textAlign: TextAlign.left,
                    //   keyboardType: TextInputType.phone,
                    //   decoration: InputDecoration(
                    //       prefixIcon: Icon(
                    //         Icons.phone,
                    //         color: Colors.black,
                    //       ),
                    //       hintText: 'เบอร์โทรศัพท์',
                    //       hintStyle: TextStyle(fontSize: 14),
                    //       border: OutlineInputBorder(
                    //         borderRadius: BorderRadius.circular(6.0),
                    //         borderSide: BorderSide(
                    //           width: 0,
                    //           style: BorderStyle.none,
                    //           //fixedSize: MaterialStateProperty.all(const Size(350, 40)),
                    //         ),
                    //       ),
                    //       filled: true,
                    //       fillColor: HexColor("F1F1F1"),
                    //       focusedBorder: OutlineInputBorder(
                    //         borderRadius: BorderRadius.circular(6.0),
                    //         borderSide: BorderSide(
                    //           color: HexColor("#5D5FEF"),
                    //           //fixedSize: MaterialStateProperty.all(const Size(350, 40)),
                    //         ),
                    //       )),
                    // ),
                    // SizedBox(
                    //   height: 10.0,
                    // ),
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
              const SizedBox(height: 20),
              Container(
                child: ElevatedButton(
                  onPressed: () {
                    print("ohha");
                    FirebaseFirestore.instance
                        .collection('Housekeeper')
                        .where('PhoneNumber', isEqualTo: widget.phone)
                        .get()
                        .then((QuerySnapshot querySnapshot) {
                      querySnapshot.docs.forEach((doc) {
                        print("AAA");
                        print(doc.id);
                        if (doc['Password'] != _controllerPassword.text) {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(snackLoginPasswordFail);
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
                                  builder: (context) => SetEmoji(
                                        maid,
                                      )));
                        }
                      });
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
              const SizedBox(height: 40),
              // Row(
              //   children: [
              //     // Column(
              //     //   children: [
              //     //     Image.asset(
              //     //       "assets/images/forgot-password.png",
              //     //       height: 80,
              //     //       width: 80,
              //     //     ),
              //     //     GestureDetector(
              //     //       child: Text(
              //     //         'สร้างรหัสผ่าน',
              //     //         style: TextStyle(
              //     //             color: HexColor("#5D5FEF"),
              //     //             fontSize: 20,
              //     //             fontWeight: FontWeight.bold),
              //     //       ),
              //     //       onTap: () => Navigator.of(context).push(
              //     //           MaterialPageRoute(
              //     //               builder: (context) =>
              //     //                   MaidForgotPasswordScreen())),
              //     //     ),
              //     //   ],
              //     // ),
              //     Column(
              //       children: [
              //         Image.asset(
              //           "assets/images/forgot-password.png",
              //           height: 80,
              //           width: 80,
              //         ),
              //         GestureDetector(
              //           child: Text(
              //             'ลืมรหัสผ่าน?',
              //             style: TextStyle(
              //                 color: HexColor("#5D5FEF"),
              //                 fontSize: 20,
              //                 fontWeight: FontWeight.bold),
              //           ),
              //           onTap: () => Navigator.of(context).push(
              //               MaterialPageRoute(
              //                   builder: (context) =>
              //                       MaidForgotPasswordScreen())),
              //         ),
              //       ],
              //     ),
              //   ],
              // ),
              const SizedBox(height: 30),
            ]),
          ),
        ),
      );
}

// class BottomSignin extends StatelessWidget {
//   String FirstTitle;
//   String FistTitleColor;
//   String SecondTitle;
//   String SecondTitleColor;

//   BottomSignin(this.FirstTitle, this.FistTitleColor, this.SecondTitle,
//       this.SecondTitleColor);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: RichText(
//         text: TextSpan(children: [
//           TextSpan(
//             text: FirstTitle,
//             style: TextStyle(
//                 color: HexColor(FistTitleColor),
//                 fontSize: 16,
//                 fontWeight: FontWeight.bold),
//           ),
//           TextSpan(
//               text: SecondTitle,
//               style: TextStyle(
//                   color: HexColor(SecondTitleColor),
//                   fontSize: 16,
//                   fontWeight: FontWeight.bold),
//               recognizer: TapGestureRecognizer()
//                 ..onTap = () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(builder: (context) => SignupScreen()),
//                   );
//                 }),
//         ]),
//       ),
//     );
//   }
// }
