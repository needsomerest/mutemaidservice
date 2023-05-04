import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:mutemaidservice/component/InfoAtom.dart';
import 'package:mutemaidservice/component/InfoJobAtom.dart';
import 'package:mutemaidservice/component/assetplayer.dart';
import 'package:mutemaidservice/model/Data/maidData.dart';
import 'package:mutemaidservice/screen/housekeeper/HomeScreen/JobDetailScreen.dart';
import 'package:mutemaidservice/screen/housekeeper/HomeScreen/JobScreen.dart';
import 'package:mutemaidservice/screen/housekeeper/HomeScreen/SuccessJob.dart';
import 'package:mutemaidservice/screen/housekeeper/ScheduleScreen/ScheduleScreen.dart';

class ConfirmJobScreen extends StatefulWidget {
  // const ConfirmJobScreen({super.key});
  final Maid maid;
  bool accept;
  String BookingID;
  List<Map<String, dynamic>> dataList;
  String date;
  ConfirmJobScreen(
      this.maid, this.accept, this.BookingID, this.dataList, this.date);
  @override
  State<ConfirmJobScreen> createState() => _ConfirmJobScreenState();
}

class _ConfirmJobScreenState extends State<ConfirmJobScreen> {
  late String userId;
  Future<void> updateReserve({
    required String status,
  }) async {
    try {
      final docMaid = await FirebaseFirestore.instance
          .collection('User')
          .doc(userId)
          .collection('Reservation')
          .doc(widget.BookingID)
          .update({
        'HousekeeperRequest': status,
      });
      print("Update User success");
    } catch (e) {
      print("Error updating User: $e");
    }
  }

  Future<List<Map<String, dynamic>>> getDataFromFirebase() async {
    List<Map<String, dynamic>> data = [];

    // Query the User collection for a document that contains the Reservation with the given ID
    QuerySnapshot<Map<String, dynamic>> SignLanguageSnapshot =
        await FirebaseFirestore.instance
            .collection('SignLanguageVideo')
            .where('Name',
                isEqualTo: widget.dataList[0]
                    ['Note']) //widget.dataList[0]['Note']
            .get();
    Map<String, dynamic> SignLanguageData =
        SignLanguageSnapshot.docs.first.data();
    data.add(SignLanguageData);
    return data;
  }

  List<Map<String, dynamic>> dataVideo = [];
  @override
  void initState() {
    super.initState();
    // print(widget.dataList);
    // print(widget.accept);
    // print(widget.BookingID);
    _getDataFromFirebase();
  }

  Future<void> _getDataFromFirebase() async {
    dataVideo = await getDataFromFirebase();
    setState(() {});
    print(dataVideo);
    // print(widget.dataList);
  }

