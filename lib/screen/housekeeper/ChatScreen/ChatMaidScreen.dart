// import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:line_icons/line_icons.dart';
import 'package:mutemaidservice/component/ChatAtom.dart';
import 'package:mutemaidservice/model/Data/maidData.dart';
import 'package:mutemaidservice/screen/housekeeper/ChatScreen/Chatmaid.dart';
import 'package:mutemaidservice/screen/housekeeper/ChatScreen/chatpage.dart';
import 'package:mutemaidservice/screen/housekeeper/ScheduleScreen/ScheduleScreen.dart';
import 'package:mutemaidservice/screen/user/ChatScreen/ChatHistory.dart';
import 'package:mutemaidservice/screen/user/ChatScreen/ChatScreen.dart';
import '../../../../component/CardPromotion.dart';
import '../../../../component/ProfileBar.dart';
import '../../../../component/PromotionCardSlide.dart';
import '../../../../model/auth.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
// import '../../../RoleScreen.dart';
import '../HomeScreen/HomeMaidScreen.dart';

class ChatMaidScreen extends StatefulWidget {
  final Maid maid;
  ChatMaidScreen({Key? key, required this.maid});

  @override
  State<ChatMaidScreen> createState() => _ChatMaidScreenState();
}

class Message {
  final String id;
  final String sender;
  final String receiver;
  final String text;
  final Timestamp timestamp;

  Message(
      {required this.id,
      required this.sender,
      required this.receiver,
      required this.text,
      required this.timestamp});
}

class _ChatMaidScreenState extends State<ChatMaidScreen> {
  // final User? user = Auth().currentUser;
  String gencode(String sender, String receiver) {
    String code = "";
    int comparisonResult = sender.compareTo(receiver);
    if (comparisonResult > 0) {
      code = "${sender.substring(0, 5)}${receiver.substring(0, 5)}";
      print(code);
    } else if (comparisonResult < 0) {
      code = "${receiver.substring(0, 5)}${sender.substring(0, 5)}";
      print(code);
    } else {
      code = "${sender.substring(0, 5)}${receiver.substring(0, 5)}";
      print(code);
    }
    return code;
  }

  Future<List<Message>> getLatestMessages(String uid) async {
    QuerySnapshot<Map<String, dynamic>> messagesSnapshot =
        await FirebaseFirestore.instance
            .collection("Messages")
            .where('sender', isEqualTo: uid)
            .get();
    List<String> uniqueReceivers = messagesSnapshot.docs
        .map((doc) => doc['receiver'])
        .toSet()
        .toList()
        .cast<String>();
    List<Message> latestMessages = [];
    for (String receiver in uniqueReceivers) {
      String code = gencode(uid, receiver);
      //  print("${uid+receiver+code}");
      QuerySnapshot<Map<String, dynamic>> subQuerySnapshot =
          await FirebaseFirestore.instance
              .collection('Messages')
              .where('code', isEqualTo: code)
              // .where('sender', isEqualTo: uid)
              // .where('receiver', isEqualTo: receiver)
              .orderBy('time', descending: true)
              .limit(1)
              .get();
      if (subQuerySnapshot.docs.isNotEmpty) {
        DocumentSnapshot<Map<String, dynamic>> messageDoc =
            subQuerySnapshot.docs[0];
        print(
            "${messageDoc['sender']}+${messageDoc['receiver']} : ${messageDoc['message']}");
        Message message = Message(
            id: messageDoc.id,
            sender: messageDoc['sender'],
            receiver: messageDoc['receiver'],
            text: messageDoc['message'],
            timestamp: messageDoc['time']);
        latestMessages.add(message);
      }
    }
    return latestMessages;
  }

  List<Message> latestMessages = [];
  // List<Map<String, dynamic>> dataList = [];
  List<Map<String, dynamic>> mergedDataList = [];
  List<Map<String, dynamic>> data = [];

