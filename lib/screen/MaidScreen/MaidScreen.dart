import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:mutemaidservice/component/MaidDetail.dart';
import 'package:mutemaidservice/component/Stepbar.dart';
import 'package:mutemaidservice/screen/MaidScreen/MaidDetailScreen.dart';

class MaidScreen extends StatefulWidget {
  // const MaidScreen({super.key});
  bool fav = false;

  MaidScreen(bool bool);

  @override
  State<MaidScreen> createState() => _MaidScreenState();
}

class _MaidScreenState extends State<MaidScreen> {
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
        title: Text('เลือกแม่บ้านด้วยตนเอง',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: 400,
          height: 1000,
          // constraints: BoxConstraints(maxWidth: 300),
          decoration: BoxDecoration(
              color: HexColor('#FFFFFF'),
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(30), topLeft: Radius.circular(30))),
          child: Container(
            child: Column(children: [
              Container(
                width: 300.0,
                margin: EdgeInsets.only(top: 30),
                child: stepbar(5),
              ),
              Container(
                margin: EdgeInsets.only(left: 30, right: 30, top: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    if (widget.fav == false) ...[
                      Text(
                        'ล่าสุด',
                        style: TextStyle(
                          color: Colors.transparent,
                          decorationColor: HexColor('#5D5FEF'),
                          decorationThickness: 4,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                          decorationStyle: TextDecorationStyle.solid,
                          fontSize: 15,
                          shadows: [
                            Shadow(
                              color: HexColor('#5D5FEF'),
                              offset: Offset(0, -10),
                            ),
                          ],
                        ),
                      ),
                      InkWell(
                          child: Text(
                            'แม่บ้านคนโปรด',
                            style: TextStyle(
                              color: widget.fav == true
                                  ? HexColor('#5D5FEF')
                                  : Colors.transparent,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              shadows: [
                                Shadow(
                                  color: HexColor('#BDBDBD'),
                                  offset: Offset(0, -10),
                                ),
                              ],
                            ),
                          ),
                          onTap: () {
                            setState(() {
                              widget.fav = true;
                            });
                          }),
                    ] else ...[
                      InkWell(
                          child: Text(
                            'ล่าสุด',
                            style: TextStyle(
                              color: Colors.transparent,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              shadows: [
                                Shadow(
                                  color: HexColor('#BDBDBD'),
                                  offset: Offset(0, -10),
                                ),
                              ],
                            ),
                          ),
                          onTap: () {
                            setState(() {
                              widget.fav = false;
                            });
                          }),
                      Text(
                        'แม่บ้านคนโปรด',
                        style: TextStyle(
                          color: Colors.transparent,
                          decorationColor: HexColor('#5D5FEF'),
                          decorationThickness: 4,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                          decorationStyle: TextDecorationStyle.solid,
                          fontSize: 15,
                          shadows: [
                            Shadow(
                              color: HexColor('#5D5FEF'),
                              offset: Offset(0, -10),
                            ),
                          ],
                        ),
                      ),
                    ]
                  ],
                ),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(width: 1.0, color: HexColor('#DDDDDD')),
                  ),
                ),
              ),
              InkWell(
                child: Container(
                  height: 300,
                  child: MaidDetail(
                      "คุณกนกพร สุขใจ",
                      "assets/images/profilemaid.png",
                      3,
                      4,
                      2,
                      3,
                      2.15,
                      "ภาษามือ, การเขียน, ล่าม",
                      widget.fav,
                      false),
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MaidDetailScreen(widget.fav)));
                },
              )
            ]),
            width: 400,
            height: 700,
            // constraints: BoxConstraints(maxWidth: 300),
            decoration: BoxDecoration(
                color: HexColor('#FFFFFF'),
                // color: HexColor('#BDBDBD').withOpacity(0.25),
                // color: Colors.red,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(30),
                    topLeft: Radius.circular(30))),
          ),
        ),
      ),
    );
  }
}
