// import 'dart:js_util';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:mutemaidservice/component/Chatside.dart';
import '../../component/Stepbar.dart';

class ChatHistory extends StatelessWidget {
  // const ChatHistory({super.key});
  List<bool> side_sender = [false, true, false, true, true];
  // Chatside(this.side_sender);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
        width: double.infinity,
        height: 800,
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 50, left: 20, right: 20),
              child: Row(
                children: [
                  Icon(
                    Icons.keyboard_backspace,
                    color: Colors.black,
                    size: 30,
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 15, right: 10, left: 20),
                    height: 43,
                    width: 43,
                    child: CircleAvatar(
                      backgroundImage: AssetImage(
                        "assets/images/profilemaid.jpg",
                      ),
                      radius: 220,
                    ),
                  ),
                  Text('ขวัญฤดี งามดี',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: Colors.black)),
                ],
              ),
            ),
            Divider(
              height: 2,
              thickness: 2,
              color: HexColor('#DDDDDD'),
            ),
            SizedBox(
              height: 550,
              child: ListView.builder(
                  itemCount: side_sender.length,
                  // scrollDirection: Axis.horizontal,
                  itemBuilder: ((context, index) => Container(
                        // height: 200,
                        // width: 200,
                        margin: EdgeInsets.all(10),
                        child: Center(
                          child: Chatside(side_sender[index]),
                        ),
                      ))),
            ),
            Container(
              height: 110,
              padding:
                  EdgeInsets.only(top: 20, bottom: 20, right: 20, left: 80),
              margin: EdgeInsets.only(right: 10, left: 10),
              decoration: BoxDecoration(
                  // color: HexColor('#BDBDBD'),
                  color: HexColor('#BDBDBD').withOpacity(0.25),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(width: 2)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                      child: Text(
                    'ผู้ใช้บริการสามารถส่งข้อความ\nยาวไม่เกิน 200 ตัวอักษร',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: HexColor('#979797')
                        // color: HexColor('#5D5FEF').withOpacity(0.5)
                        ),
                    textAlign: TextAlign.center,
                  )),
                  Icon(
                    Icons.send,
                    color: HexColor('#5D5FEF'),
                    size: 28,
                  ),
                ],
              ),
            ),
          ],
        ),
        // constraints: BoxConstraints(maxWidth: 300),
      ),
    ));
  }
}
