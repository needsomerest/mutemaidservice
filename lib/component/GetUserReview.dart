import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:mutemaidservice/component/Review.dart';

class GetUserReview extends StatefulWidget {
  String UserID;
  String Score;
  String ReviewDetail;
  String DateTimeReview;
  GetUserReview(
      {required this.UserID,
      required this.Score,
      required this.ReviewDetail,
      required this.DateTimeReview});

  @override
  State<GetUserReview> createState() => _GetUserReviewState();
}

class _GetUserReviewState extends State<GetUserReview> {
  Future<List<Map<String, dynamic>>> getDataFromFirebase() async {
    List<Map<String, dynamic>> data = [];

    // Query the User collection for a document that contains the Reservation with the given ID
    DocumentSnapshot<Map<String, dynamic>> userSnapshot =
        await FirebaseFirestore.instance
            .collection('User')
            .doc(widget.UserID)
            .get();
    Map<String, dynamic> UserData = userSnapshot.data()!;
    data.add(UserData);

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
    // print(dataList);
  }

  String url = '';
  String name = '';

  @override
  Widget build(BuildContext context) {
    if (dataList.isNotEmpty) {
      url = dataList[0]['profileimage'];
      name = dataList[0]['FirstName'] + '  ' + dataList[0]['LastName'];
    }
    initializeDateFormatting('th');
    DateTime dateTime = DateFormat("dd/MM/yyyy").parse(widget.DateTimeReview);
    String outputDate = DateFormat.yMMMMd('th').format(dateTime);

    return Review(url, name, widget.Score, widget.ReviewDetail, outputDate);
  }
}
