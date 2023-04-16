import 'package:cloud_firestore/cloud_firestore.dart';
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
import 'package:mutemaidservice/model/Data/HousekeeperData.dart';
import 'package:mutemaidservice/model/auth.dart';
import 'package:mutemaidservice/screen/housekeeper/HomeScreen/HomeMaidScreen.dart';
import 'package:mutemaidservice/screen/housekeeper/SigninMaid/MaidForgotPasswordScreen.dart';

class MaidSigninScreen extends StatefulWidget {
  @override
  _MaidSigninScreenState createState() => _MaidSigninScreenState();
}

class _MaidSigninScreenState extends State<MaidSigninScreen> {
  static const String _title = 'Sign In | Mute Maid Service';
  late Housekeeper housekeeper;
  String? errorMessage = '';
  bool isLogin = true;
  final snackLoginPasswordFail =
      SnackBar(content: const Text('Wrong password provided for that user.'));

  final snackLoginPhoneFail =
      SnackBar(content: const Text('No user found for that phone.'));

  final TextEditingController _controllerPhone = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();
  // Widget Data(){
  //   CollectionReference users = FirebaseFirestore.instance.collection('Housekeeper').where('PhoneNumber', isEqualTo: _controllerPhone.text);
  //   return FutureBuilder<DocumentSnapshot>(
  //     future: users.doc(documentId).get(),
  //     builder:
  //         (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {

  //       if (snapshot.hasError) {
  //         return Text("Something went wrong");
  //       }

  //       if (snapshot.hasData && !snapshot.data!.exists) {
  //         return Text("Document does not exist");
  //       }

  //       if (snapshot.connectionState == ConnectionState.done) {
  //         Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
  //         return Text("Full Name: ${data['full_name']} ${data['last_name']}");
  //       }

  //       return Text("loading");
  //     },
  //   );
  // }

  // Future<void> signInWithEmailAndPassword() async {
  //   try {
  //     await Auth().signInWithEmailandPassword(
  //       email: _controllerPhone.text,
  //       password: _controllerPassword.text,
  //     );
  //   } on FirebaseAuthException catch (e) {
  //     if (e.code == 'user-not-found') {
  //       print('No user found for that email.');
  //     } else if (e.code == 'wrong-password') {
  //       print('Wrong password provided for that user.');
  //     }
  //   }
  // }

  // bool value = false;
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
              // const SizedBox(height: 12),
              // Container(
              //     child: Row(
              //   children: <Widget>[
              //     Spacer(),
              //     CustomCheckBox(
              //       value: shouldCheck,
              //       shouldShowBorder: true,
              //       borderColor: HexColor("#5D5FEF"),
              //       checkedFillColor: HexColor("#5D5FEF"),
              //       borderRadius: 6,
              //       borderWidth: 1,
              //       checkBoxSize: 20,
              //       onChanged: (val) {
              //         //do your stuff here
              //         setState(() {
              //           shouldCheck = val;
              //         });
              //       },
              //     ),
              //     // Text(
              //     //   "Remember me",
              //     //   style: TextStyle(fontSize: 16, fontWeight: FontWeight.w900),
              //     // ),
              //     Spacer(),
              //   ],
              // )),
              const SizedBox(height: 20),
              Container(
                child: ElevatedButton(
                  onPressed: () {
                    // print("ohha");
                    FirebaseFirestore.instance
                        .collection('Housekeeper')
                        .where('PhoneNumber', isEqualTo: _controllerPhone.text)
                        // .where('Password', isEqualTo: _controllerPassword.text)
                        .get()
                        .then((QuerySnapshot querySnapshot) {
                      querySnapshot.docs.forEach((doc) {
                        print(doc['Password']);
                        if (doc['Password'] != null) {
                          housekeeper.HousekeeperID = doc.id;
                          print(housekeeper.HousekeeperID);
                        } else {
                          print("No");
                        }

                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => HomeMaidScreen()));
                        // print(doc["first_name"]);
                      });
                    });
                    // User? currentUser = FirebaseFirestore.instance
                    //     .collection('Housekeeper')
                    //     .where('PhoneNumber', isEqualTo: _controllerPhone.text)
                    //     .where('Password', isEqualTo: _controllerPassword.text)
                    //     .get() as User?;

                    // final Query<Map<String, dynamic>> maid = FirebaseFirestore
                    //     .instance
                    //     .collection('Housekeeper')
                    //     .where('PhoneNumber', isEqualTo: _controllerPhone.text)
                    //     .where('Password', isEqualTo: _controllerPassword.text);

                    // maid
                    //     .get()
                    //     .then((value) => Navigator.push(
                    //         context,
                    //         MaterialPageRoute(
                    //             builder: (context) => HomeMaidScreen(value["HousekeeperID"]))))
                    //     .catchError(
                    //         (error) => print("Failed to add phone: $error"));

                    // StreamBuilder(
                    //     stream: FirebaseFirestore.instance
                    //         .collection("Housekeeper")
                    //         .where('PhoneNumber', isEqualTo: _controllerPhone)
                    //         .snapshots(),
                    //     builder:
                    //         (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    //       if (!snapshot.hasData) {
                    //         return Center(
                    //           child: CircularProgressIndicator(),
                    //         );
                    //       } else {
                    //         return ListView(
                    //           scrollDirection: Axis.horizontal,
                    //           children: snapshot.data!.docs
                    //               .map((HousekeeperDocument) {
                    //             return Container(
                    //               height: 200,
                    //               width: 200,
                    //               margin: EdgeInsets.all(10),
                    //               child: HousekeeperDocument['Password'] ==
                    //                       _controllerPassword
                    //                   ? Text('COLLECT')
                    //                   : Text('FALSE!!!'),
                    //             );
                    //           }).toList(),
                    //         );
                    //       }
                    //     });
                    //signInWithEmailAndPassword();
                    /*Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomeScreen()),
                  );*/
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
              Row(
                children: [
                  Column(
                    children: [
                      Image.asset(
                        "assets/images/forgot-password.png",
                        height: 80,
                        width: 80,
                      ),
                      GestureDetector(
                        child: Text(
                          'สร้างรหัสผ่าน',
                          style: TextStyle(
                              color: HexColor("#5D5FEF"),
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                        onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) =>
                                    MaidForgotPasswordScreen())),
                      ),
                    ],
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
                          'ลืมรหัสผ่าน?',
                          style: TextStyle(
                              color: HexColor("#5D5FEF"),
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                        onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) =>
                                    MaidForgotPasswordScreen())),
                      ),
                    ],
                  ),
                ],
              ),
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
