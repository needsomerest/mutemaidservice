import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:mutemaidservice/model/auth.dart';
import 'package:mutemaidservice/screen/user/ChatScreen/ChatScreen.dart';
import 'message.dart';

class chatpage extends StatefulWidget {
  String senderid;
  String receiverid;
  chatpage(this.senderid, this.receiverid);
  @override
  _chatpageState createState() => _chatpageState();
}

class _chatpageState extends State<chatpage> {
  // String email;
  // _chatpageState({required this.email});
  final User? user = Auth().currentUser;
  final fs = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  final TextEditingController message = new TextEditingController();
  late String code;

  Future<List<Map<String, dynamic>>> getDataFromFirebase() async {
    List<Map<String, dynamic>> data = [];

    // Query the User collection for a document that contains the Reservation with the given ID
    DocumentSnapshot<Map<String, dynamic>> userSnapshot =
        await FirebaseFirestore.instance
            .collection('User')
            .doc(widget.receiverid)
            .get();
    Map<String, dynamic> UserData = userSnapshot.data()!;
    data.add(UserData);

    print(
        'Number of User documents with Reservation ${widget.receiverid}: ${userSnapshot.data()} ');

    return data;
  }

  List<Map<String, dynamic>> dataList = [];
  // @override
  // void initState() {
  //   super.initState();
  //   _getDataFromFirebase();
  // }

  Future<void> _getDataFromFirebase() async {
    dataList = await getDataFromFirebase();
    setState(() {});
    print(dataList);
    // print(dataList);
  }

  @override
  void initState() {
    super.initState();

    int comparisonResult = widget.senderid.compareTo(widget.receiverid);

    if (comparisonResult > 0) {
      code =
          "${widget.senderid.substring(0, 5)}${widget.receiverid.substring(0, 5)}";
      print(code);
    } else if (comparisonResult < 0) {
      code =
          "${widget.receiverid.substring(0, 5)}${widget.senderid.substring(0, 5)}";
      print(code);
    } else {
      code =
          "${widget.senderid.substring(0, 5)}${widget.receiverid.substring(0, 5)}";
      print(code);
    }

    _getDataFromFirebase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(right: 20),
              height: 43,
              width: 43,
              child: CircleAvatar(
                backgroundImage: NetworkImage(dataList[0]['profileimage'] ??
                    "https://firebasestorage.googleapis.com/v0/b/mutemaidservice-5c04b.appspot.com/o/UserImage%2Fprofile.png?alt=media&token=71e218a0-8801-4cf4-bdd6-2b5b91fdd88c"),
                radius: 220,
              ),
            ),
            Text('${dataList[0]['FirstName']} ${dataList[0]['LastName']}',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Colors.white)),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.79,
              child: messages(widget.senderid, widget.receiverid, code,
                  dataList[0]['profileimage']),
            ),
            Row(
              children: [
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: TextFormField(
                    controller: message,
                    maxLength: 200,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: HexColor('5D5FEF').withOpacity(0.25),
                      hintText: 'ส่งข้อความได้ไม่เกิน 200 ตัวอักษร',
                      enabled: true,
                      contentPadding: const EdgeInsets.only(
                          left: 14.0, bottom: 8.0, top: 8.0),
                      focusedBorder: OutlineInputBorder(
                        borderSide: new BorderSide(color: HexColor('5D5FEF')),
                        borderRadius: new BorderRadius.circular(10),
                      ),
                      // enabledBorder: UnderlineInputBorder(
                      //   borderSide: BorderSide(
                      //       color: HexColor('BDBDBD').withOpacity(0.25)),
                      //   borderRadius: new BorderRadius.circular(10),
                      // ),
                    ),
                    // validator: (value) {},
                    onSaved: (value) {
                      message.text = value!;
                    },
                  ),
                ),
                IconButton(
                  onPressed: () {
                    if (message.text.isNotEmpty) {
                      fs.collection('Messages').doc().set({
                        'message': message.text.trim(),
                        'time': DateTime.now(),
                        // 'email': user?.email ?? "unknow",
                        'sender': widget.senderid,
                        'receiver': widget.receiverid,
                        'code': code
                      });

                      message.clear();
                    }
                  },
                  icon: Icon(Icons.send_sharp),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
