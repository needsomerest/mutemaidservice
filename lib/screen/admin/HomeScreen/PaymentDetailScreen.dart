import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:mutemaidservice/model/Data/NotificationData.dart';
import 'package:mutemaidservice/model/notification_managet.dart';
import 'package:mutemaidservice/screen/admin/HomeScreen/ConfirmPaymentScreen.dart';
import 'package:mutemaidservice/screen/admin/HomeScreen/HomeScreen.dart';
import 'package:mutemaidservice/screen/admin/HomeScreen/PaymentListScreen.dart';

class PaymentDetailScreen extends StatefulWidget {
  // const PaymentDetailScreen({super.key});
  String Paymentid;
  PaymentDetailScreen(this.Paymentid);

  @override
  State<PaymentDetailScreen> createState() => _PaymentDetailScreenState();
}

class _PaymentDetailScreenState extends State<PaymentDetailScreen> {
  String UserID = '';
  String ReservationID = '';
  String housekeeperid = '';
  Future<List<Map<String, dynamic>>> getDataFromFirebase() async {
    List<Map<String, dynamic>> data = [];

    QuerySnapshot<Map<String, dynamic>> UserSnapshot =
        await FirebaseFirestore.instance.collection('User').get();

    for (QueryDocumentSnapshot<Map<String, dynamic>> UserDoc
        in UserSnapshot.docs) {
      DocumentSnapshot<Map<String, dynamic>> reservationSnapshot =
          await FirebaseFirestore.instance
              .collection('User')
              .doc(UserDoc.id)
              .collection('Reservation')
              .doc(widget.Paymentid)
              .get();
      UserID = UserDoc.id;
      ReservationID = widget.Paymentid;
      housekeeperid = reservationSnapshot["HousekeeperID"];

      print(
          'Number of Reservation documents: ${reservationSnapshot.data()}| ${UserDoc.id} ${widget.Paymentid}');
      if (reservationSnapshot.data() != null) {
        DocumentSnapshot<Map<String, dynamic>> userSnapshot =
            await FirebaseFirestore.instance
                .collection('User')
                .doc(UserDoc.id)
                .get();
        Map<String, dynamic> UserData = userSnapshot.data()!;
        data.add(UserData);
        Map<String, dynamic> reservationData = reservationSnapshot.data()!;
        data.add(reservationData);

        QuerySnapshot<Map<String, dynamic>> paymentSnapshot =
            await FirebaseFirestore.instance
                .collection('User')
                .doc(UserDoc.id)
                .collection('Reservation')
                .doc(widget.Paymentid)
                .collection('Payment')
                .get();
        print(
            'Number of Payment documents with PaymentStatus=true in Reservation document ${reservationSnapshot.id}: ${paymentSnapshot.size}');

        for (QueryDocumentSnapshot<Map<String, dynamic>> paymentDoc
            in paymentSnapshot.docs) {
          Map<String, dynamic> docData = paymentDoc.data();
          String paymentId = paymentDoc.id;
          docData['paymentId'] = paymentId;
          docData['ReservationId'] = reservationSnapshot.id;
          docData['PaymentStatus'] = paymentDoc['PaymentStatus'];
          data.add(docData);
        }

        break;
      }
    }

    return data;
  }

  Future UpdateReservationStatuse_Fail({
    required String useruid,
    required String reservationid,
  }) async {
    await FirebaseFirestore.instance
        .collection('User')
        .doc(useruid)
        .collection('Reservation')
        .doc(reservationid)
        .update({
      'Status': 'ประวัติ',
    }).then((result) {
      print("Update Status true");
    }).catchError((onError) {
      print("onError");
    });

    QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore
        .instance
        .collection('User')
        .doc(useruid)
        .collection('Reservation')
        .doc(reservationid)
        .collection('Payment')
        .limit(1)
        .get();

    await FirebaseFirestore.instance
        .collection('User')
        .doc(useruid)
        .collection('Reservation')
        .doc(reservationid)
        .collection('Payment')
        .doc(querySnapshot.docs[0].id)
        .update({
      'PaymentStatus': 'ปฏิเสธ',
    }).then((result) {
      print("Update Status true");
    }).catchError((onError) {
      print("onError");
    });
  }

  List<Map<String, dynamic>> dataList = [];

  @override
  void initState() {
    super.initState();
    _getDataFromFirebase();
  }

