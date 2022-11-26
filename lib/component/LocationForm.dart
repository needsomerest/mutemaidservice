import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:mutemaidservice/screen/PlaceScreen/AddPicturePlace.dart';
import 'FormInput.dart';

class LocationForm extends StatelessWidget {
  List<String> title = [
    "ชื่อ :",
    "ตำแหน่งที่ตั้ง :",
    "รายละเอียดที่อยู่ :",
    "จังหวัด :",
    "เขต :",
    "เบอร์โทรศัพท์ :",
    "หมายเหตุ (เพิ่มเติม) :"
  ];
  List<String> hint = [
    "เช่น คอนโดของฉัน",
    "เลือกตำแหน่งที่ตั้ง",
    "รายละเอียดที่ตั้ง ของบ้าน / คอนโด / บริษัท",
    "กรุงเทพมหานคร",
    "เลือกเขตที่อยู่",
    "กรอกเบอร์โทรศัพท์",
    "สถานที่ที่สามารถสังเกตเห็นได้ง่าย"
  ];
  @override
  Widget build(BuildContext context) => Scaffold(
        body: Container(
          height: 700,
          alignment: Alignment.center,
          margin: EdgeInsets.only(top: 20),
          decoration: BoxDecoration(
              color: HexColor('#E6E6E6'),
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(40), topLeft: Radius.circular(40))),
          child: Column(children: [
            SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 600,
              child: ListView.builder(
                  itemCount: 7,
                  // scrollDirection: Axis.horizontal,
                  itemBuilder: ((context, index) => Container(
                        height: 60,
                        width: 396,
                        margin: EdgeInsets.only(left: 20, right: 20, top: 20),
                        child: Center(
                          child: FormInput(
                            title[index],
                            hint[index],
                          ),
                        ),
                      ))),
            ),
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
                  'ยืนยัน',
                  style: TextStyle(fontSize: 16),
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => addpictureplace()));
                },
              ),
            ),
          ]),
        ),
      );
}
