import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:mutemaidservice/component/InfoAddress.dart';
import 'package:mutemaidservice/component/InfoBooking.dart';
import 'package:mutemaidservice/component/Stepbar.dart';
import 'package:mutemaidservice/model/Data/AddressData.dart';
import 'package:mutemaidservice/model/Data/HousekeeperData.dart';
import 'package:mutemaidservice/model/Data/PaymentData.dart';
import 'package:mutemaidservice/model/Data/ReservationData.dart';
import 'package:mutemaidservice/model/auth.dart';
import 'package:mutemaidservice/screen/user/BookingScreen/CancelBookingSuccess.dart';
import 'package:mutemaidservice/screen/user/BookingScreen/MyBooking.dart';
import 'package:mutemaidservice/screen/user/ConfirmScreen/ConfirmPayment.dart';
import 'package:mutemaidservice/screen/user/MaidScreen/MaidScreen.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class ConfirmInfo extends StatefulWidget {
  final ReservationData reservationData;
  final Housekeeper housekeeper;
  final AddressData addressdata;
  bool booked;
  bool button_cancel;
  String Reservation_Day;
  int maxdistance;

  ConfirmInfo(
      {Key? key,
      required this.booked,
      required this.housekeeper,
      required this.reservationData,
      required this.button_cancel,
      required this.addressdata,
      required this.Reservation_Day,
      required this.maxdistance})
      : super(key: key);
  // const ConfirmInfo({super.key});

  @override
  State<ConfirmInfo> createState() => _ConfirmInfoState();
}

class _ConfirmInfoState extends State<ConfirmInfo> {
  final User? user = Auth().currentUser;

  @override
  Widget build(BuildContext context) {
    final _uid = user?.uid;
    String uid = _uid.toString();
    PaymentData paymentData = new PaymentData('', 'กำลังตรวจสอบ', 0.0);

    widget.reservationData.TimeServiceDuration();
    widget.reservationData.SetTimeEndService();
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
            if (widget.booked == true) {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => MyBooking()));
            } else {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MaidScreen(
                            reservationData: widget.reservationData,
                            housekeeper: widget.housekeeper,
                            Reservation_Day: widget.Reservation_Day,
                            addressData: widget.addressdata,
                            maxdistance: widget.maxdistance,
                          )));
            }
          },
        ),
        title: Text(
            widget.booked == false ? 'ยืนยันและชำระเงิน' : 'รายละเอียดการจอง',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: 500,
          height: widget.booked == false ? 1400 : 1300,
          decoration: BoxDecoration(
              color: HexColor('#FFFFFF'),
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(30), topLeft: Radius.circular(30))),
          child: Container(
            child: Column(children: [
              if (widget.booked == false) ...[
                Container(
                  width: 300.0,
                  margin: EdgeInsets.only(top: 30, bottom: 30),
                  child: stepbar(4),
                ),
                Text(
                  'รายละเอียดการจอง',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
              Container(
                alignment: Alignment.bottomLeft,
                margin: EdgeInsets.only(left: 20, top: 20),
                child: Text(
                  'ที่อยู่',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              InfoAddress(
                reservationData: widget.reservationData,
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                alignment: Alignment.bottomLeft,
                margin: EdgeInsets.only(left: 20),
                child: Text(
                  'ข้อมูลงาน',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              InfoBooking(
                reservationData: widget.reservationData,
              ),
              if (widget.booked == false) ...[
                Container(
                  height: 50,
                  width: 500,
                  alignment: Alignment.topRight,
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
                      'ถัดไป',
                      style: TextStyle(fontSize: 16),
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              /*edit here */
                              builder: (context) => ConfirmPayment(
                                    paid: false,
                                    paymentdata: paymentData,
                                    reservationData: widget.reservationData,
                                    callby: true,
                                    Reservation_Day: widget.Reservation_Day,
                                    addressdata: widget.addressdata,
                                    housekeeper: widget.housekeeper,
                                    maxdistance: widget.maxdistance,
                                  )));
                    },
                  ),
                )
              ] else if (widget.booked == true &&
                  widget.button_cancel == false) ...[
                // InkWell(
                // child:

                Container(
                  height: 50,
                  width: 500,
                  alignment: Alignment.topCenter,
                  margin: EdgeInsets.only(right: 20, top: 30),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      alignment: Alignment.center,
                      backgroundColor: HexColor("#EA001B"),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40.0),
                      ),
                      minimumSize: Size(100, 40),
                    ),
                    child: Text(
                      'ยกเลิก',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                    onPressed: () => _onAlertButtonPressed(
                        context, uid, widget.reservationData.BookingID),
                  ),
                ),
                //   onTap: () => _onAlertButtonPressed(context),
                // )
              ]
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

_onAlertButtonPressed(BuildContext context, String userid, String bookingid) {
  Alert(
    context: context,
    type: AlertType.warning,
    title: "ยกเลิกการจอง",
    desc: "หากทำการยกเลิกการจอง ระบบจะทำการยกเลิกข้อมูลทุกอย่าง",
    style: AlertStyle(
      titleStyle: TextStyle(
        color: Colors.red,
        fontWeight: FontWeight.bold,
        fontSize: 20,
      ),
      descStyle: TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 16,
      ),
    ),
    buttons: [
      DialogButton(
        child: Text(
          "ยกเลิก",
          style: TextStyle(color: Colors.black, fontSize: 18),
        ),
        onPressed: () => Navigator.pop(context),
        color: HexColor('#BDBDBD').withOpacity(0.2),
      ),
      DialogButton(
        child: Text(
          "ยืนยัน",
          style: TextStyle(
              color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
        ),
        onPressed: () {
          deletebooking(userid, bookingid);
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => CancelBookingSuccess()));
        },
        color: HexColor('#5D5FEF'),
        // borderRadius: BorderRadius.all(Radius.circular(2.0),
      ),
    ],
  ).show();
}

void deletebooking(String uid, String reservationid) async {
  await FirebaseFirestore.instance
      .collection('User')
      .doc(uid)
      .collection('Reservation')
      .doc(reservationid)
      .delete();
}