  Future<void> _getDataFromFirebase() async {
    dataList = await getDataFromFirebase();
    setState(() {});
    print("datalist: ${dataList}");
  }

  Future Notification_confirm() async {
    NotificationData notificationData = NotificationData(
        UserID,
        ReservationID,
        "หนังสือการจองหมายเลข ${ReservationID} ตรวจสอบพบหลักฐานการชำระเงินเรียบร้อยแล้ว",
        "ผลการตรวจสอบการชำระเงิน");
    await FirebaseFirestore.instance
        .collection("Notification")
        .doc()
        .set(notificationData.CreateNotificationtoJson());

    NotificationData notificationMaidData = NotificationData(housekeeperid,
        ReservationID, "ได้รับรายได้ จาก ${ReservationID}", "รายได้");
    await FirebaseFirestore.instance
        .collection("Notification")
        .doc()
        .set(notificationMaidData.CreateNotificationtoJson());
  }

  Future Notification_cancel() async {
    final notificationData = new NotificationData(
        UserID,
        ReservationID,
        "หนังสือการจองหมายเลข ${ReservationID} ตรวจสอบพบหลักฐานการชำระเงินพบความผิดพลาด ระบบทำการยกเลิกการจองรายการดังกล่าวอัตโนมัติ",
        "ผลการตรวจสอบการชำระเงิน");
    await FirebaseFirestore.instance
        .collection("Notification")
        .doc()
        .set(notificationData.CreateNotificationtoJson());
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
          height: 700,
          width: double.infinity,
          alignment: Alignment.center,
          padding: EdgeInsets.all(20),
          child: dataList.isNotEmpty
              ? Container(
                  height: 670,
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
                            // Text('${dataList.length} items fetched from Firebase'),
                            Text(
                                'หมายเลขการจอง : ${dataList[2]['ReservationId']}',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                                textAlign: TextAlign.left),
                            SizedBox(height: 10),
                            Text(
                                'ชื่อลูกค้า : ${dataList[0]['FirstName']} ${dataList[0]['LastName']}',
                                style: TextStyle(fontSize: 16),
                                textAlign: TextAlign.left),
                            SizedBox(height: 5),
                            Text(
                                'เบอร์โทรศัพท์ : ${dataList[0]['PhoneNumber']}',
                                style: TextStyle(fontSize: 16),
                                textAlign: TextAlign.left),
                            SizedBox(height: 5),
                            Text(
                                'ยอดชำระทั้งหมด : ${dataList[2]['PaymentPrice']} บาท',
                                style: TextStyle(fontSize: 16),
                                textAlign: TextAlign.left),
                            SizedBox(
                              height: 20,
                            ),
                          ]),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image(
                          width: 300,
                          height: 400,
                          image: NetworkImage(dataList[2]['PaymentImage']),
                          fit: BoxFit.fill,
                        ),
                      ),
                      if (dataList[2]['PaymentStatus'] == 'กำลังตรวจสอบ') ...[
                        Row(
                          children: [
                            Container(
                              height: 50,
                              width: 150,
                              margin: EdgeInsets.only(top: 30),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  alignment: Alignment.center,
                                  backgroundColor: HexColor("#AD3B3B"),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(40.0),
                                  ),
                                  minimumSize: Size(100, 40),
                                ),
                                child: Text(
                                  'ปฏิเสธ',
                                  style: TextStyle(fontSize: 16),
                                ),
                                onPressed: () {
                                  Notification_cancel();
                                  UpdateReservationStatuse_Fail(
                                      useruid: dataList[0]['UserID'],
                                      reservationid: dataList[2]
                                          ['ReservationId']);
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              HomeAdminScreen()));
                                },
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
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
                                  'ถัดไป',
                                  style: TextStyle(fontSize: 16),
                                ),
                                onPressed: () {
                                  Notification_confirm();
                                  // Navigator.push(
                                  //     context,
                                  //     MaterialPageRoute(
                                  //         builder: (context) => ConfirmPaymentScreen(
                                  //             dataList[2]['ReservationId'],
                                  //             dataList[1]['HousekeeperID'])));
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ConfirmPaymentScreen(dataList)));
                                },
                              ),
                            )
                          ],
                        ),
                      ],
                    ],
                  ),
                )
              : Center(
                  child: CircularProgressIndicator(),
                ),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(40), topLeft: Radius.circular(40))),
        ),
      ),
    );
  }
}
