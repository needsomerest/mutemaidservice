import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:rxdart/streams.dart';
import 'package:validators/validators.dart';
import 'package:rxdart/rxdart.dart';

class messages extends StatefulWidget {
  String senderid;
  String receiverid;
  String code;
  String img;
  messages(this.senderid, this.receiverid, this.code, this.img);
  // String email;
  // messages({required this.email});
  @override
  _messagesState createState() => _messagesState();
}

class _messagesState extends State<messages> {
  // String email;
  // _messagesState({required this.email});
  // final sender = widget.senderid;

  // Stream<QuerySnapshot> _messageStream = FirebaseFirestore.instance
  //     .collection('Messages')
  //     .where('sender', isEqualTo: widget.senderid)
  //     .orderBy('time')
  //     .snapshots();
  // Future<List<DocumentSnapshot>> getDataFromFirebase() async {
  //   final CollectionReference collectionRef =
  //       FirebaseFirestore.instance.collection('Messages');

  //   final QuerySnapshot querySnapshot = await collectionRef
  //       .where('sender', whereIn: [widget.senderid, widget.receiverid]).where('receiver', whereIn: [widget.senderid, widget.receiverid]).get();
  //   final List<DocumentSnapshot> documents = querySnapshot.docs;

  //   print('Number of Reservation documents: ${documents}');
  //   return documents;
  // }

  List<DocumentSnapshot> dataList = [];
  // late Stream<QuerySnapshot> _messageStream;

  // @override
  // void initState() {
  //   super.initState();
  //   _getDataFromFirebase();
  // }

  // Future<void> _getDataFromFirebase() async {
  //   //_messageStream = await getDataFromFirebase();
  //   setState(() {});
  //   // print(dataList);
  // }
  late Stream<QuerySnapshot<Map<String, dynamic>>> _messageStream;
  // late Stream<QuerySnapshot> _messageStream;
  @override
  void initState() {
    super.initState();

    //  FirebaseFirestore.instance
    //   .collection('Messages')
    //   .where('sender', whereIn: [widget.senderid, widget.receiverid])
    //   .whereIn('receiver', [widget.senderid, widget.receiverid])
    //   .orderBy('time', descending: false)
    //   .snapshots();

    _messageStream = FirebaseFirestore.instance
        .collection('Messages')
        .where('code', isEqualTo: widget.code)
        .orderBy('time', descending: false)
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _messageStream,
      //_messageStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text("something is wrong");
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        return ListView.builder(
          itemCount: snapshot.data!.docs.length,
          physics: ScrollPhysics(),
          shrinkWrap: true,
          primary: true,
          itemBuilder: (_, index) {
            QueryDocumentSnapshot qs = snapshot.data!.docs[index];
            Timestamp t = qs['time'];
            DateTime d = t.toDate();
            print(d.toString());
            return
                //Text('${qs['sender']} : ${qs['message']}');

                Container(
                    // padding: const EdgeInsets.only(top: 8, bottom: 8),
                    // child: Text(qs['sender']),
                    child: ListTile(
                        title: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: widget.senderid == qs['sender']
                  ? MainAxisAlignment.end
                  : MainAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: widget.senderid == qs['sender']
                      ? CrossAxisAlignment.end
                      : CrossAxisAlignment.start,
                  children: [
                    if (widget.senderid == qs['sender']) ...[
                      Text(
                        d.hour.toString() + ":" + d.minute.toString(),
                        style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: HexColor('#979797')),
                      ),
                    ] else ...[
                      Container(
                        margin: EdgeInsets.only(right: 10),
                        height: 43,
                        width: 43,
                        child: CircleAvatar(
                          backgroundImage: NetworkImage(
                            widget.img,
                          ),
                          radius: 220,
                        ),
                      ),
                    ],
                    Container(
                      width: 200,
                      padding: EdgeInsets.only(
                          left: 20, top: 10, bottom: 10, right: 20),
                      margin: widget.senderid == qs['sender']
                          ? EdgeInsets.only(left: 10)
                          : EdgeInsets.only(right: 10),
                      decoration: BoxDecoration(
                        color: widget.senderid == qs['sender']
                            ? HexColor('#5D5FEF').withOpacity(0.2)
                            : HexColor('#BDBDBD').withOpacity(0.25),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Flexible(
                        child: Text(
                          qs['message'],
                          softWrap: true,
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),

                    // if (email != qs['email']) ...[
                    //   Text(
                    //     d.hour.toString() + ":" + d.minute.toString(),
                    //     style: TextStyle(
                    //         fontSize: 10,
                    //         fontWeight: FontWeight.bold,
                    //         color: HexColor('#979797')),
                    //   ),
                    // ],
                  ],
                ),
                if (widget.senderid != qs['sender']) ...[
                  Text(
                    d.hour.toString() + ":" + d.minute.toString(),
                    style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: HexColor('#979797')),
                  ),
                ],
              ],
            )));
          },
        );
      },
    );
  }
}
