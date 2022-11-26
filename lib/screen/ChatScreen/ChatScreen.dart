import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:mutemaidservice/component/ChatAtom.dart';
import 'package:mutemaidservice/screen/ChatScreen/ChatHistory.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: HexColor('#5D5FEF'),
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: HexColor('#5D5FEF'),
          centerTitle: true,
          leading:
              // GestureDetector(
              //   onTap: () {
              //     Navigator.push(
              //         context, MaterialPageRoute(builder: (context) => HomeScreen()));
              //   }, child:
              Icon(
            Icons.keyboard_backspace,
            color: Colors.white,
            size: 30,
          ),
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
                    topRight: Radius.circular(30),
                    topLeft: Radius.circular(30))),
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
        ));
  }
}
