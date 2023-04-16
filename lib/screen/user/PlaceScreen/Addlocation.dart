import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geocode/geocode.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:location/location.dart';
import 'package:mutemaidservice/component/DropdownArea.dart';
import 'package:mutemaidservice/component/FormInput.dart';
import 'package:mutemaidservice/component/Stepbar.dart';
import 'package:mutemaidservice/component/TextInputAddress.dart';
import 'package:mutemaidservice/model/Data/AddressData.dart';
import 'package:mutemaidservice/model/auth.dart';
import 'package:mutemaidservice/screen/user/PlaceScreen/AddPicturePlace.dart';

class Addplocation extends StatefulWidget {
  // const Addplace({super.key});
  bool edit;
  String area = 'ไม่เกิน 40 ตร.';
  bool typecondo = true;
  double latitude;
  double longitude;
  Addplocation(this.edit, this.latitude, this.longitude);
  final User? user = Auth().currentUser;
  List<String> title = [
    "ชื่อ :",
    "ตำแหน่งที่ตั้ง :",
    "รายละเอียดที่อยู่ :",
    "จังหวัด :",
    "เขต :",
    "เบอร์โทรศัพท์ :",
    "หมายเหตุ (เพิ่มเติม) :"
  ];
  List<String> hint = [
    "เช่น คอนโดของฉัน",
    "เลือกตำแหน่งที่ตั้ง",
    "รายละเอียดที่ตั้ง ของบ้าน / คอนโด / บริษัท",
    "กรุงเทพมหานคร",
    "เลือกเขตที่อยู่",
    "กรอกเบอร์โทรศัพท์",
    "สถานที่ที่สามารถสังเกตเห็นได้ง่าย"
  ];

  @override
  State<Addplocation> createState() => _AddplocationState();
}

class _AddplocationState extends State<Addplocation> {
  LocationData? currentLocation;
  String address = "";

  final newAddressData = AddressData(
    "AddressID",
    "Addressimage",
    "Type",
    'ไม่เกิน 40 ตร.',
    "Address",
    "AddressDetail",
    "Provice",
    "Region",
    "Phonenumber",
    "Note",
    "User",
    GeoPoint(0.0, 0.0),
  );

  // String _getAddress(double? lat, double? lang) {
  //   if (lat == null || lang == null) return "";
  //   GeoCode geoCode = GeoCode();
  //   Address address =
  //       geoCode.reverseGeocoding(latitude: lat, longitude: lang) as Address;
  //   // return "${first.locality}, ${first.adminArea},${first.subLocality}, ${first.subAdminArea},${first.addressLine}, ${first.featureName},${first.thoroughfare}, ${first.subThoroughfare}"
  //   return "${address.streetAddress},${address.city}, ${address.region},  ${address.countryName}";
  // }
  Future<String> _getAddress(double lat, double lang) async {
    if (lat == null || lang == null) return "";
    GeoCode geoCode = GeoCode();
    Address address =
        await geoCode.reverseGeocoding(latitude: lat, longitude: lang);
    // return "${first.locality}, ${first.adminArea},${first.subLocality}, ${first.subAdminArea},${first.addressLine}, ${first.featureName},${first.thoroughfare}, ${first.subThoroughfare}"
    return "${address.streetAddress},${address.city}, ${address.region},  ${address.countryName}";
  }

