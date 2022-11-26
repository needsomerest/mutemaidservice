import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:mutemaidservice/screen/MenuScreen/MenuScreen.dart';
import 'package:mutemaidservice/screen/NotificationPage.dart';

class ProfileBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          elevation: 0.0,
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 100,
                decoration: BoxDecoration(
                    color: HexColor("#5D5FEF"),
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30))),
                child: Container(
                    margin: EdgeInsets.only(left: 30, bottom: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        InkWell(
                          child: Row(
                            children: [
                              Container(
                                margin: EdgeInsets.only(bottom: 20),
                                child: Image.asset(
                                  "assets/images/profile.png",
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 20),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      // margin: EdgeInsets.only(top: 30),
                                      child: Text('Good morning',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                          )),
                                    ),
                                    Container(
                                      // margin: EdgeInsets.only(top: 10),
                                      child: Text('พิชญาภรณ์ หัสเมตโต',
                                          style: TextStyle(
                                            // TextStyle(fontFamily: 'Itim', fontSize: 20),
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontWeight: FontWeight.w500,
                                          )),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ProfileScreen()));
                          },
                        ),
                        InkWell(
                          child: Container(
                            // margin: EdgeInsets.only(right: 5),
                            padding: const EdgeInsets.only(
                                left: 50, right: 10, bottom: 20),
                            child: Icon(
                              Icons.notifications_none,
                              color: Colors.white,
                              size: 35,
                            ),
                          ),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        NotificationScreen()));
                            // NotificationScreen()));
                          },
                        )
                      ],
                    )),
              ),
            ],
          ),
        ),
      );
}
