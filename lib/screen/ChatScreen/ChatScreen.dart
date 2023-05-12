import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:line_icons/line_icons.dart';
import 'package:mutemaidservice/component/ChatAtom.dart';
import 'package:mutemaidservice/screen/BookingScreen/MyBooking.dart';
import 'package:mutemaidservice/screen/ChatScreen/ChatHistory.dart';
import 'package:mutemaidservice/screen/HelpScreen/HelpScreen.dart';
import 'package:mutemaidservice/screen/HomeScreen.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  int _selectedIndex = 2;
  final screens = [HomeScreen(), MyBooking(), ChatScreen(), HelpScreen()];
  @override
  Widget build(BuildContext context) {
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
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ChatHistory()));
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
                  text: 'ภาษามือ',
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
