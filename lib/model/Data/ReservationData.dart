import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ReservationData {
  String BookingID;
  String DateTimeService;
  String TimeStartService;
  String TimeEndService;
  String Timeservice;

  Duration TimeDuration;

  String Package;
  String Note;

  String AddressID;
  String addressName;
  String addresstype;
  String addressDetail;
  String addressImage;
  String sizeroom;

  String AddressNote;
  String PhoneNumber;
  GeoPoint AddressPoint;

  String HousekeeperID;
  String HousekeeperFirstName;
  String HousekeeperLastName;

  String Pet;
  String UserRegion;

  String Status;
  String HousekeeperRequest;
  bool PaymentUpload;
  String Date_payment;

/*String Package;
  String Notes;
  String Vertify;
  String Status;
  String Price;
  String DatetimeService;
  String DatetimeStart;
  String DatetimeEnd;
  String HousekeeperID;
  String PaymentID;
  String PaymentPicture;
  String StatusPayment;
  String Region;
  String Sizeroom;
  String Type;*/

  ReservationData(
      this.BookingID,
      this.AddressID,
      this.DateTimeService,
      this.TimeStartService,
      this.TimeEndService,
      this.Timeservice,
      this.TimeDuration,
      this.Package,
      this.Note,
      this.addressName,
      this.addresstype,
      this.addressDetail,
      this.addressImage,
      this.HousekeeperID,
      this.HousekeeperFirstName,
      this.HousekeeperLastName,
      this.sizeroom,
      this.Pet,
      this.AddressNote,
      this.AddressPoint,
      this.PhoneNumber,
      this.UserRegion,
      this.Status,
      this.HousekeeperRequest,
      this.PaymentUpload,
      this.Date_payment);

  Map<String, dynamic> CreateReservationtoJson() => {
        'DatetimeService': DateTimeService,
        'TimeStartService': TimeStartService,
        'TimeEndService': TimeEndService,
        'TimeService': Timeservice == '2 ชม. แนะนำ' ? '2 ชม.' : Timeservice,
        'TimeDuration': TimeDuration.toString(),
        'Package': Package,
        'Note': Note,
        'Status': 'กำลังมาถึง',
        'AddressID': AddressID,
        'HousekeeperID': HousekeeperID,
        'HousekeeperRequest': 'กำลังตรวจสอบ',
        'Pet': Pet,
        'PaymentUpload': true,
        'Date_payment': DateTimeService
      };

  Map<String, dynamic> CreateAddressReservationtoJson() => {
        'AddressID': AddressID,
        'AddressName': addressName,
        'Type': addresstype,
        'AddressDetail': addressDetail,
        'AddressImage': addressImage,
        'Sizeroom': sizeroom,
        'Point': AddressPoint,
        'PhoneNumber': PhoneNumber,
      };

  // void CheckValueReservationData() {
  //   if (DateTimeService.isEmpty || DateTimeService == 'null') {
  //     DateTimeService = DateFormat('yyyy-MM-dd').format(DateTime.now());
  //     // DateTimeService = DateFormat('yyyy-MM-dd').format( DateTime.now()); //DateFormat('dd-MMMM-yy').format(DateTime.now());
  //   }
  //   if (Timeservice.isEmpty || Timeservice == 'null') {
  //     Timeservice = '2 ชม. แนะนำ';
  //   }
  //   if (TimeStartService.isEmpty || TimeStartService == 'null') {
  //     TimeStartService = '14:30';
  //   }
  //   if (Package.isEmpty || Package == 'null') {
  //     Package = 'ครั้งเดียว';
  //   }
  //   if (Note.isEmpty || Note == 'null') {
  //     Note = 'เปลี่ยนผ้าคลุมเตียงและปลอกหมอน';
  //   }
  //   if (Pet.isEmpty || Pet == 'null' || Pet == '') {
  //     Pet = 'ไม่มี';
  //   }
  // }

  void TimeServiceDuration() {
    if (Timeservice == '2 ชม.' || Timeservice == '2 ชม. แนะนำ') {
      TimeDuration = Duration(
        hours: 2,
      );
    }
    if (Timeservice == '3 ชม.') {
      TimeDuration = Duration(
        hours: 3,
      );
    }
    if (Timeservice == '4 ชม.') {
      TimeDuration = Duration(
        hours: 4,
      );
    }
    if (Timeservice == '5 ชม.') {
      TimeDuration = Duration(
        hours: 5,
      );
    }
    if (Timeservice == '6 ชม.') {
      TimeDuration = Duration(
        hours: 6,
      );
    }
    if (Timeservice == '7 ชม.') {
      TimeDuration = Duration(
        hours: 7,
      );
    }
    if (Timeservice == '8 ชม.') {
      TimeDuration = Duration(
        hours: 8,
      );
    }
  }

  void SetTimeEndService() {
    DateTime dateTime = DateFormat.Hm().parse(TimeStartService);
    TimeOfDay timeOfDay = TimeOfDay.fromDateTime(dateTime);

    DateTime startDateTime = DateTime(DateTime.now().year, DateTime.now().month,
        DateTime.now().day, timeOfDay.hour, timeOfDay.minute);

    // Add the Duration to the DateTime
    DateTime endDateTime = startDateTime.add(TimeDuration);

    // Extract the TimeOfDay from the resulting DateTime
    TimeOfDay endTime = TimeOfDay.fromDateTime(endDateTime);
    String hour =
        endTime.hour.toString() == '0' ? '00' : endTime.hour.toString();
    String minute =
        endTime.minute.toString() == '0' ? '00' : endTime.minute.toString();
    TimeEndService = hour + ":" + minute;
  }
}
