import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:mutemaidservice/component/Placedetail.dart';
import 'package:mutemaidservice/model/Data/maidData.dart';
import 'package:mutemaidservice/screen/housekeeper/HomeScreen/ConfirmJobScreen.dart';
import 'package:mutemaidservice/screen/housekeeper/HomeScreen/SuccessJob.dart';
import 'package:mutemaidservice/screen/housekeeper/MapScreen/RouteMapScreen.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class JobDetailScreen extends StatefulWidget {
  Maid maid;
  String BookingID;
  bool accept;
  String date;
  // DateTime
  // double distance;
  JobDetailScreen(this.maid, this.BookingID, this.accept, this.date);

  @override
  State<JobDetailScreen> createState() => _JobDetailScreenState();
}

late String BookedID;
late String UserID;
late Maid maidfinal;

class _JobDetailScreenState extends State<JobDetailScreen> {
  Future<List<Map<String, dynamic>>> getDataFromFirebase() async {
    List<Map<String, dynamic>> data = [];

    // Query the User collection for a document that contains the Reservation with the given ID
    QuerySnapshot<Map<String, dynamic>> UserSnapshot =
        await FirebaseFirestore.instance.collection('User').get();
    print('Number of User documents: ${UserSnapshot.size}');

    for (QueryDocumentSnapshot<Map<String, dynamic>> UserDoc
        in UserSnapshot.docs) {
      DocumentSnapshot<Map<String, dynamic>> reserveSnapshot =
          await FirebaseFirestore.instance
              .collection('User')
              .doc(UserDoc.id)
              .collection('Reservation')
              .doc(widget.BookingID)
              .get();
      if (reserveSnapshot.data() != null) {
        Map<String, dynamic> reserveData = reserveSnapshot.data()!;
        data.add(reserveData);
        DocumentSnapshot<Map<String, dynamic>> userSnapshot =
            await FirebaseFirestore.instance
                .collection('User')
                .doc(UserDoc.id)
                .get();
        Map<String, dynamic> UserData = userSnapshot.data()!;
        data.add(UserData);
        String addressID = reserveData['AddressID'];
        DocumentSnapshot<Map<String, dynamic>> addressSnapshot =
            await FirebaseFirestore.instance
                .collection('User')
                .doc(UserDoc.id)
                .collection('Address')
                .doc(addressID)
                .get();
        Map<String, dynamic> addressData = addressSnapshot.data()!;
        data.add(addressData);

        print(
            'Number of User documents with Reservation ${widget.BookingID}: ${userSnapshot.data()}');
        break;
      }
    }
    return data;
  }

  List<Map<String, dynamic>> dataList = [];
  @override
  void initState() {
    super.initState();
    _getDataFromFirebase();
  }

  Future<void> _getDataFromFirebase() async {
    dataList = await getDataFromFirebase();
    setState(() {
      BookedID = widget.BookingID;
      UserID = dataList[1]['UserID'];
      maidfinal = widget.maid;
      // price = dataList[0]['Money'] +
      //     (dataList[2]['PaymentPrice'] * 70 / 100).round();
    });
    print(dataList);
    // print(dataList);
  }

