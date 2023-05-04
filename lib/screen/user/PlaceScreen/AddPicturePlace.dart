import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:mutemaidservice/component/Stepbar.dart';
import 'package:mutemaidservice/model/Data/AddressData.dart';
import 'package:mutemaidservice/model/Data/HousekeeperData.dart';
import 'package:mutemaidservice/model/Data/ReservationData.dart';
import 'package:mutemaidservice/model/auth.dart';
import 'package:mutemaidservice/screen/user/PlaceScreen/MyplaceScreen.dart';
import 'package:mutemaidservice/screen/user/PlaceScreen/map.dart';
import 'AddPlaceScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class addpictureplace extends StatefulWidget {
  bool booking;
  bool edit;
  final AddressData addressData;

  // const LocationForm({super.key});
  addpictureplace(
      {Key? key,
      required this.booking,
      required this.addressData,
      required this.edit})
      : super(key: key);

  @override
  State<addpictureplace> createState() => _addpictureplaceState();
}

class _addpictureplaceState extends State<addpictureplace> {
  final User? user = Auth().currentUser;

  Future SetAddress(AddressData addressData) async {
    CollectionReference address = FirebaseFirestore.instance
        .collection("User")
        .doc(user!.uid)
        .collection("Address");

    DocumentReference newDocref = address.doc();
    await newDocref.set(widget.addressData.CreateReservationtoJson());
  }

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  String? errorMessages = '';
  String imageurl =
      'https://firebasestorage.googleapis.com/v0/b/mutemaidservice-5c04b.appspot.com/o/AddressImage%2Fex.home.jpg?alt=media&token=7e5b3838-8d5d-478f-8162-853fd6bd54a7';
  String _password = '';

  bool _checkupload = false;

  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  File? _photo;
  final ImagePicker _picker = ImagePicker();

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Gallery'),
                      onTap: () {
                        imgFromGallery();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      imgFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  Future imgFromGallery() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _photo = File(pickedFile.path);
        uploadFile();
      } else {
        print('ไม่พบรูปภาพที่ถูกเลือก');
      }
    });
  }

  Future imgFromCamera() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _photo = File(pickedFile.path);
        uploadFile();
      } else {
        print('ไม่พบรูปภาพที่ถูกเลือก');
      }
    });
  }

  Future uploadFile() async {
    if (_photo == null) return;
    final fileName = basename(_photo!.path);
    final destination = 'AddressImage/$fileName';

    try {
      final ref = firebase_storage.FirebaseStorage.instance
          .ref(destination)
          .child('AddressImage/');
      await ref.putFile(_photo!);
      imageurl = await ref.getDownloadURL();
      widget.addressData.Addressimage = imageurl;
    } catch (e) {
      print('มีข้อผิดพลาดบางอย่างเกิดขึ้น กรุราลองใหม่อีกครั้ง');
    }
  }

  @override
  Widget build(BuildContext context) {
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
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MapsPage(
                          booking: widget.booking,
                          addressData: widget.addressData,
                          edit: widget.edit)));
            },
          ),
          title: Text('เพิ่มสถานที่ใช้บริการ',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        ),
        body: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            height: 900,
            // constraints: BoxConstraints(maxWidth: 300),
            decoration: BoxDecoration(
                color: HexColor('#FFFFFF'),
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(30),
                    topLeft: Radius.circular(30))),
            child: Column(children: [
              widget.booking == true
                  ? Container(
                      width: 300.0,
                      margin: EdgeInsets.only(top: 30, bottom: 30),
                      child: stepbar(4))
                  : SizedBox(height: 30),
              Text(
                'อัพโหลดรูปสถานที่ของฉัน',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Container(
                width: 300,
                margin: EdgeInsets.only(top: 30, bottom: 50),
                child: Flexible(
                    child: Text(
                  'โปรดเพิ่มรูปภายนอกบ้าน/อาคารให้เห็นบริเวณหน้าบ้านอย่างชัดเจนเพื่อความสะดวกรวดเร็วและแม่นยำในการให้บริการ',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: HexColor('#979797')),
                )),
              ),
              Text(
                'ตัวอย่างรูปภาพที่ถูกต้อง',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: HexColor('#979797')),
              ),
              Image.asset(
                "assets/images/ex.home.jpg",
                height: 240,
              ),
              SizedBox(
                height: 30,
              ),
              InkWell(
                onTap: () {
                  _showPicker(context);
                },
                child: _photo != null
                    ? ClipRRect(
                        child: Image.file(
                          _photo!,
                          fit: BoxFit.fill,
                          height: 150,
                          width: 200,
                        ),
                      )
                    : DottedBorder(
                        color: HexColor('#5D5FEF'),
                        borderType: BorderType.RRect,
                        radius: Radius.circular(12),
                        padding: EdgeInsets.all(20),
                        borderPadding: EdgeInsets.all(30),
                        strokeWidth: 2.5,
                        dashPattern: [10, 10],
                        child: Container(
                          height: 150,
                          width: 200,
                          margin: EdgeInsets.only(
                              top: 20, left: 20, right: 20, bottom: 20),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            children: [
                              Icon(
                                Icons.cloud_upload,
                                size: 120,
                                color: HexColor('#5D5FEF'),
                              ),
                              Text(
                                'กดเพื่อเพิ่ม',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: HexColor('#5D5FEF')),
                              ),
                            ],
                          ),
                        ),
                      ),
              ),
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
                    'ยืนยัน',
                    style: TextStyle(fontSize: 16),
                  ),
                  onPressed: () {
                    SetAddress(widget.addressData);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => widget.booking == false
                                ? Myplace(
                                    book: false,
                                    reservationData: newReservationData,
                                    housekeeper: newHousekeeper,
                                    addressData: newAddress,
                                  )
                                : Myplace(
                                    book: true,
                                    reservationData: newReservationData,
                                    housekeeper: newHousekeeper,
                                    addressData: newAddress,
                                  )));
                  },
                ),
              )
            ]),
          ),
        ));
  }
}
// class addpictureplace extends StatelessWidget {
//   const addpictureplace({super.key});


