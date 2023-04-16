import 'package:cloud_firestore/cloud_firestore.dart';

class AddressData {
  String AddressID;
  String Addressimage;
  String Type;
  String SizeRoom;
  String Address;
  String AddressDetail;
  String Province;
  String District;
  String Phonenumber;
  String Note;
  String User;
  GeoPoint point;

  AddressData(
      this.AddressID,
      this.Addressimage,
      this.Type,
      this.SizeRoom,
      this.Address,
      this.AddressDetail,
      this.Province,
      this.District,
      this.Phonenumber,
      this.Note,
      this.User,
      this.point);

  Map<String, dynamic> CreateReservationtoJson() => {
        'AddressDetail': AddressDetail,
        'AddressID': Address,
        'AddressImage': Addressimage,
        'AddressName': Address,
        'Sizeroom': SizeRoom,
        'Type': Type,
        'Point': point,
      };
}
