import 'package:flutter/gestures.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:flutter/material.dart';
import 'package:mutemaidservice/component/DividerAccount.dart';
import 'package:mutemaidservice/component/HeaderAccount.dart';
import 'package:mutemaidservice/model/AuthService/AuthGoogle.dart';
import 'package:mutemaidservice/screen/Signin/SigninScreen.dart';
import 'package:mutemaidservice/screen/UserScreen/Signup/SignupScreen.dart';

class IndexScreen extends StatelessWidget {
  const IndexScreen({super.key});

  static const String _title = 'MCS Service';

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
              HeaderAccount("Let's you in", 40, "#000000"),
              Container(
                  //Sign In by Facebook
                  margin: EdgeInsets.symmetric(vertical: 6.0),
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.white,
                      onPrimary: HexColor("#5D5FEF"),
                      minimumSize: Size(350, 40),
                    ),
                    icon: FaIcon(FontAwesomeIcons.facebook), //color:
                    label: Text(
                      'Continue with Facebook',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        // fontWeight: FontWeight.bold
                      ),
                    ),
                    onPressed: () {
                      AuthGoogle().signInWithGoogle();
                      /*final provider =
                    Provider.of<GoogleSignInProvider>(context, listen: false);
                provider.googleLogin();*/
                    },
                  )),
              Container(
                margin: EdgeInsets.symmetric(vertical: 8.0),
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                    onPrimary: HexColor("#5D5FEF"),
                    minimumSize: Size(350, 40),
                  ),
                  icon: FaIcon(FontAwesomeIcons.google), //color:
                  label: Text(
                    'Continue with Google',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      // fontWeight: FontWeight.bold
                    ),
                  ),
                  onPressed: () {
                    AuthGoogle().signInWithGoogle();
                    /*final provider =
                    Provider.of<GoogleSignInProvider>(context, listen: false);
                provider.googleLogin();*/
                  },
                ),
                //Sign In by gmail
              ),
              const SizedBox(height: 10),
              DividerAccount("or", 10),
              const SizedBox(height: 10),
              Container(
                //Sign In Default
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SigninScreen()),
                    );
                  },
                  child: const Text('Sign in with password',
                      style: TextStyle(fontSize: 18)),
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
                child: BottomTitle("Don’t have an account?", "#000000",
                    "  Sign up", "#5D5FEF"),
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
                fontWeight: FontWeight.bold),
          ),
          TextSpan(
              text: SecondTitle,
              style: TextStyle(
                  color: HexColor(SecondTitleColor),
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SignupScreen()),
                  );
                }),
        ]),
      ),
    );
  }
}