//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         backgroundColor: HexColor('#5D5FEF'),
//         appBar: AppBar(
//           elevation: 0.0,
//           backgroundColor: HexColor('#5D5FEF'),
//           centerTitle: true,
//           leading:
//               // GestureDetector(
//               //   onTap: () {
//               //     Navigator.push(
//               //         context, MaterialPageRoute(builder: (context) => HomeScreen()));
//               //   }, child:
//               Icon(
//             Icons.keyboard_backspace,
//             color: Colors.white,
//             size: 30,
//           ),
//           // ),
//           //  Icon(
//           //     Icons.keyboard_backspace,
//           //     color: Colors.white,
//           //   ),
//           title: Text('เพิ่มสถานที่ใช้บริการ',
//               style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
//         ),
//         body: SingleChildScrollView(
//           child: Container(
//             width: double.infinity,
//             height: 900,
//             // constraints: BoxConstraints(maxWidth: 300),
//             decoration: BoxDecoration(
//                 color: HexColor('#FFFFFF'),
//                 borderRadius: BorderRadius.only(
//                     topRight: Radius.circular(30),
//                     topLeft: Radius.circular(30))),
//             child: Column(children: [
//               Container(
//                 width: 300.0,
//                 margin: EdgeInsets.only(top: 30, bottom: 30),
//                 child: stepbar(4),
//               ),
//               Text(
//                 'อัพโหลดรูปสถานที่ของฉัน',
//                 style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//               ),
//               Container(
//                 width: 300,
//                 margin: EdgeInsets.only(top: 30, bottom: 50),
//                 child: Flexible(
//                     child: Text(
//                   'โปรดเพิ่มรูปภายนอกบ้าน/อาคารให้เห็นบริเวณหน้าบ้านอย่างชัดเจนเพื่อความสะดวกรวดเร็วและแม่นยำในการให้บริการ',
//                   style: TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.bold,
//                       color: HexColor('#979797')),
//                 )),
//               ),
//               Text(
//                 'ตัวอย่างรูปภาพที่ถูกต้อง',
//                 style: TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.bold,
//                     color: HexColor('#979797')),
//               ),
//               Image.asset(
//                 "assets/images/ex.home.jpg",
//                 height: 240,
//               ),
//               SizedBox(
//                 height: 30,
//               ),
//               InkWell(
//                 child: DottedBorder(
//                   color: HexColor('#5D5FEF'),
//                   borderType: BorderType.RRect,
//                   radius: Radius.circular(12),
//                   padding: EdgeInsets.all(20),
//                   borderPadding: EdgeInsets.all(30),
//                   strokeWidth: 2.5,
//                   dashPattern: [10, 10],
//                   child: Container(
//                     height: 150,
//                     width: 200,
//                     margin: EdgeInsets.only(
//                         top: 20, left: 20, right: 20, bottom: 20),
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(20),
//                     ),
//                     child: Column(
//                       children: [
//                         Icon(
//                           Icons.cloud_upload,
//                           size: 120,
//                           color: HexColor('#5D5FEF'),
//                         ),
//                         Text(
//                           'กดเพื่อเพิ่ม',
//                           style: TextStyle(
//                               fontSize: 16,
//                               fontWeight: FontWeight.bold,
//                               color: HexColor('#5D5FEF')),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//               Container(
//                 height: 50,
//                 width: 500,
//                 alignment: Alignment.topRight,
//                 margin: EdgeInsets.only(right: 20, top: 30),
//                 child: ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                     alignment: Alignment.center,
//                     backgroundColor: HexColor("#5D5FEF"),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(40.0),
//                     ),
//                     minimumSize: Size(100, 40),
//                   ),
//                   child: Text(
//                     'ยืนยัน',
//                     style: TextStyle(fontSize: 16),
//                   ),
//                   onPressed: () {
//                     Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                             builder: (context) => BookingScreen(true)));
//                   },
//                 ),
//               )
//             ]),
//           ),
//         ));
//   }
// }
