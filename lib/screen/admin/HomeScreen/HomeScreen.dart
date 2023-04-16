import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:mutemaidservice/component/ProfileBar.dart';
import 'package:mutemaidservice/model/auth.dart';
import 'package:mutemaidservice/screen/RoleScreen.dart';
import 'package:mutemaidservice/screen/admin/HomeScreen/PaymentListScreen.dart';
import 'package:mutemaidservice/screen/admin/MaidScreen/AddMaidScreen.dart';
import 'package:mutemaidservice/screen/admin/MaidScreen/MaidListScreen.dart';

class HomeAdminScreen extends StatefulWidget {
  const HomeAdminScreen({super.key});

  @override
  State<HomeAdminScreen> createState() => _HomeAdminScreenState();
}

class _HomeAdminScreenState extends State<HomeAdminScreen> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  User? get currentUser => _firebaseAuth.currentUser;
  Stream<User?> get authStateChange => _firebaseAuth.authStateChanges();
  final User? user = Auth().currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(top: 30),
            height: 150,
            decoration: BoxDecoration(
                color: HexColor("#5D5FEF"),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.only(right: 20, left: 20),
                      height: 70,
                      width: 70,
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(
                          user?.photoURL ??
                              "https://firebasestorage.googleapis.com/v0/b/mutemaidservice-5c04b.appspot.com/o/download%20(4).jpg?alt=media&token=312d915c-b0ac-4b11-880a-67610ffd06ce",
                        ),
                        radius: 220,
                      ),
                    ),
                    Container(
                      height: 30,

                      // margin: EdgeInsets.only(top: 20),
                      child: Flexible(
                        child: Text(user?.displayName ?? 'User',
                            style: TextStyle(
                              // TextStyle(fontFamily: 'Itim', fontSize: 20),
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            )),
                      ),
                    ),
                  ],
                ),
                TextButton(
                  onPressed: () {
                    FirebaseAuth.instance.signOut();
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => RoleScreen()));
                  },
                  child: Icon(
                    Icons.logout,
                    color: Colors.white,
                    size: 40,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 30,
          ),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                fixedSize: Size(350, 100),
                backgroundColor: HexColor('#EFEFFE'),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                // maximumSize:
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PaymentListScreen()));
              },
              child: Row(
                children: [
                  Icon(
                    Icons.credit_score,
                    color: HexColor("#5D5FEF"),
                    size: 50,
                  ),
                  SizedBox(width: 20),
                  Text(
                    'ตรวจสอบการชำระเงิน',
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: HexColor('#5D5FEF')),
                  )
                ],
              )),
          SizedBox(height: 20),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                fixedSize: Size(350, 100),
                backgroundColor: HexColor('#EFEFFE'),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                // maximumSize:
              ),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AddMaidScreen()));
              },
              child: Row(
                children: [
                  Icon(
                    Icons.group_add,
                    color: HexColor("#5D5FEF"),
                    size: 50,
                  ),
                  SizedBox(width: 20),
                  Text(
                    'เพิ่มแม่บ้าน',
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: HexColor('#5D5FEF')),
                  )
                ],
              )),
          SizedBox(height: 20),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                fixedSize: Size(350, 100),
                backgroundColor: HexColor('#EFEFFE'),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                // maximumSize:
              ),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MaidListScreen()));
              },
              child: Row(
                children: [
                  Icon(
                    Icons.account_box,
                    color: HexColor("#5D5FEF"),
                    size: 50,
                  ),
                  SizedBox(width: 20),
                  Text(
                    'รายชื่อแม่บ้าน',
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: HexColor('#5D5FEF')),
                  )
                ],
              )),
        ],
      )),
    );
  }
}
