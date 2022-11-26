import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import '../../component/VideoCard.dart';
import '../../component/assetplayer.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});

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
        title: Text('ช่วยเหลือ',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: 500,
          height: 800,
          decoration: BoxDecoration(
              color: HexColor('#FFFFFF'),
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(30), topLeft: Radius.circular(30))),
          child: Container(
            child: Column(children: [
              Container(
                height: 60,
                width: 400,
                alignment: Alignment.center,
                margin: EdgeInsets.only(top: 50, bottom: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'ล่ามภาษามือ',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(width: 10),
                    Image.asset(
                      "assets/images/messageImage.png",
                      height: 54,
                      width: 54,
                    ),
                    // Image.asset("assets/images/messageImage.png"),
                  ],
                ),
              ),
              InkWell(
                child: Container(
                  height: 200,
                  width: 700,
                  child: VideoCard("เก็บตรงนี้"),
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => VideoPlayerScreen()));
                },
              ),
              InkWell(
                child: Container(
                  height: 200,
                  width: double.infinity,
                  child: VideoCard("กวาด"),
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => VideoPlayerScreen()));
                },
              ),
              InkWell(
                child: Container(
                  height: 200,
                  width: double.infinity,
                  child: VideoCard("เช็ด / ถู"),
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => VideoPlayerScreen()));
                },
              ),
            ]),
            width: double.infinity,
            height: 500,
            decoration: BoxDecoration(
                color: HexColor('#FFFFFF'),
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(30),
                    topLeft: Radius.circular(30))),
          ),
        ),
      ),
    );
  }
}
