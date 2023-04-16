import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:mutemaidservice/screen/admin/HomeScreen/HomeScreen.dart';
import 'package:mutemaidservice/screen/admin/HomeScreen/PaymentListScreen.dart';
import 'package:mutemaidservice/screen/admin/HomeScreen/SuccessPayment.dart';
import 'dart:io';
import 'package:path/path.dart';

class ConfirmPaymentScreen extends StatefulWidget {
  List<Map<String, dynamic>> dataList;
  ConfirmPaymentScreen(this.dataList);
  // const ConfirmPaymentScreen({super.key});
  // List<Map<String, dynamic>> dataList;

  // String Reservid;
  // String Housekeeperid;
  // ConfirmPaymentScreen(this.Reservid, this.Housekeeperid);

  @override
  State<ConfirmPaymentScreen> createState() => _ConfirmPaymentScreenState();
}

class _ConfirmPaymentScreenState extends State<ConfirmPaymentScreen> {
  late String Paymentid;
  Future<void> updateMaid({
    required String paymentimage,
    required String status,
  }) async {
    try {
      final docMaid = await FirebaseFirestore.instance
          .collection('User')
          .doc(widget.dataList[0]['UserID'])
          .collection('Reservation')
          .doc(widget.dataList[2]['ReservationId'])
          .collection('Payment')
          .doc(widget.dataList[2]['paymentId'])
          .update({
        'PaymentStatus': status,
        'PaymentMaidImage': paymentimage,
      });
      print("Update User success");
    } catch (e) {
      print("Error updating User: $e");
    }
  }

  Future<void> addHistoryMoney({
    required String bookingid,
    required int money,
    required int income,
    required DateTime time,
  }) async {
    try {
      final docMoney = await FirebaseFirestore.instance
          .collection('Housekeeper')
          .doc(widget.dataList[1]['HousekeeperID'])
          .collection('MoneyHistory')
          .add({
        'BookingNo': bookingid,
        'Money': money,
        'Income': income,
        'Time': time
      });
      print("Update User success");
    } catch (e) {
      print("Error updating User: $e");
    }
  }

  Future<void> updateMoney({
    required int money,
  }) async {
    try {
      final docMoney = await FirebaseFirestore.instance
          .collection('Housekeeper')
          .doc(widget.dataList[1]['HousekeeperID'])
          .update({
        'Money': money,
      });
      print("Update User success");
    } catch (e) {
      print("Error updating User: $e");
    }
  }

  Future<List<Map<String, dynamic>>> getDataFromFirebase() async {
    List<Map<String, dynamic>> data = [];

    DocumentSnapshot<Map<String, dynamic>> maidSnapshot =
        await FirebaseFirestore.instance
            .collection('Housekeeper')
            .doc(widget.dataList[1]['HousekeeperID'])
            .get();
    Map<String, dynamic> MaidData = maidSnapshot.data()!;
    data.add(MaidData);

    print(
        'Number of User documents with Reservation ${widget.dataList[1]['HousekeeperID']} : ${maidSnapshot.data()}');

    return data;
  }

  // Future<List<Map<String, dynamic>>> getDataFromFirebase() async {
  //   List<Map<String, dynamic>> data = [];

  //   // Query the User collection for a document that contains the Reservation with the given ID
  //   DocumentSnapshot<Map<String, dynamic>> userSnapshot =
  //       await FirebaseFirestore.instance
  //           .collection('User')
  //           .doc('EjrH3vIPBAdtuMBBTpTXmzb0Pil2')
  //           .get();
  //   Map<String, dynamic> UserData = userSnapshot.data()!;
  //   data.add(UserData);

  //   print(
  //       'Number of User documents with Reservation ${widget.Reservid}: ${userSnapshot.data()}');

  //   DocumentSnapshot<Map<String, dynamic>> reservationSnapshot =
  //       await userSnapshot.reference
  //           .collection('Reservation')
  //           .doc(widget.Reservid)
  //           .get();

