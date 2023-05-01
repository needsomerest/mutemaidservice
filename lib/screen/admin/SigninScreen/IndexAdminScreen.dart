import 'package:flutter/gestures.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:flutter/material.dart';
import 'package:mutemaidservice/component/DividerAccount.dart';
import 'package:mutemaidservice/component/HeaderAccount.dart';
import 'package:mutemaidservice/model/AuthService/AuthGoogle.dart';
import 'package:mutemaidservice/screen/admin/SigninScreen/SiginAdminScreen.dart';
import 'package:mutemaidservice/screen/admin/SigninScreen/SignupAdminScreen.dart';
import 'package:mutemaidservice/screen/admin/SigninScreen/VerifyAdminScreen.dart';
import 'package:mutemaidservice/screen/user/Signin/SigninScreen.dart';
import 'package:mutemaidservice/screen/user/UserScreen/Signup/SignupScreen.dart';

class IndexAdminScreen extends StatelessWidget {
  const IndexAdminScreen({super.key});

  static const String _title = 'Starter | Mute Maid Service';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: _title,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            backgroundColor: HexColor("#FFFFFF"),
            fontFamily: 'Kanit',
            primaryColor: HexColor("#5D5FEF"),
            appBarTheme: AppBarTheme(color: HexColor("#5D5FEF"))),
        home: UserSystem());
  }
}

class UserSystem extends StatelessWidget {
  const UserSystem({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
      body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Container(
                alignment: FractionalOffset.topCenter,
                child: Image.asset(
                  "assets/images/welcome.png",
                  height: 350,
                  width: 400,
                ),
              ),
              HeaderAccount("ยินดีต้อนรับเข้าสู่", 22, "#000000"),
              HeaderAccount("Mute Maid Service", 26, "#5D5FEF"),
              Text(
                'แอปพลิเคชันสำหรับค้นหาแม่บ้านออนไลน์เพื่อแม่บ้านผู้บกพร่องทางการได้ยิน',
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 50,
              ),
              Container(
                //Sign In Default
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SigninAdminScreen()),
                    );
                  },
                  child:
                      const Text('เข้าสู่ระบบ', style: TextStyle(fontSize: 18)),
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(HexColor("5D5FEF")),
                    fixedSize: MaterialStateProperty.all(const Size(350, 40)),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Container(
                alignment: FractionalOffset.bottomCenter,
                child: BottomTitle(
                  "ยังไม่มีบัญชีผู้ใช้?",
                  "#000000",
                  "  ลงทะเบียนผู้ใช้",
                  "#5D5FEF",
                ),
              )
            ],
          )));
}

class BottomTitle extends StatelessWidget {
  String FirstTitle;
  String FistTitleColor;
  String SecondTitle;
  String SecondTitleColor;

  BottomTitle(this.FirstTitle, this.FistTitleColor, this.SecondTitle,
      this.SecondTitleColor);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: RichText(
        text: TextSpan(children: [
          TextSpan(
            text: FirstTitle,
            style: TextStyle(
              color: HexColor(FistTitleColor),
              fontSize: 16,
              fontWeight: FontWeight.w500,
              fontFamily: 'Kanit',
            ),
          ),
          TextSpan(
              text: SecondTitle,
              style: TextStyle(
                  color: HexColor(SecondTitleColor),
                  fontSize: 16,
                  fontFamily: 'Kanit',
                  fontWeight: FontWeight.bold),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => VerifyAdminScreen()),
                  );
                }),
        ]),
      ),
    );
  }
}
