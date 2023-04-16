import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:mutemaidservice/component/SettingName.dart';
import 'package:mutemaidservice/model/auth.dart';
import 'package:mutemaidservice/screen/RoleScreen.dart';
import 'package:mutemaidservice/screen/housekeeper/MenuScreen/EditScreen.dart';
import 'package:mutemaidservice/screen/housekeeper/MenuScreen/MyMoney.dart';
import 'package:mutemaidservice/screen/housekeeper/MenuScreen/ReviewScreen.dart';
import 'package:mutemaidservice/screen/user/MenuScreen/ContactScreen.dart';
import 'package:mutemaidservice/screen/user/MenuScreen/DeleteAccountSuccess.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class ProfileMaidScreen extends StatefulWidget {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  User? get currentUser => _firebaseAuth.currentUser;
  Stream<User?> get authStateChange => _firebaseAuth.authStateChanges();
  final User? user = Auth().currentUser;
  // String HousekeeperID;
  // ProfileMaidScreen(this.HousekeeperID);

  @override
  State<ProfileMaidScreen> createState() => _ProfileMaidScreenState();
}

class _ProfileMaidScreenState extends State<ProfileMaidScreen> {
  final HousekeeperID = "9U9xNdySRx475ByRhjBw";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor('#5D5FEF'),
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: HexColor('#5D5FEF'),
        centerTitle: true,
        leading: Icon(
          Icons.keyboard_backspace,
          color: Colors.white,
          size: 30,
        ),
        title: Text('โปรไฟล์',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: 890,
          width: double.infinity,
          // alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.user?.displayName ?? 'User',
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.w500),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => EditScreen()));
                        },
                        child: Text(
                          'แก้ไขโปรไฟล์',
                          style: TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 20),
                    child: Image.asset(
                      "assets/images/profile.png",
                      width: 70,
                      height: 70,
                    ),
                  ),
                ],
              ),
              Container(
                  // margin: EdgeInsets.only(top: 30),
                  height: 800,
                  decoration: BoxDecoration(
                      color: HexColor('#FFFFFF'),
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(40),
                          topLeft: Radius.circular(40))),
                  child: Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      // mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'การตั้งค่าบัญชี',
                          style: TextStyle(
                              fontSize: 24,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.start,
                        ),
                        InkWell(
                          child: Container(
                            margin: EdgeInsets.all(10),
                            height: 50,
                            child: SettingName(
                                Icons.thumb_up_alt, "รีวิว", Colors.white),
                          ),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ReviewScreen()));
                          },
                        ),

                        // Container(
                        //   margin: EdgeInsets.all(10),
                        //   height: 50,
                        //   child:
                        //       SettingName(Icons.notifications, "การแจ้งเตือน"),
                        // ),
                        InkWell(
                          child: Container(
                            margin: EdgeInsets.all(10),
                            height: 50,
                            child: SettingName(
                                Icons.paid, "การเงินของคุณ", Colors.white),
                          ),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MyMoneyScreen()));
                          },
                        ),

                        // Container(
                        //   margin: EdgeInsets.all(10),
                        //   height: 50,
                        //   child: SettingName(
                        //       Icons.library_books, "ประวัติการใช้บริการ"),
                        // ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          'ฝ่ายสนับสนุน',
                          style: TextStyle(
                              fontSize: 24,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.start,
                        ),
                        InkWell(
                          child: Container(
                            margin: EdgeInsets.all(10),
                            height: 50,
                            child: SettingName(
                                Icons.headset_mic, "ติดต่อเรา", Colors.white),
                          ),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ContactScreen()));
                          },
                        ),
                        InkWell(
                          child: Container(
                            margin: EdgeInsets.all(10),
                            height: 50,
                            child: SettingName(
                                Icons.delete, "ลบบัญชี", Colors.white),
                          ),
                          onTap: () => _onAlertButtonPressedMaid(context),
                        ),
                        InkWell(
                            child: Container(
                              margin: EdgeInsets.all(10),
                              height: 50,
                              child: SettingName(
                                  Icons.logout, "ออกจากระบบ", Colors.white),
                              //onPressed: SignOut,
                            ),
                            onTap: () async {
                              await FirebaseAuth.instance.signOut();

                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => RoleScreen()));
                            }),
                      ],
                    ),
                  )),
            ],
          ),
          decoration: BoxDecoration(
              color: HexColor('#5D5FEF').withOpacity(0.2),
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(40), topLeft: Radius.circular(40))),
          // ),
        ),
      ),
    );
  }
}

