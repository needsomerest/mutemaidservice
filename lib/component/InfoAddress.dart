import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hexcolor/hexcolor.dart';

class InfoAddress extends StatelessWidget {
  const InfoAddress({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500,
      width: 400,
      padding: EdgeInsets.all(20),
      margin: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: HexColor('#5D5FEF').withOpacity(0.2),
        border: Border.all(width: 1.5, color: HexColor('#5D5FEF')),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'พิชญาภรณ์ หัสเมตโต',
            style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: HexColor('#000000')),
          ),
          Text(
            'เบอร์โทรศัพท์ : (+66) 0995935451',
            style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: HexColor('#000000')),
          ),
          SizedBox(
            height: 30,
          ),
          Text(
            'รายละเอียดที่อยู่',
            style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: HexColor('#979797')),
          ),
          Flexible(
            child: Text(
              'ทาว์นโฮม / บ้านเดี่ยว\n59, ซอย ท่าข้าม 28 แขวง แสมดำ\nเขตบางขุนเทียน กรุงเทพมหานคร ประเทศไทย',
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: HexColor('#000000')),
            ),
          ),
          SizedBox(
            height: 50,
          ),
          Container(
            alignment: Alignment.bottomCenter,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20), // Image border
              child: SizedBox.fromSize(
                // size: , // Image radius
                child: Image.asset(
                  "assets/images/ex.home.jpg",
                  fit: BoxFit.cover,
                  height: 190,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
