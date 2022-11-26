import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:mutemaidservice/component/RateStar.dart';
import 'package:mutemaidservice/component/Review.dart';
import 'package:mutemaidservice/component/StarButton.dart';
import 'package:mutemaidservice/screen/ConfirmScreen/ConfirmInfoScreen.dart';

class MaidDetailScreen extends StatefulWidget {
  // const MaidDetailScreen({super.key});
  final bool fav;
  bool star = false;
  List<String> title = [
    "ทั้งหมด",
    "5",
    "4",
    "3",
    "2",
    "1",
  ];
  MaidDetailScreen(this.fav);
  @override
  State<MaidDetailScreen> createState() => _MaidDetailScreenState();
}

class _MaidDetailScreenState extends State<MaidDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Container(
                height: 1250,
                width: 500,
                alignment: Alignment.center,
                child: Column(
                  children: [
                    Image.asset(
                      "assets/images/profilemaid.jpg",
                      height: 340,
                    ),
                    Container(
                      height: 300,
                      width: 400,
                      margin: EdgeInsets.only(left: 30, right: 30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "คุณกนกพร สุขใจ",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 25,
                                    color: HexColor('#000000')),
                              ),
                              if (widget.fav == true) ...[
                                Icon(
                                  Icons.bookmark,
                                  color: HexColor('#5D5FEF'),
                                  size: 30.0,
                                ),
                              ] else ...[
                                Icon(
                                  Icons.bookmark_border,
                                  color: HexColor('#5D5FEF'),
                                  size: 30.0,
                                ),
                              ]
                            ],
                          ),
                          Row(
                            children: [
                              Container(
                                child: Ratestar(5),
                                width: 110,
                                height: 50,
                              ),
                              Text(
                                '5.0 (10 reviews)',
                                style: TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 16),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Image.asset(
                                "assets/images/ear.png",
                                height: 23,
                                width: 23,
                              ),
                              SizedBox(width: 10),
                              Text(
                                'ระดับการได้ยิน 5 ',
                                style: TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 16),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(children: [
                            Image.asset(
                              "assets/images/syringe.png",
                              height: 23,
                              width: 23,
                            ),
                            SizedBox(width: 10),
                            Text(
                              'รับวัคซีนป้องกันโควิด 19 จำนวน 3 เข็ม',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 16),
                            ),
                          ]),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Image.asset(
                                "assets/images/texttosign.png",
                                height: 23,
                                width: 23,
                              ),
                              SizedBox(width: 10),
                              Text(
                                'สื่อสารด้วย : ภาษามือ, การเขียน, ภาพ, ล่าม',
                                style: TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 16),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Image.asset(
                                "assets/images/locationpoint.png",
                                height: 23,
                                width: 23,
                              ),
                              SizedBox(width: 10),
                              Flexible(
                                child: Text(
                                  '126 ถ. ประชาอุทิศ แขวง บางมด เขตทุ่งครุ กรุงเทพมหานคร 10140',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Image.asset(
                                "assets/images/phone-call.png",
                                height: 23,
                                width: 23,
                              ),
                              SizedBox(width: 10),
                              Text(
                                '097-245-7434',
                                style: TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 16),
                              ),
                            ],
                          ),
                        ],
                      ),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                              width: 1.0, color: HexColor('#DDDDDD')),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          left: 30, right: 30, top: 20, bottom: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Image.asset(
                                "assets/images/star.png",
                                height: 32,
                                width: 32,
                              ),
                              SizedBox(width: 10),
                              Text(
                                '5.0 (10 reviews)',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18),
                              ),
                            ],
                          ),
                          Text(
                            'เพิ่มเติม',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: HexColor('#5D5FEF')),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 60,
                      width: 400,
                      margin: EdgeInsets.only(left: 30, right: 30),
                      child: ListView.builder(
                          itemCount: 6,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: ((context, index) => Container(
                                height: 50,
                                width: 100,
                                margin: EdgeInsets.all(10),
                                child: Center(
                                  child: StarButton(
                                    widget.title[index],
                                    35,
                                    85,
                                    18,
                                    16,
                                    widget.star,
                                  ),
                                ),
                              ))),
                    ),

                    // Row(
                    //   children: [
                    //     StarButton("ทั้งหมด", 35, 85, 18, 16, true),
                    //     StarButton("5", 35, 85, 18, 16, false),
                    //     StarButton("4", 35, 85, 18, 16, false),
                    //     StarButton("3", 35, 85, 18, 16, false),
                    //     // InkWell(
                    //     //   child: StarButton(
                    //     //       "ทั้งหมด", 35, 85, 18, 16, true),
                    //     //   onTap: (() {
                    //     //     setState(() {
                    //     //       widget.star = true;
                    //     //     });
                    //     //   }),
                    //     // ),
                    //   ],
                    // ),
                    Review("assets/images/maid1.jpg", "ขวัญใจ สุดสวย", "5",
                        "ทำความสะอาดเรียบร้อยดีมากค่ะ", "15 ต.ค. 2565"),
                    Review("assets/images/maid2.jpg", "สมหญิง สุดสวย", "4",
                        "ทำความสะอาดเรียบร้อยดีมากค่ะ", "11 ต.ค. 2565"),
                    Container(
                      height: 50,
                      width: 500,
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(right: 20, top: 30),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          alignment: Alignment.center,
                          backgroundColor: HexColor("#5D5FEF"),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40.0),
                          ),
                          minimumSize: Size(100, 40),
                        ),
                        child: Text(
                          'จอง',
                          style: TextStyle(fontSize: 16),
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ConfirmInfo(false)));
                        },
                      ),
                    )
                  ],
                ))));
  }
}
