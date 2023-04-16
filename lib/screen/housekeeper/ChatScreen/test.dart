import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class test extends StatefulWidget {
  const test({Key? key}) : super(key: key);

  final String senderid = "JnV1RN7iAKV4qKqCoofPFntio312";
  final String receiverid = "ZhkVnQ10zU28sFaURHU6";

  @override
  State<test> createState() => _testState();
}

class _testState extends State<test> {
  // late Stream<QuerySnapshot> _messageStream;
  late Stream<QuerySnapshot> _messageStream;

  @override
  void initState() {
    super.initState();
    _getDataFromFirebase().then((stream) {
      setState(() {
        _messageStream = stream;
      });
    });
  }

  Future<Stream<QuerySnapshot>> _getDataFromFirebase() async {
    final CollectionReference collectionRef =
        FirebaseFirestore.instance.collection('Messages');

    final QuerySnapshot querySnapshot = await collectionRef
        .where('sender', whereIn: [widget.senderid, widget.receiverid]).where(
            'receiver',
            whereIn: [widget.senderid, widget.receiverid]).get();
    final List<DocumentSnapshot> documents = querySnapshot.docs;

    print('Number of Reservation documents: ${documents.length}');
    return Stream.value(querySnapshot);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _messageStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text("something is wrong");
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        final List<DocumentSnapshot> documents = snapshot.data!.docs;
        print('Number of Reservation documents: ${documents.length}');

        return ListView.builder(
          itemCount: documents.length,
          physics: ScrollPhysics(),
          shrinkWrap: true,
          primary: true,
          itemBuilder: (_, index) {
            QueryDocumentSnapshot qs =
                documents[index] as QueryDocumentSnapshot;
            Timestamp t = qs['time'];
            DateTime d = t.toDate();
            print(d.toString());
            return Text('${qs['sender']} : ${qs['message']}');
          },
        );
      },
    );
  }
}
