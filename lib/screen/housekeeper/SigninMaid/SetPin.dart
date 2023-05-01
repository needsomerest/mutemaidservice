import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:mutemaidservice/model/Data/maidData.dart';
import 'package:mutemaidservice/screen/housekeeper/HomeScreen/HomeMaidScreen.dart';
import 'package:pinput/pinput.dart';

class SetPin extends StatefulWidget {
  final Maid maid;
  SetPin({Key? key, required this.maid}) //required this.addressData
      : super(key: key);
  @override
  State<SetPin> createState() => _SetPinState();
}

class _SetPinState extends State<SetPin> {
  Future updatepin({
    required String pin,
  }) async {
    var collection = await FirebaseFirestore.instance
        .collection('Housekeeper')
        .doc(widget.maid.HousekeeperID)
        .update({'Pin': pin}).then((result) {
      print("set pin success");
    }).catchError((onError) {
      print("onError");
    });
  }

  final TextEditingController _pinPutController = TextEditingController();
  final TextEditingController _pinconfirmController = TextEditingController();
  // late String Pin;
  // late String Pinconfirm;
  final defaultPinTheme = PinTheme(
    width: 56,
    height: 56,
    textStyle: TextStyle(
        fontSize: 20,
        color: Color.fromRGBO(30, 60, 87, 1),
        fontWeight: FontWeight.w600),
    decoration: BoxDecoration(
      border: Border.all(color: Colors.black),
      borderRadius: BorderRadius.circular(20),
    ),
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ตั้งรหัสผ่านเพื่อเข้าสู่ระบบ'),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: 700,
          child: Column(
            children: [
              SizedBox(
                height: 50,
              ),
              Image.asset(
                "assets/images/password-entry.png",
                height: 200,
                width: 200,
              ),
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: Pinput(
                  length: 6,
                  defaultPinTheme: defaultPinTheme,
                  controller: _pinPutController,
                  pinAnimationType: PinAnimationType.fade,
                  // onSubmitted: (pin) {
                  //   setState(() {
                  //     Pin = _pinPutController.text;
                  //   });
                  // },
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 40),
                child: Center(
                  child: Text(
                    'ยืนยันรหัสผ่าน',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: Pinput(
                  length: 6,
                  defaultPinTheme: defaultPinTheme,
                  controller: _pinconfirmController,
                  pinAnimationType: PinAnimationType.fade,
                  // onSubmitted: (pin) {
                  //   if (_pinPutController.text == _pinconfirmController.text) {
                  //     updatepin(pin: _pinPutController.text);
                  //     Navigator.push(
                  //         context,
                  //         MaterialPageRoute(
                  //             builder: (context) => HomeMaidScreen(
                  //                   maid: widget.maid,
                  //                 )));
                  //   } else {
                  //     print("Not Correct");
                  //   }
                  // },
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  if (_pinPutController.text == _pinconfirmController.text) {
                    updatepin(pin: _pinPutController.text);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => HomeMaidScreen(
                                  maid: widget.maid,
                                )));
                  } else {
                    print("Not Correct");
                  }
                },
                child: const Icon(
                  Icons.arrow_forward,
                ),
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(HexColor("5D5FEF")),
                  fixedSize: MaterialStateProperty.all(const Size(100, 50)),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
