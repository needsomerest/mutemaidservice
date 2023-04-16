// import 'dart:js_util';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:line_icons/line_icons.dart';
import 'package:mutemaidservice/component/Chatside.dart';
import 'package:mutemaidservice/model/auth.dart';
import 'package:mutemaidservice/screen/user/ChatScreen/ChatScreen.dart';
import '../../../component/ChatAtom.dart';
import '../../../component/Stepbar.dart';
import '../../HomeScreen.dart';
import '../../housekeeper/ChatScreen/chatpage.dart';
import '../../housekeeper/ChatScreen/test.dart';
import '../BookingScreen/MyBooking.dart';
import '../HelpScreen/HelpScreen.dart';

class ChatHistoryScreen extends StatefulWidget {
  const ChatHistoryScreen({super.key});

  @override
  State<ChatHistoryScreen> createState() => _ChatHistoryScreenState();
}

class _ChatHistoryScreenState extends State<ChatHistoryScreen> {
  final User? user = Auth().currentUser;
  @override
  Widget build(BuildContext context) {
    final _uid = user?.uid;
    String uid = _uid.toString();
    int _selectedIndex = 2;
    final screens = [
      HomeScreen(),
      MyBooking(),
      ChatHistoryScreen(),
      HelpScreen()
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
                          // test()
                          // chatpage("ZhkVnQ10zU28sFaURHU6", uid)
                          ChatScreen(uid, "ZhkVnQ10zU28sFaURHU6")));
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
                  icon: LineIcons.book,
                  text: 'การจองของฉัน',
                  iconActiveColor: HexColor('5D5FEF'),
                  textColor: HexColor('5D5FEF'),
                  backgroundColor: HexColor('5D5FEF').withOpacity(0.2),
                ),
                GButton(
                  icon: LineIcons.rocketChat,
                  text: 'การสนทนา',
                  iconActiveColor: HexColor('5D5FEF'),
                  textColor: HexColor('5D5FEF'),
                  backgroundColor: HexColor('5D5FEF').withOpacity(0.2),
                ),
                GButton(
                  icon: LineIcons.video,
                  text: 'ช่วยเหลือ',
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
// class ChatHistory extends StatelessWidget {
//   // const ChatHistory({super.key});
//   List<bool> side_sender = [false, true, false, true, true];
//   // Chatside(this.side_sender);
//   final User? user = Auth().currentUser;
//   final fs = FirebaseFirestore.instance;
//   final _auth = FirebaseAuth.instance;
//   final TextEditingController message = new TextEditingController();
//   @override
//   Widget build(BuildContext context) {
//     final _uid = user?.uid;
//     String uid = _uid.toString();
//     int _selectedIndex = 2;
//     final screens = [
//       HomeScreen(),
//       MyBooking([3, 5]),
//       ChatHistory(),
//       HelpScreen()
//     ];
//     return Scaffold(
//       backgroundColor: HexColor('#5D5FEF'),
//       appBar: AppBar(
//         elevation: 0.0,
//         backgroundColor: HexColor('#5D5FEF'),
//         centerTitle: true,
//         // leading:
//         //     // GestureDetector(
//         //     //   onTap: () {
//         //     //     Navigator.push(
//         //     //         context, MaterialPageRoute(builder: (context) => HomeScreen()));
//         //     //   }, child:
//         //     Icon(
//         //   Icons.keyboard_backspace,
//         //   color: Colors.white,
//         //   size: 30,
//         // ),
//         // ),
//         //  Icon(
//         //     Icons.keyboard_backspace,
//         //     color: Colors.white,
//         //   ),
//         title: Text('ข้อความ',
//             style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
//       ),
//       body: SingleChildScrollView(
//         child: Container(
//           width: double.infinity,
//           height: 900,
//           // constraints: BoxConstraints(maxWidth: 300),
//           decoration: BoxDecoration(
//               color: HexColor('#FFFFFF'),
//               borderRadius: BorderRadius.only(
//                   topRight: Radius.circular(30), topLeft: Radius.circular(30))),
//           child: InkWell(
//             child: Column(children: [
//               ChatAtom("assets/images/profilemaid.jpg", "ขวัญฤดี งามดี",
//                   "กำลังจะไปถึงค่ะ"),
//               ChatAtom("assets/images/profilemaid.jpg", "ขวัญฤดี งามดี",
//                   "กำลังจะไปถึงค่ะ"),
//               ChatAtom("assets/images/profilemaid.jpg", "ขวัญฤดี งามดี",
//                   "กำลังจะไปถึงค่ะ"),
//             ]),
//             onTap: () {
//               Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                       builder: (context) =>
//                           chatpage(uid, "ZhkVnQ10zU28sFaURHU6")));
//             },
//           ),
//         ),
//       ),
//       bottomNavigationBar: Container(
//         decoration: BoxDecoration(
//           color: Colors.white,
//           boxShadow: [
//             BoxShadow(
//               blurRadius: 20,
//               color: Colors.black.withOpacity(.1),
//             )
//           ],
//         ),
//         child: SafeArea(
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
//             child: GNav(
//               rippleColor: Colors.grey[300]!,
//               hoverColor: Colors.grey[100]!,
//               gap: 8,
//               activeColor: Colors.black,
//               iconSize: 24,
//               padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
//               duration: Duration(milliseconds: 400),
//               tabBackgroundColor: Colors.grey[100]!,
//               color: Colors.black,
//               tabs: [
//                 GButton(
//                   icon: LineIcons.home,
//                   text: 'หน้าหลัก',
//                   iconActiveColor: HexColor('5D5FEF'),
//                   textColor: HexColor('5D5FEF'),
//                   backgroundColor: HexColor('5D5FEF').withOpacity(0.2),
//                 ),
//                 GButton(
//                   icon: LineIcons.book,
//                   text: 'การจองของฉัน',
//                   iconActiveColor: HexColor('5D5FEF'),
//                   textColor: HexColor('5D5FEF'),
//                   backgroundColor: HexColor('5D5FEF').withOpacity(0.2),
//                 ),
//                 GButton(
//                   icon: LineIcons.rocketChat,
//                   text: 'การสนทนา',
//                   iconActiveColor: HexColor('5D5FEF'),
//                   textColor: HexColor('5D5FEF'),
//                   backgroundColor: HexColor('5D5FEF').withOpacity(0.2),
//                 ),
//                 GButton(
//                   icon: LineIcons.video,
//                   text: 'ช่วยเหลือ',
//                   iconActiveColor: HexColor('5D5FEF'),
//                   textColor: HexColor('5D5FEF'),
//                   backgroundColor: HexColor('5D5FEF').withOpacity(0.2),
//                 ),
//               ],
//               selectedIndex: _selectedIndex,
//               onTabChange: (index) {
//                 setState(() {
//                   _selectedIndex = index;
//                 });
//                 Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                         builder: (context) => screens[_selectedIndex]));
//               },
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
