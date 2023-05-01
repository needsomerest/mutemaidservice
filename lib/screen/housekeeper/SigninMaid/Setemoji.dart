import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:mutemaidservice/model/Data/maidData.dart';
import 'package:mutemaidservice/screen/housekeeper/SigninMaid/SetPin.dart';

class SetEmoji extends StatefulWidget {
  Maid maid;
  SetEmoji(this.maid);

  @override
  State<SetEmoji> createState() => _SetEmojiState();
}

class _SetEmojiState extends State<SetEmoji> {
  final snackLoginAnswerFail = SnackBar(
    content: const Text('อิโมจิยืนยันตัวตนไม่ตรงกัน กรุณาตรวจสอบข้อมูล'),
    backgroundColor: HexColor("#5D5FEF"),
  );
  final ansController = TextEditingController();
  final ansconfirmController = TextEditingController();
  Future setemoji({
    required String ans,
  }) async {
    var collection = await FirebaseFirestore.instance
        .collection('Housekeeper')
        .doc(widget.maid.HousekeeperID)
        .update({'Answer': ans}).then((result) {
      print("success");
    }).catchError((onError) {
      print("onError");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "กำหนดอิโมจิยืนยันตัวตน",
          style: TextStyle(
              color: HexColor("#000000"),
              fontSize: 24,
              fontFamily: 'Kanit',
              fontWeight: FontWeight.bold),
        ),
        backgroundColor: HexColor("#FFFFFF"),
        elevation: 0,
        iconTheme: IconThemeData(color: HexColor("#5D5FEF")),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          //padding: const EdgeInsets.all(22.0),
          child: Column(children: [
            Image.asset(
              "assets/images/password.png",
              width: 200,
              height: 200,
            ),
            const SizedBox(height: 20),
            Text(
              "กำหนดอิโมจิ 3 ตัวเพื่อยืนยันตัวตนสำหรับการลืมรหัสผ่านในภายหลัง",
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: ansController,
              cursorColor: HexColor("#5D5FEF"),
              textAlign: TextAlign.left,
              maxLength: 3,
              // keyboardType: TextInputType.,
              decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.emoji_symbols_outlined,
                    color: Colors.black,
                  ),
                  hintText: 'อิโมจิยืนยันตัวตน',
                  hintStyle: TextStyle(fontSize: 14),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6.0),
                    borderSide: BorderSide(
                      width: 0,
                      style: BorderStyle.none,
                      //fixedSize: MaterialStateProperty.all(const Size(350, 40)),
                    ),
                  ),
                  filled: true,
                  fillColor: HexColor("F1F1F1"),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6.0),
                    borderSide: BorderSide(
                      color: HexColor("#5D5FEF"),
                    ),
                  )),
            ),
            const SizedBox(height: 30),
            Text(
              "ใส่อิโมจิยืนยันตัวตนอีกครั้ง",
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: ansconfirmController,
              cursorColor: HexColor("#5D5FEF"),
              textAlign: TextAlign.left,
              maxLength: 3,
              // keyboardType: TextInputType.,
              decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.emoji_symbols_outlined,
                    color: Colors.black,
                  ),
                  hintText: 'อิโมจิยืนยันตัวตน',
                  hintStyle: TextStyle(fontSize: 14),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6.0),
                    borderSide: BorderSide(
                      width: 0,
                      style: BorderStyle.none,
                    ),
                  ),
                  filled: true,
                  fillColor: HexColor("F1F1F1"),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6.0),
                    borderSide: BorderSide(
                      color: HexColor("#5D5FEF"),
                    ),
                  )),
            ),
            ElevatedButton(
              onPressed: () {
                if (ansController.text == ansconfirmController.text) {
                  setemoji(ans: ansController.text);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SetPin(
                                maid: widget.maid,
                              )));
                } else {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(snackLoginAnswerFail);
                }
              },
              child: const Icon(
                Icons.arrow_forward,
              ),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(HexColor("5D5FEF")),
                fixedSize: MaterialStateProperty.all(const Size(350, 40)),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
