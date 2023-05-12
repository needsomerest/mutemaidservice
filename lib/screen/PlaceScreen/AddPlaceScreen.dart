import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geocode/geocode.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:mutemaidservice/model/Data/AddressData.dart';
import '../../component/DropdownArea.dart';
import '../../component/LocationForm.dart';
import '../../component/Stepbar.dart';
import '../../model/auth.dart';

class Addplace extends StatefulWidget {
  bool edit;
  bool typecondo = true;
  String address;
  bool booking;

  Addplace(this.booking, this.edit, this.address);
  final User? user = Auth().currentUser;

  @override
  State<Addplace> createState() => _AddplaceState();
}

class _AddplaceState extends State<Addplace> {
  String? errorMessages = '';
  String imageurl = '';

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
                widget.booking == true
                    ? Container(
                        width: 300.0,
                        margin: EdgeInsets.only(top: 30),
                        child: stepbar(3),
                      )
                    : SizedBox(height: 30),
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
                          /* */
                          newAddressData.Type = 'home';
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
                          /* */
                          newAddressData.Type = 'condo';
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
                child: LocationForm(
                  booking: widget.booking == true ? true : false,
                  addressData: newAddressData,
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
