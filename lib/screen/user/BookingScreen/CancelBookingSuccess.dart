import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:mutemaidservice/screen/HomeScreen.dart';

class CancelBookingSuccess extends StatelessWidget {
  const CancelBookingSuccess({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: HexColor('#5D5FEF'),
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: HexColor('#5D5FEF'),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            height: 700,
            // constraints: BoxConstraints(maxWidth: 300),
            decoration: BoxDecoration(
                color: HexColor('#FFFFFF'),
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(30),
                    topLeft: Radius.circular(30))),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.check_circle,
                    size: 130,
                    color: HexColor("#5D5FEF"),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'ยกเลิกการจองสำเร็จ',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    height: 50,
                    width: 100,
                    // alignment: Alignment.topCenter,
                    margin: EdgeInsets.only(top: 200),
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
                        'กลับ',
                        style: TextStyle(fontSize: 16),
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomeScreen()));
                      },
                    ),
                  )
                ]),
          ),
        ));
  }
}