  Future<List<Map<String, dynamic>>> getHousekeeperSnapshots(String uid) async {
    latestMessages = await getLatestMessages(uid);
    for (Message message in latestMessages) {
      String receiver;
      if (message.receiver != uid) {
        receiver = message.receiver;
      } else {
        receiver = message.sender;
      }
      DocumentSnapshot<Map<String, dynamic>> UserSnapshot =
          await FirebaseFirestore.instance
              .collection('User')
              .doc(receiver)
              .get();

      Map<String, dynamic> UserData = UserSnapshot.data()!;
      UserData['UserId'] = receiver;
      // dataList.add(housekeeperData);
      // print(dataList.length);
      // for (int i = 0; i < dataList.length; i++) {
      //   String receiver = dataList[i]['housekeeperId'];
      // if (message.receiver == receiver) {
      Map<String, dynamic> mergedData = Map<String, dynamic>.from(UserData);
      mergedData['latestMessageId'] = message.id;
      mergedData['latestMessageText'] = message.text;
      mergedData['latestMessageTimestamp'] = message.timestamp;
      mergedDataList.add(mergedData);
      // }
      // }
      // print(dataList.length);
    }
    // print(mergedDataList.length);
    // for (int i = 0; i < mergedDataList.length; i++) {
    //   print(mergedDataList[i]);
    // }
    return mergedDataList;
  }

  @override
  void initState() {
    super.initState();
    _getDataFromFirebase();
  }

  Future<void> _getDataFromFirebase() async {
    data = await getHousekeeperSnapshots(widget.maid.HousekeeperID);
    setState(() {});
    print(data.length);
    for (int i = 0; i < data.length; i++) {
      print(data[i]);
    }
    // print(data);
    // print(dataList);
  }

  @override
  Widget build(BuildContext context) {
    // final _uid = user?.uid;
    // String uid = _uid.toString();
    int _selectedIndex = 2;
    final screens = [
      HomeMaidScreen(
        maid: widget.maid,
      ),
      ScheduleScreen(
        maid: widget.maid,
      ),
      ChatMaidScreen(
        maid: widget.maid,
      ),
    ];
    return Scaffold(
      backgroundColor: HexColor('#5D5FEF'),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0.0,
        backgroundColor: HexColor('#5D5FEF'),
        centerTitle: true,
        title: Text('ข้อความ',
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
            child: //mergedDataList.isNotEmpty?
                ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (BuildContext context, int index) {
                      // return Text(index.toString());
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      // test()
                                      // chatpage("ZhkVnQ10zU28sFaURHU6", uid)
                                      Chatmaid(
                                        widget.maid.HousekeeperID,
                                        data[index]['UserId'],
                                      )));
                        },
                        child:
                            // Text(
                            // "${mergedDataList[index]['FirstName']} ${mergedDataList[index]['LastName']}"),
                            ChatAtom(
                                data[index]['profileimage'],
                                "${data[index]['FirstName']} ${data[index]['LastName']}",
                                data[index]['latestMessageText']),
                      );
                    })
            // : CircularProgressIndicator()
            // : Center(
            //     child: CircularProgressIndicator(),
            //   ),
            ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Colors.black.withOpacity(.1),
            )
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
            child: GNav(
              rippleColor: Colors.grey[300]!,
              hoverColor: Colors.grey[100]!,
              gap: 8,
              activeColor: Colors.black,
              iconSize: 24,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              duration: Duration(milliseconds: 400),
              tabBackgroundColor: Colors.grey[100]!,
              color: Colors.black,
              tabs: [
                GButton(
                  icon: LineIcons.home,
                  text: 'หน้าหลัก',
                  iconActiveColor: HexColor('5D5FEF'),
                  textColor: HexColor('5D5FEF'),
                  backgroundColor: HexColor('5D5FEF').withOpacity(0.2),
                ),
                GButton(
                  icon: LineIcons.calendar,
                  text: 'ตารางงาน',
                  iconActiveColor: HexColor('5D5FEF'),
                  textColor: HexColor('5D5FEF'),
                  backgroundColor: HexColor('5D5FEF').withOpacity(0.2),
                ),
                GButton(
                  icon: LineIcons.rocketChat,
                  text: 'ข้อความ',
                  iconActiveColor: HexColor('5D5FEF'),
                  textColor: HexColor('5D5FEF'),
                  backgroundColor: HexColor('5D5FEF').withOpacity(0.2),
                ),
              ],
              selectedIndex: _selectedIndex,
              onTabChange: (index) {
                setState(() {
                  _selectedIndex = index;
                });
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => screens[_selectedIndex]));
              },
            ),
          ),
        ),
      ),
    );
  }
}
