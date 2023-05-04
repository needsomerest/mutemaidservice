import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:mutemaidservice/component/InfoAtom.dart';
import 'package:mutemaidservice/model/Data/ReservationData.dart';
import 'package:intl/date_symbol_data_local.dart';

class InfoBooking extends StatelessWidget {
  ReservationData reservationData;
  InfoBooking({Key? key, required this.reservationData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // initializeDateFormatting('th');
    // DateTime dateTime =
    //     DateFormat("yyyy-MM-dd").parse(reservationData.DateTimeService);

    // reservationData.DateTimeService = DateFormat.yMMMMd('th').format(dateTime);
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
            'ผู้ให้บริการ',
            style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: HexColor('#979797')),
          ),
          InfoAtom(
              Icons.person,
              reservationData.HousekeeperFirstName +
                  "  " +
                  reservationData.HousekeeperLastName,
              "0"),
          Text(
            'เวลาทำงาน',
            style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: HexColor('#979797')),
          ),
          InfoAtom(Icons.calendar_month, "วันที่ใช้บริการ",
              reservationData.DateTimeService),
          InfoAtom(
              Icons.schedule,
              "เวลาที่ใช้บริการ",
              reservationData.TimeStartService +
                  " - " +
                  reservationData.TimeEndService),
          InfoAtom(Icons.timelapse, "ระยะเวลาที่ให้บริการ",
              reservationData.Timeservice),
          InfoAtom(Icons.repeat, "แพ็กเกจ", reservationData.Package),
          Text(
            'รายละเอียดงาน',
            style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: HexColor('#979797')),
          ),
          InfoAtom(Icons.home, "ขนาดที่พัก", reservationData.sizeroom),
          InfoAtom(Icons.pets, "สัตว์เลี้ยง", reservationData.Pet),
          Text(
            '*หมายเหตุ',
            style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: HexColor('#979797')),
          ),
          Text(
            reservationData.Note,
            style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: HexColor('#000000')),
          ),
        ],
      ),
    );
  }
}
