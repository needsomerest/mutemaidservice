import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:mutemaidservice/screen/ConfirmScreen/ConfirmInfoScreen.dart';
import 'RateStar.dart';

class MaidDetail extends StatefulWidget {
  // const MaidDetail({super.key});
  final String name;
  final String img;
  final int rate;
  final int review;
  final int listen;
  final int vaccine;
  final double location;
  final String commu;
  final bool fav;
  bool booked;
  MaidDetail(
    this.name,
    this.img,
    this.rate,
    this.review,
    this.listen,
    this.vaccine,
    this.location,
    this.commu,
    this.fav,
    this.booked,
  );
  @override
  State<MaidDetail> createState() => _MaidDetailState();
}

class _MaidDetailState extends State<MaidDetail> {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 300,
        width: 400,
        margin: EdgeInsets.only(left: 10, right: 10, top: 10),
        decoration: BoxDecoration(
          // color: Colors.red,
          color: HexColor('#5D5FEF').withOpacity(0.10),
          borderRadius: BorderRadius.all(Radius.circular(30)),
        ),
        child: Column(children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                // margin: EdgeInsets.only(left: 10),
                height: 70,
                width: 70,
                margin: EdgeInsets.all(10),
                child: Image.asset(
                  widget.img,
                ),
              ),
              Container(
                height: 220,
                width: 280,
                margin: EdgeInsets.only(top: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.name,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
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
                          child: Ratestar(widget.rate),
                          width: (widget.rate * 20) + 10,
                          height: 50,
                        ),
                        Text(
                          '${widget.rate} (${widget.review} reviews)',
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 14),
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
                          'ระดับการได้ยิน ${widget.listen} ',
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 14),
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
                        'รับวัคซีนป้องกันโควิด 19 จำนวน ${widget.vaccine} เข็ม',
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 14),
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
                          'สื่อสารด้วย : ${widget.commu}',
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 14),
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
                        Text(
                          '${widget.location} กม.',
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 14),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (widget.booked == false) ...[
            Container(
              height: 50,
              width: 500,
              alignment: Alignment.center,
              margin: EdgeInsets.only(right: 20),
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
          ] else ...[
            Divider(
              color: HexColor(
                  '#DDDDDD'), //color of divider//height spacing of divider
              thickness:
                  1, //thickness of divier linespacing at the end of divider
            ),
            Icon(
              Icons.keyboard_arrow_down,
            ),
          ]
        ]));
  }
}
