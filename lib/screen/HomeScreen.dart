// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:mutemaidservice/component/BottomNavbar.dart';
import 'package:mutemaidservice/screen/BookingScreen/+BookingScreen.dart';
import '../component/CardPromotion.dart';
import '../component/ProfileBar.dart';
import '../component/PromotionCardSlide.dart';
import '../model/auth.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  // final User? user = Auth().currentUser;

  // Future<void> SignOut() async {
  //   await Auth().signOut();
  // }

  // Widget _userUid() {
  //   return Text(user?.email ?? 'User email');
  // }
/*
  Widget _signOutBotton() {
    return ElevatedButton(
      onPressed: SignOut,
      child: const Text('Sign Out'),
    );
  }*/

  @override
  Widget build(BuildContext context) => Scaffold(
          body: SingleChildScrollView(
              child: Column(
        children: [
          Container(
            height: 200,
            child: ProfileBar(),
          ),
          Container(
            alignment: Alignment.topLeft,
            margin: EdgeInsets.only(left: 20),
            child: Text(
              'การบริการ',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.right,
            ),
          ),
          InkWell(
            child: Container(
              height: 250,
              width: 300,
              margin: EdgeInsets.all(20),
              decoration: BoxDecoration(
                  color: HexColor("#5D5FEF").withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/images/booking_1.png",
                    height: 100,
                    width: 100,
                  ),
                  Text(
                    'ทำความสะอาดบ้าน',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: HexColor('#06161C')),
                  ),
                  Text('(ตามความต้องการ)',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: HexColor('#5D5FEF'))),
                  SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: HexColor("#5D5FEF"),
                      padding: EdgeInsets.all(15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      minimumSize: Size(130, 40),
                    ),
                    child: Text(
                      'Book Now',
                      style: TextStyle(fontSize: 16),
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => BookingScreen(false)));
                    },
                  )
                ],
              ),
            ),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => BookingScreen(false)));
            },
          ),
          Container(
              alignment: Alignment.topLeft,
              margin: EdgeInsets.only(left: 20, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.star_outlined,
                        color: HexColor('5D5FEF'),
                      ),
                      Text(
                        'ใช้ดีบอกต่อ',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  // InkWell(
                  //   child: Text(
                  //     'เพิ่มเติม',
                  //     style: TextStyle(
                  //         fontSize: 16,
                  //         fontWeight: FontWeight.bold,
                  //         color: HexColor('5D5FEF')),
                  //   ),
                  //   onTap: () {
                  //     Navigator.push(
                  //         context,
                  //         MaterialPageRoute(
                  //             builder: (context) => PromotionScreen()));
                  //   },
                  // )
                ],
              )),
          Container(
            height: 230,
            child: PromotionCardSlide(),
          ),
        ],
      )));
}
