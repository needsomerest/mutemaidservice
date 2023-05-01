import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:mutemaidservice/component/Stepbar.dart';
import 'package:mutemaidservice/model/Data/PaymentData.dart';
import 'package:mutemaidservice/model/Data/ReservationData.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
// import 'AddPlaceScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:intl/intl.dart';
import 'package:mutemaidservice/screen/user/ConfirmScreen/ConfirmPayment.dart';
import 'package:path/path.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class Payment extends StatefulWidget {
  ReservationData reservationData;
  PaymentData paymentdata;
  bool callby;

  Payment(
      {Key? key,
      required this.reservationData,
      required this.paymentdata,
      required this.callby})
      : super(key: key);

  @override
  State<Payment> createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  String? errorMessages = '';
  String imageurl = '';

  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  File? _photo;
  final ImagePicker _picker = ImagePicker();

  final snackBarUpPaymentFail = SnackBar(
    content: const Text('เกิดข้อผิดพลาด กรุณาตรวจสอบไฟล์รูปภาพ'),
    backgroundColor: HexColor("#5D5FEF"),
  );
  final snackBarUpPaymentDone = SnackBar(
    content: const Text('อัพโหลดหลักฐานการชำระเงินเสร็จสิ้น'),
    backgroundColor: HexColor("#5D5FEF"),
  );

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
    final destination = 'PaymentImage/$fileName';

    try {
      final ref = firebase_storage.FirebaseStorage.instance
          .ref(destination)
          .child('PaymentImage/');
      await ref.putFile(_photo!);
      imageurl = await ref.getDownloadURL();
    } catch (e) {
      print('มีข้อผิดพลาดบางอย่างเกิดขึ้น กรุราลองใหม่อีกครั้ง');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: HexColor('#5D5FEF'),
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: HexColor('#5D5FEF'),
          centerTitle: true,
          leading:
              // GestureDetector(
              //   onTap: () {
              //     Navigator.push(
              //         context, MaterialPageRoute(builder: (context) => HomeScreen()));
              //   }, child:
              Icon(
            Icons.keyboard_backspace,
            color: Colors.white,
            size: 30,
          ),
          // ),
          //  Icon(
          //     Icons.keyboard_backspace,
          //     color: Colors.white,
          //   ),
          title: Text('การชำระเงินผ่านธนาคาร',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        ),
        body: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            height: 850,
            // constraints: BoxConstraints(maxWidth: 300),
            decoration: BoxDecoration(
                color: HexColor('#FFFFFF'),
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(30),
                    topLeft: Radius.circular(30))),
            child: Column(children: [
              Container(
                width: 300.0,
                margin: EdgeInsets.only(top: 30, bottom: 30),
                child: stepbar(5),
              ),
              Container(
                height: 70,
                width: 350,
                margin: EdgeInsets.only(left: 40, right: 40),
                child: Flexible(
                  child: Text(
                    'ท่านสามารถเลือกวิธีชำระเงินได้หลายช่องทางตามความสะดวกของท่านการโอนเงินผ่านบัญชีธนาคารหรือ ATM โดยสามารถชำระเข้าบัญขีของบริษัทดังนี้',
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: HexColor('#979797')),
                  ),
                ),
              ),
              Container(
                height: 130,
                width: 250,
                padding: EdgeInsets.all(20),
                margin: EdgeInsets.all(30),
                alignment: Alignment.bottomCenter,
                decoration: BoxDecoration(
                  color: HexColor('#5D5FEF').withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  'ธนาคาร : กสิกรไทย (KBANK)\nชื่อบัญชี : บจก เน็กซ์เจนไอที\nเลขบัญชี : 045-1-60685-9',
                  style: TextStyle(
                      fontSize: 15, fontWeight: FontWeight.bold, height: 2),
                ),
              ),
              Container(
                height: 100,
                width: 350,
                margin: EdgeInsets.only(left: 40, right: 40, bottom: 30),
                child: Flexible(
                  child: Text(
                    'เมื่อท่านได้ชำระเรียบร้อยแล้ว โปรดเก็บหลักฐานการโอนเงินจากธนาคารหรือ สลิปATM เพื่อใช้ในการแจ้งการโอนเงินกับทางเรา โดยแจ้งผ่านทางแบบฟอร์มด้านล่าง',
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: HexColor('#979797')),
                  ),
                ),
              ),
              Text(
                'อัพโหลดหลักฐานการชำระเงิน',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: HexColor('#5D5FEF')),
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
                                ),
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
                margin: EdgeInsets.only(right: 20, top: 20),
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
                    widget.paymentdata.PaymentImage = imageurl.toString();
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ConfirmPayment(
                                  paid: true,
                                  reservationData: widget.reservationData,
                                  paymentdata: widget.paymentdata,
                                  callby: widget.callby,
                                )));
                  },
                ),
              )
            ]),
          ),
        ));
  }
}
