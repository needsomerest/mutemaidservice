import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mutemaidservice/screen/user/UserScreen/IndexScreen.dart';

import '../../screen/HomeScreen.dart';

class AuthGoogle {
  //1. jandleAuthState()
  //Determone if the uer is authenticated
  handleAuthState() {
    return StreamBuilder(
        //stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext context, snapshot) {
      if (snapshot.hasData) {
        return HomeScreen();
      } else {
        return const IndexScreen();
      }
    });
  }

//2. SignInWithGoogle()
  signInWithGoogle() async {
    //Trigger the authentication flow
    final GoogleSignInAccount? googleUser =
        await GoogleSignIn(scopes: <String>["email"]).signIn(); //GoogleSignIn

    //Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth =
        await googleUser!.authentication;

    //Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    //one sign in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  //3. SignOut()
  signOut() {
    FirebaseAuth.instance.signOut();
  }
}
