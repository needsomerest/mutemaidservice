import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:mutemaidservice/component/StarButton.dart';
import 'package:mutemaidservice/model/Data/maidData.dart';

class CardReview extends StatefulWidget {
  final Maid maid;
  CardReview({Key? key, required this.maid}) : super(key: key);

  @override
  State<CardReview> createState() => _CardReviewState();
}

class _CardReviewState extends State<CardReview> {
  Future<List<Map<String, dynamic>>> getDataFromFirebase() async {
    List<Map<String, dynamic>> data = [];

    QuerySnapshot<Map<String, dynamic>> ReviewSnapshot = await FirebaseFirestore
        .instance
        .collection("Housekeeper")
        .doc(widget.maid.HousekeeperID)
        .collection('Review')
        .get();

    print('Number of Review documents: ${ReviewSnapshot.size}');

    for (QueryDocumentSnapshot<Map<String, dynamic>> reviewDoc
        in ReviewSnapshot.docs) {
      String userId = reviewDoc.data()['UserID'];
      DocumentSnapshot<Map<String, dynamic>> userSnapshot =
          await FirebaseFirestore.instance.collection('User').doc(userId).get();

      print('Number of User documents with id=$userId: ${userSnapshot.data()}');

      Map<String, dynamic> reviewData = reviewDoc.data();
      Map<String, dynamic>? userData = userSnapshot.data();

      Map<String, dynamic> mergedData = {};
      mergedData.addAll(reviewData);
      mergedData.addAll(userData!);

      data.add(mergedData);
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
    setState(() {});
    print(dataList);
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: dataList.length,
      itemBuilder: (BuildContext context, int index) {
        Map<String, dynamic> data = dataList[index];
        return Container(
          height: 100,
          width: 450,
          margin: EdgeInsets.only(top: 30),
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
              color: HexColor('#BDBDBD').withOpacity(0.25),
              borderRadius: BorderRadius.all(Radius.circular(20))),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(right: 20),
                height: 58,
                width: 58,
                child: CircleAvatar(
                  backgroundImage: NetworkImage(
                    data['profileimage'],
                  ),
                  radius: 220,
                ),
              ),
              Container(
                width: 120,
                child: Flexible(
                  child: Text(
                    "${data['FirstName']} ${data['LastName']}",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              StarButton(data['Score'].toString(), 25, 65, 15, 14, false),
            ],
          ),
        );
      },
    );
  }
}
