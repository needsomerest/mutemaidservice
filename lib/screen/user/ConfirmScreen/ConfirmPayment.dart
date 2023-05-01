import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:mutemaidservice/component/InfoPrice.dart';
import 'package:mutemaidservice/component/Stepbar.dart';
import 'package:mutemaidservice/model/Data/PaymentData.dart';
import 'package:mutemaidservice/model/Data/ReservationData.dart';
import 'package:mutemaidservice/screen/user/BookingScreen/Success.dart';
import 'package:mutemaidservice/screen/user/ConfirmScreen/Payment.dart';

class ConfirmPayment extends StatefulWidget {
  bool paid;
  ReservationData reservationData;
  PaymentData paymentdata;
  bool callby;
  ConfirmPayment({
    Key? key,
    required this.paymentdata,
    required this.paid,
    required this.reservationData,
    required this.callby,
  }) : super(key: key);

  @override
  State<ConfirmPayment> createState() => _ConfirmPaymentState();
}

final snackPaymentFail = SnackBar(
  content: const Text('กรุณาอัพโหลดหลักฐานการชำระเงิน'),
  backgroundColor: HexColor("#5D5FEF"),
);

class _ConfirmPaymentState extends State<ConfirmPayment> {
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
        title: Text('ยืนยันและชำระเงิน',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: 500,
          height: 720,
          decoration: BoxDecoration(
              color: HexColor('#FFFFFF'),
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(30), topLeft: Radius.circular(30))),
          child: Container(
            child: Column(children: [
              Container(
                width: 300.0,
                margin: EdgeInsets.only(top: 30, bottom: 30),
                child: stepbar(5),
              ),
              Text(
                'รายละเอียดการจอง',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Container(
                alignment: Alignment.bottomLeft,
                margin: EdgeInsets.only(left: 20, top: 20),
                child: Text(
                  'รายละเอียดการชำระเงิน',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              InfoPrice(
                  widget.reservationData.sizeroom,
                  widget.reservationData.Package,
                  widget.reservationData.Timeservice,
                  widget.paymentdata),
              Container(
                alignment: Alignment.bottomLeft,
                margin: EdgeInsets.only(left: 20, top: 20),
                child: Text(
                  'หลักฐานการชำระเงิน',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              InkWell(
                child: Container(
                  height: 28,
                  width: 380,
                  decoration: BoxDecoration(
                    color: HexColor('#E6E6E6'),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  margin: EdgeInsets.all(20),
                  child: DottedBorder(
                    color: widget.paid == false
                        ? HexColor('#5D5FEF')
                        : HexColor('#1F8805'),
                    borderType: BorderType.RRect,
                    radius: Radius.circular(50),
                    padding: EdgeInsets.all(4),
                    strokeWidth: 2.5,
                    dashPattern: [5, 5],
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        widget.paid == false
                            ? Icon(
                                Icons.add_circle,
                                color: HexColor('#5D5FEF'),
                              )
                            : Icon(
                                Icons.check_circle,
                                color: HexColor('#1F8805'),
                              ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'การชำระเงินผ่านธนาคาร',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: HexColor('#979797')),
                        ),
                      ],
                    ),
                  ),
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Payment(
                                reservationData: widget.reservationData,
                                paymentdata: widget.paymentdata,
                                callby: widget.callby,
                              )));
                },
              ),
              Container(
                height: 50,
                width: 500,
                alignment: Alignment.topCenter,
                margin: EdgeInsets.only(right: 20, top: 10),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    alignment: Alignment.center,
                    backgroundColor: HexColor("#5D5FEF"),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40.0),
                    ),
                    // minimumSize: Size(100, 40),
                  ),
                  child: Text(
                    'ยืนยัน',
                    style: TextStyle(fontSize: 16),
                  ),
                  onPressed: () {
                    if (widget.paymentdata.PaymentImage == '') {
                      ScaffoldMessenger.of(context)
                          .showSnackBar(snackPaymentFail);
                    } else {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Success(
                                    paymentData: widget.paymentdata,
                                    reservationData: widget.reservationData,
                                    callby: widget.callby,
                                  )));
                    }
                  },
                ),
              )
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