  //   Map<String, dynamic> reservationData = reservationSnapshot.data()!;
  //   data.add(reservationData);

  //   print(
  //       'Number of Reservation documents with ID ${widget.Reservid}: ${reservationSnapshot.data}');

  //   // Get the Payment subcollection for this Reservation document
  //   QuerySnapshot<Map<String, dynamic>> paymentSnapshot =
  //       await reservationSnapshot.reference.collection('Payment').get();

  //   print(
  //       'Number of Payment documents with PaymentStatus=true in Reservation document ${reservationSnapshot.id}: ${paymentSnapshot.size}');

  //   for (QueryDocumentSnapshot<Map<String, dynamic>> paymentDoc
  //       in paymentSnapshot.docs) {
  //     Map<String, dynamic> docData = paymentDoc.data();
  //     docData['ReservationId'] = reservationSnapshot.id;
  //     Paymentid = paymentDoc.id;
  //     data.add(docData);
  //   }

  //   DocumentSnapshot<Map<String, dynamic>> maidSnapshot =
  //       await FirebaseFirestore.instance
  //           .collection('Housekeeper')
  //           .doc(widget.Housekeeperid)
  //           .get();
  //   Map<String, dynamic> MaidData = maidSnapshot.data()!;
  //   data.add(MaidData);

  //   print(
  //       'Number of User documents with Reservation ${widget.Housekeeperid} : ${maidSnapshot.data()}');

  //   return data;
  // }

  late int price;
  List<Map<String, dynamic>> datamaidList = [];

  @override
  void initState() {
    super.initState();
    _getDataFromFirebase();
  }

  Future<void> _getDataFromFirebase() async {
    datamaidList = await getDataFromFirebase();
    setState(() {
      // price = dataList[0]['Money'] +
      //     (dataList[2]['PaymentPrice'] * 70 / 100).round();
    });
    print(widget.dataList);
    print(datamaidList);
    // print(dataList);
  }

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  String? errorMessages = '';
  String imageurl = '';
  String _password = '';
  String _uid = '';

  bool _checkupload = false;

  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  File? _photo;
  final ImagePicker _picker = ImagePicker();

