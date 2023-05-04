import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:mutemaidservice/component/VideoCard.dart';
import 'package:mutemaidservice/component/assetplayer.dart';
import 'package:mutemaidservice/model/Data/maidData.dart';
import 'package:mutemaidservice/screen/housekeeper/HomeScreen/DistanceScreen.dart';
import 'package:mutemaidservice/screen/housekeeper/HomeScreen/HomeMaidScreen.dart';

class UserManual extends StatefulWidget {
  final Maid maid;
  UserManual({Key? key, required this.maid});
  // String HousekeeperID;
  // UserManual(this.HousekeeperID);
  @override
  State<UserManual> createState() => _UserManualState();
}

class _UserManualState extends State<UserManual> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor('#5D5FEF'),
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: HexColor('#5D5FEF'),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.keyboard_backspace,
            color: Colors.white,
            size: 30,
          ),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => HomeMaidScreen(maid: widget.maid)));
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: 700,
          width: double.infinity,
          alignment: Alignment.center,
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'แนะนำวิธีการใช้แอปพลิเคชัน',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              InkWell(
                child: Container(
                  height: 300,
                  width: 700,
                  child: Stack(
                    children: <Widget>[
                      Container(
                        decoration: new BoxDecoration(color: Colors.white),
                        alignment: Alignment.center,
                        height: 250,
                        child: Image.asset("assets/images/sign.jpg",
                            // height: 200, width: 200,
                            fit: BoxFit.fill),
                      ),
                      Positioned(
                        right: 140,
                        bottom: 115,
                        child: Icon(
                          Icons.play_circle,
                          size: 100,
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => VideoPlayerScreen(
                              "https://firebasestorage.googleapis.com/v0/b/mutemaidservice-5c04b.appspot.com/o/SignLanguage%2F%E0%B8%84%E0%B8%B9%E0%B9%88%E0%B8%A1%E0%B8%B7%E0%B8%AD%E0%B8%81%E0%B8%B2%E0%B8%A3%E0%B9%83%E0%B8%8A%E0%B9%89%E0%B8%87%E0%B8%B2%E0%B8%99.mp4?alt=media&token=3305c536-900c-4c67-bca9-5e89ca2ef6a5")));
                },
              ),
              Container(
                height: 50,
                width: 100,
                // alignment: Alignment.bottomRight,
                margin: EdgeInsets.only(top: 50),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    alignment: Alignment.center,
                    backgroundColor: HexColor("#5D5FEF"),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40.0),
                    ),
                    minimumSize: Size(100, 40),
                  ),
                  child: Icon(
                    Icons.arrow_forward,
                    color: Colors.white,
                    size: 30,
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DistanceScreen(
                                  maid: widget.maid,
                                )));
                  },
                ),
              )
            ],
          ),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(40), topLeft: Radius.circular(40))),
          // ),
        ),
      ),
    );
  }
}
