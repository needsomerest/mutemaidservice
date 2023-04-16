import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:mutemaidservice/model/Data/HousekeeperData.dart';
import 'package:mutemaidservice/model/Data/ReservationData.dart';
import 'package:mutemaidservice/model/auth.dart';
import 'package:mutemaidservice/screen/admin/MaidScreen/AddMaidScreen.dart';
import 'package:mutemaidservice/screen/user/PlaceScreen/MyplaceScreen.dart';

import '../../../model/Data/AddressData.dart';

class Editplace extends StatefulWidget {
  String addressID;
  // bool select;
  Editplace(this.addressID);

  @override
  State<Editplace> createState() => _EditplaceState();
}

class _EditplaceState extends State<Editplace> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  String? errorMessages = '';
  String imageurl = '';
  String _password = '';
  final User? user = Auth().currentUser;
  late String uid = '';
  final TextEditingController _controllersAddress = TextEditingController();
  final TextEditingController _controllersAddressDetail =
      TextEditingController();
  final TextEditingController _controllersProvice = TextEditingController();
  final TextEditingController _controllersPhoneNumber = TextEditingController();
  final TextEditingController _controllersDistrict = TextEditingController();
  final TextEditingController _controllersNote = TextEditingController();

  // String selectedGender = "อื่นๆ";
  // String selectedRegion = "อื่นๆ";

  final snackBarUpdateProfileDone =
      SnackBar(content: const Text('แก้ไขที่อยู่สำเร็จ'));
  final snackBarUpdateProfileFail =
      SnackBar(content: const Text('ไม่สามารถแก้ไขที่อยู่ได้'));

  Future updateaddress({
    required String Address,
    required String AddressDetail,
    required String Provice,
    required String District,
    required String Phonenumber,
    required String Note,
  }) async {
    var collection = await FirebaseFirestore.instance
        .collection("User")
        .doc(uid)
        .collection("Address")
        .doc(widget.addressID)
        .update({
      'AddressDetail': AddressDetail,
      'Note': Note,
      'Provice': Provice,
      'Region': District,
      'PhoneNumber': Phonenumber,
      'AddressName': Address,
    }).then((result) {
      print("new User true");
    }).catchError((onError) {
      print("onError");
    });
  }

  Future<List<Map<String, dynamic>>> getDataFromFirebase() async {
    List<Map<String, dynamic>> data = [];
    final _uid = user?.uid;
    setState(() {
      uid = _uid.toString();
    });
    // String

    // Query the User collection for a document that contains the Reservation with the given ID
    DocumentSnapshot<Map<String, dynamic>> addressSnapshot =
        await FirebaseFirestore.instance
            .collection("User")
            .doc(uid)
            .collection("Address")
            .doc(widget.addressID)
            .get();
    Map<String, dynamic> UserData = addressSnapshot.data()!;
    data.add(UserData);

    print(
        'Number of User documents with Reservation ${widget.addressID}: ${addressSnapshot.data()}');

    return data;
  }

  List<Map<String, dynamic>> dataList = [];
  @override
  void initState() {
    super.initState();
    _getDataFromFirebase();
  }

  Future<void> _getDataFromFirebase() async {
    // final _uid = user?.uid;
    dataList = await getDataFromFirebase();
    setState(() {});
    print(dataList);
    // print(dataList);
  }

  final newReservationData = new ReservationData(
      "",
      "",
      DateFormat('yyyy-MM-dd').format(DateTime.now()).toString(),
      "14:30",
      "",
      "2 ชม. แนะนำ",
      Duration(
        hours: 0,
      ),
      "ครั้งเดียว",
      "เปลี่ยนผ้าคลุมเตียงและปลอกหมอน",
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      "ไม่มี",
      "",
      GeoPoint(0.0, 0.0),
      "",
      "",
      "",
      "กำลังตรวจสอบ",
      true,
      "");

  final newHousekeeper = Housekeeper("HousekeeperID", "FirstName", "LastName",
      "ProfileImage", 0, 0, 0, "CommunicationSkill", "PhoneNumber");

  final newAddress = AddressData(
      "AddressID",
      "Addressimage",
      "Type",
      "SizeRoom",
      "Address",
      "AddressDetail",
      "Province",
      "District",
      "Phonenumber",
      "Note",
      "User",
      GeoPoint(0, 0));
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
          title: Text('แก้ไขสถานที่ของฉัน',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        ),
        body: SingleChildScrollView(
            child: SingleChildScrollView(
          child: Container(
            height: 730,
            width: double.infinity,
            // alignment: Alignment.center,
            child: dataList.isEmpty
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                          // margin: EdgeInsets.only(top: 30),
                          height: 730,
                          decoration: BoxDecoration(
                              color: HexColor('#FFFFFF'),
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(40),
                                  topLeft: Radius.circular(40))),
                          child: Padding(
                            padding: EdgeInsets.all(20.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              // mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedboxHeaderForm("ชื่อสถานที่ : "),
                                TextFormField(
                                  controller: _controllersAddress,
                                  cursorColor: HexColor("#5D5FEF"),
                                  textAlign: TextAlign.left,
                                  keyboardType: TextInputType.name,
                                  decoration: InputDecoration(
                                      isDense: true, // Added this
                                      contentPadding: EdgeInsets.all(14),
                                      hintText: '${dataList[0]['AddressName']}',
                                      hintStyle: TextStyle(fontSize: 14),
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(60.0),
                                        borderSide: BorderSide(
                                          width: 0,
                                          style: BorderStyle.none,
                                          //fixedSize: MaterialStateProperty.all(const Size(350, 40)),
                                        ),
                                      ),
                                      filled: true,
                                      fillColor: HexColor("#DFDFFC"),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(60.0),
                                        borderSide: BorderSide(
                                          color: HexColor("#5D5FEF"),

                                          //fixedSize: MaterialStateProperty.all(const Size(350, 40)),
                                        ),
                                      )),
                                ),
                                SizedboxHeaderForm("รายละเอียดที่อยู่ : "),
                                TextFormField(
                                  cursorColor: HexColor("#5D5FEF"),
                                  controller: _controllersAddressDetail,
                                  textAlign: TextAlign.left,
                                  keyboardType: TextInputType.name,
                                  decoration: InputDecoration(
                                      isDense: true, // Added this
                                      contentPadding: EdgeInsets.all(14),
                                      hintText:
                                          '${dataList[0]['AddressDetail']}',
                                      hintStyle: TextStyle(fontSize: 14),
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(60.0),
                                        borderSide: BorderSide(
                                          width: 0,
                                          style: BorderStyle.none,
                                          //fixedSize: MaterialStateProperty.all(const Size(350, 40)),
                                        ),
                                      ),
                                      filled: true,
                                      fillColor: HexColor("#DFDFFC"),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(60.0),
                                        borderSide: BorderSide(
                                          color: HexColor("#5D5FEF"),

                                          //fixedSize: MaterialStateProperty.all(const Size(350, 40)),
                                        ),
                                      )),
                                ),
                                SizedboxHeaderForm("จังหวัด : "),
                                TextFormField(
                                  cursorColor: HexColor("#5D5FEF"),
                                  controller: _controllersProvice,
                                  textAlign: TextAlign.left,
                                  keyboardType: TextInputType.name,
                                  decoration: InputDecoration(
                                      isDense: true, // Added this
                                      contentPadding: EdgeInsets.all(14),
                                      hintText: '${dataList[0]['Provice']}',
                                      hintStyle: TextStyle(fontSize: 14),
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(60.0),
                                        borderSide: BorderSide(
                                          width: 0,
                                          style: BorderStyle.none,
                                          //fixedSize: MaterialStateProperty.all(const Size(350, 40)),
                                        ),
                                      ),
                                      filled: true,
                                      fillColor: HexColor("#DFDFFC"),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(60.0),
                                        borderSide: BorderSide(
                                          color: HexColor("#5D5FEF"),

                                          //fixedSize: MaterialStateProperty.all(const Size(350, 40)),
                                        ),
                                      )),
                                ),
                                SizedboxHeaderForm("เขต : "),
                                TextFormField(
                                  cursorColor: HexColor("#5D5FEF"),
                                  controller: _controllersDistrict,
                                  textAlign: TextAlign.left,
                                  keyboardType: TextInputType.name,
                                  decoration: InputDecoration(
                                      isDense: true, // Added this
                                      contentPadding: EdgeInsets.all(14),
                                      hintText: '${dataList[0]['Region']}',
                                      hintStyle: TextStyle(fontSize: 14),
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(60.0),
                                        borderSide: BorderSide(
                                          width: 0,
                                          style: BorderStyle.none,
                                          //fixedSize: MaterialStateProperty.all(const Size(350, 40)),
                                        ),
                                      ),
                                      filled: true,
                                      fillColor: HexColor("#DFDFFC"),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(60.0),
                                        borderSide: BorderSide(
                                          color: HexColor("#5D5FEF"),

                                          //fixedSize: MaterialStateProperty.all(const Size(350, 40)),
                                        ),
                                      )),
                                ),
                                SizedboxHeaderForm("หมายเลขโทรศัพท์ : "),
                                TextFormField(
                                  controller: _controllersPhoneNumber,
                                  cursorColor: HexColor("#5D5FEF"),
                                  textAlign: TextAlign.left,
                                  keyboardType: TextInputType.phone,
                                  decoration: InputDecoration(
                                      isDense: true, // Added this
                                      contentPadding: EdgeInsets.all(14),
                                      hintText: '${dataList[0]['PhoneNumber']}',
                                      hintStyle: TextStyle(fontSize: 14),
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(60.0),
                                        borderSide: BorderSide(
                                          width: 0,
                                          style: BorderStyle.none,
                                        ),
                                      ),
                                      filled: true,
                                      fillColor: HexColor("DFDFFC"),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(60.0),
                                        borderSide: BorderSide(
                                          color: HexColor("#5D5FEF"),
                                          //fixedSize: MaterialStateProperty.all(const Size(350, 40)),
                                        ),
                                      )),
                                ),
                                SizedboxHeaderForm("หมายเหตุ (เพิ่มเติม) : "),
                                TextFormField(
                                  cursorColor: HexColor("#5D5FEF"),
                                  controller: _controllersNote,
                                  textAlign: TextAlign.left,
                                  keyboardType: TextInputType.name,
                                  decoration: InputDecoration(
                                      isDense: true, // Added this
                                      contentPadding: EdgeInsets.all(14),
                                      hintText: '${dataList[0]['Note']}',
                                      hintStyle: TextStyle(fontSize: 14),
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(60.0),
                                        borderSide: BorderSide(
                                          width: 0,
                                          style: BorderStyle.none,
                                          //fixedSize: MaterialStateProperty.all(const Size(350, 40)),
                                        ),
                                      ),
                                      filled: true,
                                      fillColor: HexColor("#DFDFFC"),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(60.0),
                                        borderSide: BorderSide(
                                          color: HexColor("#5D5FEF"),

                                          //fixedSize: MaterialStateProperty.all(const Size(350, 40)),
                                        ),
                                      )),
                                ),
                                const SizedBox(height: 30),
                                Center(
                                  child: ElevatedButton(
                                    onPressed: () async {
                                      if (_controllersAddress.text.isEmpty) {
                                        _controllersAddress.text =
                                            "${dataList[0]['AddressName']}";
                                      }
                                      if (_controllersAddressDetail
                                          .text.isEmpty) {
                                        _controllersAddressDetail.text =
                                            "${dataList[0]['AddressDetail']}";
                                      }
                                      if (_controllersProvice.text.isEmpty) {
                                        _controllersProvice.text =
                                            "${dataList[0]['Provice']}";
                                      }
                                      if (_controllersDistrict.text.isEmpty) {
                                        _controllersDistrict.text =
                                            "${dataList[0]['Region']}";
                                      }
                                      if (_controllersPhoneNumber
                                          .text.isEmpty) {
                                        _controllersPhoneNumber.text =
                                            "${dataList[0]['PhoneNumber']}";
                                      }
                                      if (_controllersNote.text.isEmpty) {
                                        _controllersNote.text =
                                            "${dataList[0]['Note']}";
                                      }
                                      final Address = _controllersAddress.text;
                                      final AddressDetail =
                                          _controllersAddressDetail.text;
                                      final Provice = _controllersProvice.text;
                                      final District =
                                          _controllersDistrict.text;
                                      final Phonenumber =
                                          _controllersPhoneNumber.text;
                                      final Note = _controllersNote.text;

                                      //bool result = await userExists(phonenumber);
                                      //if (result == false) {
                                      updateaddress(
                                        Address: Address,
                                        AddressDetail: AddressDetail,
                                        Provice: Provice,
                                        District: District,
                                        Phonenumber: Phonenumber,
                                        Note: Note,
                                      );
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                              snackBarUpdateProfileDone);
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => Myplace(
                                                    book: false,
                                                    reservationData:
                                                        newReservationData,
                                                    housekeeper: newHousekeeper,
                                                    addressData: newAddress,
                                                  )));
                                    },
                                    child: const Text('ยืนยัน',
                                        style: TextStyle(fontSize: 18)),
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              HexColor("5D5FEF")),
                                      fixedSize: MaterialStateProperty.all(
                                          const Size(100, 50)),
                                      shape: MaterialStateProperty.all(
                                        RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )),
                    ],
                  ),
          ),
        )));
  }
}
