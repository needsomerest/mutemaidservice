// import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:line_icons/line_icons.dart';
import 'package:mutemaidservice/component/BottomNavbar.dart';
import 'package:mutemaidservice/component/ChatAtom.dart';
import 'package:mutemaidservice/screen/housekeeper/ChatScreen/chatpage.dart';
import 'package:mutemaidservice/screen/housekeeper/ScheduleScreen/ScheduleScreen.dart';
import 'package:mutemaidservice/screen/user/ChatScreen/ChatHistory.dart';
import '../../../../component/CardPromotion.dart';
import '../../../../component/ProfileBar.dart';
import '../../../../component/PromotionCardSlide.dart';
import '../../../../model/auth.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
// import '../../../RoleScreen.dart';
import '../HomeScreen/HomeMaidScreen.dart';

class ChatMaidScreen extends StatefulWidget {
  const ChatMaidScreen({super.key});

  @override
  State<ChatMaidScreen> createState() => _ChatMaidScreenState();
}

class _ChatMaidScreenState extends State<ChatMaidScreen> {
  final User? user = Auth().currentUser;
  @override
  Widget build(BuildContext context) {
    final _uid = user?.uid;
    String uid = _uid.toString();
    int _selectedIndex = 2;
    final screens = [
      HomeMaidScreen(),
      ScheduleScreen(),
      ChatMaidScreen(),
    ];
    return Scaffold(
      backgroundColor: HexColor('#5D5FEF'),
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: HexColor('#5D5FEF'),
        centerTitle: true,
        // leading:
        //     // GestureDetector(
        //     //   onTap: () {
        //     //     Navigator.push(
        //     //         context, MaterialPageRoute(builder: (context) => HomeScreen()));
        //     //   }, child:
        //     Icon(
        //   Icons.keyboard_backspace,
        //   color: Colors.white,
        //   size: 30,
        // ),
        // ),
        //  Icon(
        //     Icons.keyboard_backspace,
        //     color: Colors.white,
        //   ),
        title: Text('ข้อความ',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          height: 900,
          // constraints: BoxConstraints(maxWidth: 300),
          decoration: BoxDecoration(
              color: HexColor('#FFFFFF'),
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(30), topLeft: Radius.circular(30))),
          child: InkWell(
            child: Column(children: [
              ChatAtom("assets/images/profilemaid.jpg", "ขวัญฤดี งามดี",
                  "กำลังจะไปถึงค่ะ"),
              ChatAtom("assets/images/profilemaid.jpg", "ขวัญฤดี งามดี",
                  "กำลังจะไปถึงค่ะ"),
              ChatAtom("assets/images/profilemaid.jpg", "ขวัญฤดี งามดี",
                  "กำลังจะไปถึงค่ะ"),
            ]),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          chatpage(uid, "ZhkVnQ10zU28sFaURHU6")));
            },
          ),
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Colors.black.withOpacity(.1),
            )
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
            child: GNav(
              rippleColor: Colors.grey[300]!,
              hoverColor: Colors.grey[100]!,
              gap: 8,
              activeColor: Colors.black,
              iconSize: 24,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              duration: Duration(milliseconds: 400),
              tabBackgroundColor: Colors.grey[100]!,
              color: Colors.black,
              tabs: [
                GButton(
                  icon: LineIcons.home,
                  text: 'หน้าหลัก',
                  iconActiveColor: HexColor('5D5FEF'),
                  textColor: HexColor('5D5FEF'),
                  backgroundColor: HexColor('5D5FEF').withOpacity(0.2),
                ),
                GButton(
                  icon: LineIcons.calendar,
                  text: 'ตารางงาน',
                  iconActiveColor: HexColor('5D5FEF'),
                  textColor: HexColor('5D5FEF'),
                  backgroundColor: HexColor('5D5FEF').withOpacity(0.2),
                ),
                GButton(
                  icon: LineIcons.rocketChat,
                  text: 'ข้อความ',
                  iconActiveColor: HexColor('5D5FEF'),
                  textColor: HexColor('5D5FEF'),
                  backgroundColor: HexColor('5D5FEF').withOpacity(0.2),
                ),
              ],
              selectedIndex: _selectedIndex,
              onTabChange: (index) {
                setState(() {
                  _selectedIndex = index;
                });
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => screens[_selectedIndex]));
              },
            ),
          ),
        ),
      ),
    );
  }
}
