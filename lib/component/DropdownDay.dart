import 'package:flutter/material.dart';
import 'package:geocode/geocode.dart';
import 'package:intl/intl.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:mutemaidservice/model/Data/AddressData.dart';
import 'package:mutemaidservice/model/Data/HousekeeperData.dart';
import 'package:mutemaidservice/model/Data/ReservationData.dart';
import 'package:mutemaidservice/screen/BookingScreen/BookingScreen.dart';

class DropdownDay extends StatefulWidget {
  final ReservationData reservationData;
  DropdownDay({
    Key? key,
    required this.reservationData,
  }) : super(key: key);

  //const DropdownDay({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<DropdownDay> {
  TextEditingController _dateInputController = TextEditingController();

  @override
  void initState() {
    //set the initial value of text field
    super.initState();
  }

  String DateNow = DateFormat('yyyy-MM-dd').format(DateTime.now());
  @override
  Widget build(BuildContext context) {
    String DateNow = DateFormat('yyyy-MM-dd').format(DateTime.now());

    return Scaffold(
        body: Container(
            width: 200,
            padding: EdgeInsets.all(15),
            height: MediaQuery.of(context).size.width / 5.5,
            child: Row(children: [
              DecoratedBox(
                decoration: BoxDecoration(
                  color: HexColor("E6E6E6"),
                  borderRadius: BorderRadius.circular(50),
                  // boxShadow: <BoxShadow>[
                  //   BoxShadow(
                  //       color:
                  //           Color.fromRGBO(0, 0, 0, 0.57), //shadow for button
                  //       blurRadius: 5) //blur radius of shadow
                  // ]
                ),
                child: Container(
                  margin: EdgeInsets.only(left: 20),
                  width: 130,
                  height: 50,
                  // height: 70,
                  child: TextField(
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.bold),
                    controller: _dateInputController,
                    //editing controller of this TextField
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: DateNow,
                      suffixIcon: Align(
                        widthFactor: 1.0,
                        heightFactor: 1.0,
                        child: Icon(
                          Icons.keyboard_arrow_down,
                          color: HexColor('#000000'),
                        ),
                      ),
                    ),
                    readOnly: true,
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate: DateTime(2100));

                      if (pickedDate != null) {
                        print(
                            pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                        String formattedDate =
                            DateFormat('yyyy-MM-dd').format(pickedDate);
                        print(
                            formattedDate); //formatted date output using intl package =>  2021-03-16
                        setState(() {
                          _dateInputController.text = formattedDate;
                          widget.reservationData.DateTimeService =
                              _dateInputController.text;
                        });
                      } else {}
                    },
                  ),
                ),
              ),
            ])));
  }
}