  final snackBarUpPaymentFail =
      SnackBar(content: const Text('Image upload error. Please try again.'));
  final snackBarUpPaymentDone =
      SnackBar(content: const Text('Image uploaded successfully.'));
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
        print('No image selected.');
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
        print('No image selected.');
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
      print('error occured');
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
          leading: Icon(
            Icons.keyboard_backspace,
            color: Colors.white,
            size: 30,
          ),
          title: Text('รายละเอียดการชำระเงิน',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight
                      .bold)), //"${currentLocation.latitude} ${currentLocation.longitude}"
        ),
        body: SingleChildScrollView(
          child: Container(
            height:
                900, //dataList[2]['PaymentStatus'] == "กำลังตรวจสอบ" ? 700 :
            width: double.infinity,
            alignment: Alignment.center,
            padding: EdgeInsets.all(20),
            child: datamaidList.isNotEmpty
                ? Container(
                    height: 800,
                    width: 395,
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: HexColor('#EFEFFE'),
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                  'หมายเลขการจอง : ${widget.dataList[2]['ReservationId']}',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                  textAlign: TextAlign.left),
                              SizedBox(height: 10),
                              Text(
                                  'ชื่อแม่บ้าน : ${datamaidList[0]['FirstName']} ${datamaidList[0]['LastName']}',
                                  style: TextStyle(fontSize: 16),
                                  textAlign: TextAlign.left),
                              SizedBox(height: 5),
                              Text(
                                  'เบอร์โทรศัพท์ : ${datamaidList[0]['PhoneNumber']}',
                                  style: TextStyle(fontSize: 16),
                                  textAlign: TextAlign.left),
                              SizedBox(height: 5),
                              Text('ธนาคาร : ${datamaidList[0]['BankName']}',
                                  style: TextStyle(fontSize: 16),
                                  textAlign: TextAlign.left),
                              SizedBox(height: 5),
                              Text('เลขบัญชี : ${datamaidList[0]['BankID']}',
                                  style: TextStyle(fontSize: 16),
                                  textAlign: TextAlign.left),
                              SizedBox(height: 5),
                              Text(
                                  'ค่าจ้าง : ${(widget.dataList[2]['PaymentPrice'] * 70 / 100).round()} บาท',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.red),
                                  textAlign: TextAlign.left),
                              SizedBox(
                                height: 40,
                              ),
                            ]),
                        if (widget.dataList[2]['PaymentStatus'] ==
                            "กำลังตรวจสอบ") ...[
                          Text('อัปโหลดหลักฐานการชำระเงิน',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: HexColor('#5D5FEF'))),
                          SizedBox(
                            height: 15,
                          ),
                          InkWell(
                            onTap: () {
                              _showPicker(context);
                            },
                            child: _photo != null
                                ? ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: Image.file(
                                      _photo!,
                                      fit: BoxFit.fill,
                                      height: 400,
                                      width: 300,
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
                                          top: 20,
                                          left: 20,
                                          right: 20,
                                          bottom: 20),
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
                        ] else ...[
                          Text('หลักฐานการชำระเงิน',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: HexColor('#5D5FEF'))),
                          SizedBox(
                            height: 15,
                          ),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image(
                              width: 300,
                              height: 400,
                              image: NetworkImage(
                                  widget.dataList[2]['PaymentMaidImage']),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ],
                        Container(
                          height: 50,
                          width: 150,
                          margin: EdgeInsets.only(top: 30),
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
                              widget.dataList[2]['PaymentStatus'] ==
                                      "กำลังตรวจสอบ"
                                  ? 'ถัดไป'
                                  : 'กลับ',
                              style: TextStyle(fontSize: 16),
                            ),
                            onPressed: () {
                              print(widget.dataList[2]['PaymentStatus']);
                              // int total;
                              // int money;
                              if (widget.dataList[2]['PaymentStatus'] ==
                                  "กำลังตรวจสอบ") {
                                int money = datamaidList[0]['Money'] ?? 0;
                                int paymentPrice =
                                    widget.dataList[2]['PaymentPrice'] ?? 0;
                                setState(() {
                                  price =
                                      money + (paymentPrice * 70 / 100).round();
                                });
                                // setState(() {
                                //   money=dataList[0]['Money'];
                                //   total=price + money;
                                // });
                                print('Updating Maid...');
                                addHistoryMoney(
                                  bookingid: widget.dataList[2]
                                      ['ReservationId'],
                                  money: price,
                                  income: (paymentPrice * 70 / 100).round(),
                                  time: DateTime.now(),
                                ).then((value) {
                                  print('Money updated successfully!');
                                }).catchError((error) {
                                  print('Error updating Money: $error');
                                });

                                updateMoney(
                                  money: price,
                                ).then((value) {
                                  print('Money updated successfully!');
                                }).catchError((error) {
                                  print('Error updating Money: $error');
                                });

                                updateMaid(
                                  paymentimage: imageurl,
                                  status: 'เสร็จสิ้น',
                                ).then((value) {
                                  print('Maid updated successfully!');
                                }).catchError((error) {
                                  print('Error updating Maid: $error');
                                });
                              }
                              print(widget.dataList[2]['PaymentStatus']);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => widget.dataList[2]
                                                  ['PaymentStatus'] ==
                                              "กำลังตรวจสอบ"
                                          ? SuccessPayment()
                                          : PaymentListScreen()));
                            },
                          ),
                        )
                      ],
                    ),
                  )
                : Center(
                    child: CircularProgressIndicator(),
                  ),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(40),
                    topLeft: Radius.circular(40))),
          ),
        ));
  }
}
