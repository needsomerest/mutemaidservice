import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:mutemaidservice/component/CalculateDistance.dart';
import 'package:mutemaidservice/component/Stepbar.dart';
import 'package:mutemaidservice/model/Data/AddressData.dart';
import 'package:mutemaidservice/model/Data/HousekeeperData.dart';
import 'package:mutemaidservice/model/Data/ReservationData.dart';
import 'package:mutemaidservice/screen/housekeeper/HomeScreen/JobDetailScreen.dart';
import 'package:mutemaidservice/screen/housekeeper/HomeScreen/LocationMaid.dart';
import 'package:mutemaidservice/screen/user/MaidScreen/MaidScreen.dart';
import 'package:mutemaidservice/screen/user/PlaceScreen/map.dart';

class BookingDistanceScreen extends StatefulWidget {
  final ReservationData reservationData;
  final Housekeeper housekeeper;
  final AddressData addressData;
  final String Reservation_Day;

  const BookingDistanceScreen(
      {Key? key,
      required this.reservationData,
      required this.housekeeper,
      required this.Reservation_Day,
      required this.addressData})
      : super(key: key);
  @override
  State<BookingDistanceScreen> createState() => _BookingDistanceScreenState();
}

class _BookingDistanceScreenState extends State<BookingDistanceScreen> {
  double _value = 20;
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
        title: Text('กรองระยะทาง',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: 700,
          width: double.infinity,
          alignment: Alignment.center,
          padding: EdgeInsets.all(50),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              stepbar(2),
              Image.asset(
                "assets/images/distance.png",
                height: 150,
                width: 150,
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                child: Text(
                    "โปรดกำหนดระยะทางสำหรับค้นหาผู้ให้บริการที่อยู่ในขอบเขตระยะทางที่ท่านต้องการ"),
              ),
              Container(
                height: 170,
                width: 400,
                margin: EdgeInsets.only(top: 50),
                padding: EdgeInsets.all(20),
                // color: HexColor('#BDBDBD').withOpacity(0.25),
                decoration: BoxDecoration(
                    color: HexColor('#BDBDBD').withOpacity(0.25),
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('ระยะทางสูงสุด',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500)),
                        Text('${_value.round()} กม.',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                      ],
                    ),
                    // SizedBox(height: 30),
                    Slider(
                      min: 1.0,
                      max: 100.0,
                      activeColor: HexColor('#5D5FEF'),
                      value: _value,
                      onChanged: (value) {
                        setState(() {
                          _value = value;
                        });
                      },
                    )
                  ],
                ),
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
                            builder: (context) => MaidScreen(
                                  reservationData: widget.reservationData,
                                  housekeeper: widget.housekeeper,
                                  Reservation_Day: widget.Reservation_Day,
                                  addressData: widget.addressData,
                                  distance: _value.round(),
                                )
                            // LocationMaid()
                            //LocationMaid()
                            // JobDetailScreen(
                            //     "AlK1obLuMav3f3zOIFIA", false)
                            ));
                    // MaterialPageRoute(builder: (context) => JobScreen()));
                    // MaterialPageRoute(
                    //     builder: (context) => CalculateDistance()));
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