  @override
  Widget build(BuildContext context) {
    return
        //TextButton(
        //onPressed: _getDataFromFirebase, child: Text('Get'));
        Scaffold(
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
        title: Text('Booking ID. ${widget.BookingID.substring(0, 5)}',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: 1050,
          width: double.infinity,
          // alignment: Alignment.center,
          padding: EdgeInsets.all(20),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: widget.accept == true
                    ? MainAxisAlignment.spaceAround
                    : MainAxisAlignment.center,
                children: [
                  SizedBox(width: 10),
                  Text('รายละเอียดการจอง',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  if (widget.accept == true) ...[
                    InkWell(
                      child: Icon(
                        Icons.delete,
                        size: 45,
                        color: Colors.red,
                      ),
                      onTap: () => _onAlertButtonPressedMaid(context),
                    )
                  ],
                ],
              ),
              Container(
                alignment: Alignment.bottomLeft,
                margin: EdgeInsets.all(20),
                child: Text(
                  'ลูกค้า',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                height: 100,
                child: // PlaceDetail(widget.BookingID),
                    Container(
                        height: 100,
                        width: 400,
                        // margin: EdgeInsets.only(top: 50),
                        padding: EdgeInsets.all(20),
                        // color: HexColor('#BDBDBD').withOpacity(0.25),
                        decoration: BoxDecoration(
                            color: HexColor('#BDBDBD').withOpacity(0.25),
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        child: Row(
                          children: [
                            Image.network(
                              dataList[1]['profileimage'] == ""
                                  ? "https://firebasestorage.googleapis.com/v0/b/mutemaidservice-5c04b.appspot.com/o/UserImage%2Fprofile.png?alt=media&token=71e218a0-8801-4cf4-bdd6-2b5b91fdd88c"
                                  : dataList[1]['profileimage'],
                              height: 60,
                              width: 60,
                            ),
                            SizedBox(width: 30),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                    '${dataList[1]['FirstName']} ${dataList[1]['LastName']}', //"${UserDocument['FirstName']} ${UserDocument['LastName']}" UserDocument['PhoneNumber']
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500)),
                                Text(dataList[1]['PhoneNumber'],
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500)),
                              ],
                            ),
                          ],
                        )),
              ),
              SizedBox(height: 20),
              Container(
                alignment: Alignment.bottomLeft,
                margin: EdgeInsets.all(20),
                child: Text(
                  'ที่อยู่',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                height: 450,
                width: 700,
                // margin: EdgeInsets.only(top: 30),
                padding: EdgeInsets.only(top: 30, bottom: 30),
                decoration: BoxDecoration(
                    color: HexColor('#BDBDBD').withOpacity(0.25),
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(
                          "assets/images/house.png",
                          height: 110,
                          width: 110,
                        ),
                        SizedBox(width: 30),
                        Container(
                          width: 90,
                          height: 35,
                          decoration: BoxDecoration(
                              color: HexColor('#1F8805'),
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(20),
                                  topLeft: Radius.circular(20))),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Icon(
                                Icons.explore,
                                size: 20,
                                color: HexColor('#FFFFFF'),
                              ),
                              Text(
                                  '${(dataList[0]['Distance'] / 1000).toString().substring(0, 4)} กม.', //
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white)),
                            ],
                          ),
                        )
                      ],
                    ),
                    Text(dataList[2]['AddressName'],
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: HexColor('#5D5FEF'))),
                    Text('หน้าบ้าน',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: HexColor('#979797'))),
                    Image.network(
                      dataList[2]['AddressImage'],
                      height: 200,
                      // width: 110,
                    ),
                  ],
                ),
              ),
              InkWell(
                child: Container(
                    height: 100,
                    width: 400,
                    margin: EdgeInsets.only(top: 50),
                    padding: EdgeInsets.all(20),
                    // color: HexColor('#BDBDBD').withOpacity(0.25),
                    decoration: BoxDecoration(
                        color: HexColor('#5D5FEF').withOpacity(0.25),
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    child: Row(
                      children: [
                        Image.asset(
                          "assets/images/location.png",
                          height: 60,
                          width: 60,
                        ),
                        SizedBox(width: 30),
                        Flexible(
                          child: Text(dataList[2]['AddressDetail'],
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w500)),
                        )
                      ],
                    )),
                onTap: () {
                  GeoPoint geoPoint = dataList[2]['Point'];
                  LatLng latLng = LatLng(geoPoint.latitude, geoPoint.longitude);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => RouteMapPage(latLng)));
                },
              ),
              Container(
                height: 50,
                width: 100,
                // alignment: Alignment.bottomRight,
                margin: EdgeInsets.only(top: 50),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    alignment: Alignment.center,
                    backgroundColor: HexColor("#5D5FEF"),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40.0),
                    ),
                    minimumSize: Size(100, 40),
                  ),
                  child: Icon(
                    Icons.arrow_forward,
                    color: Colors.white,
                    size: 30,
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ConfirmJobScreen(
                                widget.maid,
                                widget.accept,
                                widget.BookingID,
                                dataList,
                                widget.accept == true ? widget.date : "")));
                  },
                ),
              )
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

_onAlertButtonPressedMaid(BuildContext context) {
  // final User? user = Auth().currentUser;
  Alert(
    context: context,
    type: AlertType.warning,
    title: "ยกเลิกงาน",
    desc: "ท่านแน่ใจที่จะยกเลิกงานนี้ใช่หรือไม่",
    style: AlertStyle(
      titleStyle: TextStyle(
        color: Colors.red,
        fontWeight: FontWeight.bold,
        fontSize: 20,
      ),
      descStyle: TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 16,
      ),
    ),
    buttons: [
      DialogButton(
        width: 100,
        height: 70,
        color: HexColor('#1F8805').withOpacity(0.2),
        radius: BorderRadius.all(Radius.circular(10)),
        child: Icon(
          Icons.check,
          color: Colors.green,
          size: 50,
        ),
        onPressed: () {
          deleteData();
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => SuccessJob(maidfinal, true)));
        },
        // color: HexColor('#5D5FEF'),
      ),
      DialogButton(
        width: 100,
        height: 70,
        color: HexColor('#EA001B').withOpacity(0.2),
        radius: BorderRadius.all(Radius.circular(10)),
        child: Icon(
          Icons.clear,
          color: Colors.red,
          size: 50,
        ),
        onPressed: () => Navigator.pop(context),
      )
    ],
  ).show();
}

Future deleteData() async {
  // print(BookedID);
  try {
    // userid.delete();
    await FirebaseFirestore.instance
        .collection("User")
        .doc(UserID)
        .collection("Reservation")
        .doc(BookedID)
        .delete();

    print("sucess");
  } catch (e) {
    return print(e);
  }
}