  @override
  Widget build(BuildContext context) {
    // address = _getAddress(widget.latitude, widget.longitude);
    _getAddress(widget.latitude, widget.longitude).then((value) {
      setState(() {
        // currentLocation = location;
        address = value;
        newAddressData.point = GeoPoint(0.0, 0.0);
      });
    });
    int item = 1;
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
        title: Text(
            widget.edit == false
                ? 'เพิ่มสถานที่ใช้บริการ'
                : 'แก้ไขสถานที่ของฉัน',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: widget.edit == false ? 1110 : 1060,
          width: double.infinity,
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              if (widget.edit == false) ...[
                Container(
                  width: 300.0,
                  margin: EdgeInsets.only(top: 30),
                  child: stepbar(3),
                ),
              ],
              SizedBox(height: 30),
              Text(
                'เลือกประเภทที่พักของคุณ\nเพื่อประสิทธิภาพในการประเมินราคาที่ดีที่สุด',
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              if (widget.typecondo == true) ...[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.all(20),
                      width: 130,
                      height: 130,
                      decoration: BoxDecoration(
                          color: HexColor('#FFFFFF'),
                          border: Border.all(
                              width: 2.0, color: HexColor('#5D5FEF')),
                          // border: Colors.blueAccent,
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'คอนโด/หอพัก',
                            style: TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                          Image.asset(
                            "assets/images/condo.png",
                            height: 76,
                            width: 76,
                          )
                        ],
                      ),
                    ),
                    // SizedBox(width: 20),
                    InkWell(
                        child: Container(
                          margin: EdgeInsets.all(20),
                          width: 130,
                          height: 130,
                          decoration: BoxDecoration(
                              color: HexColor('#FFFFFF'),
                              border: Border.all(color: HexColor('#BDBDBD')),
                              // border: Colors.blueAccent,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'ทาว์นโฮม/บ้านเดี่ยว',
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                              Image.asset(
                                "assets/images/home.png",
                                height: 70,
                                width: 70,
                              )
                            ],
                          ),
                        ),
                        onTap: () {
                          setState(() {
                            widget.typecondo = false;
                          });
                        })
                  ],
                ),
              ] else ...[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                        child: Container(
                          margin: EdgeInsets.all(20),
                          width: 130,
                          height: 130,
                          decoration: BoxDecoration(
                              color: HexColor('#FFFFFF'),
                              border: Border.all(color: HexColor('#BDBDBD')),
                              // border: Colors.blueAccent,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'คอนโด/หอพัก',
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                              Image.asset(
                                "assets/images/condo.png",
                                height: 76,
                                width: 76,
                              )
                            ],
                          ),
                        ),
                        onTap: () {
                          setState(() {
                            widget.typecondo = true;
                          });
                        }),
                    Container(
                      margin: EdgeInsets.all(20),
                      width: 130,
                      height: 130,
                      decoration: BoxDecoration(
                          color: HexColor('#FFFFFF'),
                          border: Border.all(
                              width: 2.0, color: HexColor('#5D5FEF')),
                          // border: Colors.blueAccent,
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'ทาว์นโฮม/บ้านเดี่ยว',
                            style: TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                          Image.asset(
                            "assets/images/home.png",
                            height: 70,
                            width: 70,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ],
              Container(
                margin: EdgeInsets.all(20),
                // alignment: Alignment.centerRight,
                width: 300,
                // color: Colors.white,
                height: 50,
                child: DropdownArea(
                  addressData: newAddressData,
                ),
              ),
              Container(
                height: 718,
                width: double.infinity,
                child: Scaffold(
                  body: Container(
                    height: 700,
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(top: 20),
                    decoration: BoxDecoration(
                        color: HexColor('#E6E6E6'),
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(40),
                            topLeft: Radius.circular(40))),
                    child: Column(children: [
                      SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: 600,
                        child: ListView.builder(
                            itemCount: 7,
                            // scrollDirection: Axis.horizontal,
                            itemBuilder: ((context, index) => Container(
                                  height: 60,
                                  width: 396,
                                  margin: EdgeInsets.only(
                                      left: 20, right: 20, top: 20),
                                  child: Center(
                                      // if(item==index)
                                      child: item == index
                                          ? Textinput(
                                              title: widget.title[index],
                                              hint: '$address',
                                              addressData: newAddressData,
                                            )
                                          : FormInput(
                                              title: widget.title[index],
                                              hint: widget.hint[index],
                                              addressData: newAddressData,
                                            )),
                                ))),
                      ),
                      Container(
                        height: 50,
                        width: 500,
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(right: 20),
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
                            'ยืนยัน',
                            style: TextStyle(fontSize: 16),
                          ),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => addpictureplace(
                                          booking: true,
                                          addressData: newAddressData,
                                        )));
                          },
                        ),
                      ),
                    ]),
                  ),
                ),
              ),
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