_onAlertButtonPressed(BuildContext context) {
  final User? user = Auth().currentUser;
  Alert(
    context: context,
    type: AlertType.warning,
    title: "ลบบัญชีผู้ใช้งาน",
    desc: "หากทำการลบบัญชีผู้ใช้งาน ระบบจะทำการลบข้อมูลทุกอย่าง",
    style: AlertStyle(
      titleStyle: TextStyle(
        color: Colors.red,
        fontWeight: FontWeight.bold,
        fontSize: 20,
      ),
      descStyle: TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 16,
      ),
    ),
    buttons: [
      DialogButton(
        child: Text(
          "ลบ",
          style: TextStyle(
              color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
        ),
        onPressed: () {
          deleteData();
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => DeleteAccountSuccess()));
        },
        color: HexColor('#5D5FEF'),
        // borderRadius: BorderRadius.all(Radius.circular(2.0),
      ),
      DialogButton(
        child: Text(
          "ยกเลิก",
          style: TextStyle(color: Colors.black, fontSize: 18),
        ),
        onPressed: () => Navigator.pop(context),
        color: HexColor('#BDBDBD').withOpacity(0.2),
      )
    ],
  ).show();
}

_onAlertButtonPressedMaid(BuildContext context) {
  final User? user = Auth().currentUser;
  Alert(
    context: context,
    type: AlertType.warning,
    title: "ลบบัญชีผู้ใช้งาน",
    desc: "หากทำการลบบัญชีผู้ใช้งาน ระบบจะทำการลบข้อมูลทุกอย่าง",
    style: AlertStyle(
      titleStyle: TextStyle(
        color: Colors.red,
        fontWeight: FontWeight.bold,
        fontSize: 20,
      ),
      descStyle: TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 16,
      ),
    ),
    buttons: [
      DialogButton(
        width: 100,
        height: 70,
        color: HexColor('#1F8805').withOpacity(0.2),
        radius: BorderRadius.all(Radius.circular(10)),
        child: Icon(
          Icons.check,
          color: Colors.green,
          size: 50,
        ),
        onPressed: () {
          deleteData();
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => DeleteAccountSuccess()));
        },
        // color: HexColor('#5D5FEF'),
      ),
      DialogButton(
        width: 100,
        height: 70,
        color: HexColor('#EA001B').withOpacity(0.2),
        radius: BorderRadius.all(Radius.circular(10)),
        child: Icon(
          Icons.clear,
          color: Colors.red,
          size: 50,
        ),
        onPressed: () => Navigator.pop(context),
      )
    ],
  ).show();
}
// _onAlertButtonsPressed(context) {
//   Alert(
//     context: context,
//     type: AlertType.warning,
//     title: "RFLUTTER ALERT",
//     desc: "Flutter is more awesome with RFlutter Alert.",
//     buttons: [
//       DialogButton(
//         child: Text(
//           "FLAT",
//           style: TextStyle(color: Colors.white, fontSize: 18),
//         ),
//         onPressed: () => Navigator.pop(context),
//         color: Color.fromRGBO(0, 179, 134, 1.0),
//       ),
//       DialogButton(
//         child: Text(
//           "GRADIENT",
//           style: TextStyle(color: Colors.white, fontSize: 18),
//         ),
//         onPressed: () => Navigator.pop(context),
//         gradient: LinearGradient(colors: [
//           Color.fromRGBO(116, 116, 191, 1.0),
//           Color.fromRGBO(52, 138, 199, 1.0),
//         ]),
//       )
//     ],
//   ).show();
// }

Future deleteData() async {
  final User? user = Auth().currentUser;
  String userid = user.toString();

  try {
    user?.delete();
    await FirebaseFirestore.instance
        .collection("User")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .delete();

    print("sucess");
  } catch (e) {
    return print(e);
  }
}