  @override
  Widget build(BuildContext context) {
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
                    builder: (context) => JobDetailScreen(widget.maid,
                        widget.BookingID, widget.accept, widget.date)));
          },
        ),
        title: Text('Booking No. ${widget.BookingID.substring(0, 5)}', //
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
      ),
      body: dataVideo.isEmpty
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Container(
                height: widget.accept == false ? 1050 : 950,
                width: double.infinity,
                // alignment: Alignment.center,
                padding: EdgeInsets.all(20),
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20),
                    Text('รายละเอียดการจอง',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    Container(
                      alignment: Alignment.bottomLeft,
                      margin: EdgeInsets.all(20),
                      child: Text(
                        'ข้อมูลงาน',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                        height: 550,
                        width: 400,
                        // margin: EdgeInsets.only(top: 50),
                        padding: EdgeInsets.all(20),
                        // color: HexColor('#BDBDBD').withOpacity(0.25),
                        decoration: BoxDecoration(
                            color: HexColor('#BDBDBD').withOpacity(0.25),
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'เวลาทำงาน',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: HexColor('#979797')),
                            ),
                            InfoJobAtom(
                                "assets/images/calendar.png",
                                widget.accept == true
                                    ? widget.date
                                    : widget.dataList[0]['DatetimeService']),
                            InfoJobAtom("assets/images/clock.png",
                                "${widget.dataList[0]['TimeStartService']} - ${widget.dataList[0]['TimeEndService']}"),
                            InfoJobAtom("assets/images/back-in-time.png",
                                widget.dataList[0]['TimeService']),
                            InfoJobAtom("assets/images/repeat.png",
                                widget.dataList[0]['Package']),
                            SizedBox(height: 40),
                            Text(
                              'รายละเอียดงาน',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: HexColor('#979797')),
                            ),
                            InfoJobAtom("assets/images/plans.png",
                                widget.dataList[2]['Sizeroom']),
                            InfoJobAtom("assets/images/happy.png",
                                widget.dataList[0]['Pet']),
                            InfoJobAtom("assets/images/buddha.png",
                                widget.dataList[1]['Region']),
                          ],
                        )),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        Icon(
                          Icons.star,
                          color: HexColor('#5D5FEF'),
                          size: 30,
                        ),
                        SizedBox(width: 20),
                        Text(
                          'หมายเหตุ',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    // Text(
                    //   widget.dataList[3]['Name'],
                    //   style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    // ),
                    // Text(
                    //   widget.dataList[3]['Url'],
                    //   style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    // ),
                    Container(
                      height: 50,
                      padding: EdgeInsets.only(
                          top: 10, bottom: 10, left: 20, right: 20),
                      margin: EdgeInsets.only(top: 20, bottom: 30),
                      decoration: BoxDecoration(
                          color: HexColor('#5D5FEF').withOpacity(0.2),
                          borderRadius: BorderRadius.all(Radius.circular(5))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            widget.dataList[0]['Note'],
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          InkWell(
                            child: Icon(
                              Icons.movie_creation,
                              color: HexColor('#5D5FEF'),
                              size: 30,
                            ),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => VideoPlayerScreen(
                                          dataVideo[0]['Url'])));
                            },
                          )
                        ],
                      ),
                    ),
                    // Text(
                    //   dataVideo[0]['Url'],
                    //   style:
                    //       TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                    // ),
                    // SizedBox(height: 20),
                    if (widget.accept == false) ...[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          InkWell(
                            child: Column(
                              children: [
                                Container(
                                  height: 120,
                                  width: 120,
                                  margin: EdgeInsets.only(bottom: 20),
                                  decoration: BoxDecoration(
                                      color:
                                          HexColor('#EA001B').withOpacity(0.2),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20))),
                                  child: Icon(
                                    Icons.clear,
                                    color: Colors.red,
                                    size: 100,
                                  ),
                                ),
                                Text(
                                  'ปฏิเสธ',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.red),
                                ),
                              ],
                            ),
                            onTap: () {
                              setState(() {
                                userId = widget.dataList[1]['UserID'];
                              });
                              updateReserve(
                                status: 'ไม่รับงาน',
                              ).then((value) {
                                print('Maid updated successfully!');
                              }).catchError((error) {
                                print('Error updating Maid: $error');
                              });

                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => JobScreen(
                                            maid: widget.maid,
                                          )));
                            },
                          ),
                          InkWell(
                            child: Column(
                              children: [
                                Container(
                                  height: 120,
                                  width: 120,
                                  margin: EdgeInsets.only(bottom: 20),
                                  decoration: BoxDecoration(
                                      color:
                                          HexColor('#1F8805').withOpacity(0.2),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20))),
                                  child: Icon(
                                    Icons.check,
                                    color: Colors.green,
                                    size: 100,
                                  ),
                                ),
                                Text(
                                  'รับงาน',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.green),
                                ),
                              ],
                            ),
                            onTap: () {
                              setState(() {
                                userId = widget.dataList[1]['UserID'];
                              });
                              updateReserve(
                                status: 'รับงาน',
                              ).then((value) {
                                print('Maid updated successfully!');
                              }).catchError((error) {
                                print('Error updating Maid: $error');
                              });
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SuccessJob(
                                          widget.maid, widget.accept)));
                            },
                          ),
                        ],
                      )
                    ] else ...[
                      Container(
                        height: 50,
                        width: 100,
                        // alignment: Alignment.bottomRight,
                        margin: EdgeInsets.only(top: 40),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            alignment: Alignment.center,
                            backgroundColor: HexColor("#5D5FEF"),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40.0),
                            ),
                            // minimumSize: Size(100, 40),
                          ),
                          child: Icon(
                            Icons.home,
                            color: Colors.white,
                            size: 30,
                          ),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        ScheduleScreen(maid: widget.maid)));
                          },
                        ),
                      )
                    ]
                  ],
                ),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(40),
                        topLeft: Radius.circular(40))),
                // ),
              ),
            ),
    );
  }
}
