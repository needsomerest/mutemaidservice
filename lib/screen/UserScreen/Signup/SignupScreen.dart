import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:mutemaidservice/component/DividerAccount.dart';
import 'package:mutemaidservice/component/HeaderAccount.dart';
import 'package:mutemaidservice/model/AuthService/AuthGoogle.dart';
import 'package:mutemaidservice/model/auth.dart';
import 'package:mutemaidservice/screen/Signin/SigninScreen.dart';
import 'package:path/path.dart';

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  static const String _title = 'Sign Up | MCS Service';

  String? errorMessages = '';
  String? imageurl;
  String _emailAddress = '';
  String _password = '';

  final TextEditingController _controllersEmail = TextEditingController();
  final TextEditingController _controllersPassword = TextEditingController();
  final TextEditingController _controllersFirstName = TextEditingController();
  final TextEditingController _controllersLastName = TextEditingController();
  final TextEditingController _controllersDateOfBirth = TextEditingController();
  final TextEditingController _controllersPhoneNumber = TextEditingController();
  final TextEditingController _controllersGender = TextEditingController();
  final TextEditingController _controllersRegion = TextEditingController();

/*                    final email = _controllersEmail.text;
                    final password = _controllersPassword.text;
                    final firstname = _controllersFirstName.text;
                    final lastname = _controllersLastName.text;
                    final dob = _controllersDateOfBirth.text;
                    final phonenumber = _controllersPhoneNumber.text;
                    final gender = _controllersGender.text;*/

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Gallery'),
                      onTap: () {
                        imgFromGallery();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      imgFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  Future createUser(
      {required String? profileimage,
      required String email,
      required String password,
      required String firstname,
      required String lastname,
      required String dob,
      required String phonenumber,
      required String region,
      required gender}) async {
    final docUser = await FirebaseFirestore.instance.collection('User').doc();

    final json = {
      'UserID': docUser.id,
      'Email': email,
      'Password': password,
      'FirstName': firstname,
      'LastName': lastname,
      'DateOfBirth': dob,
      'PhoneNumber': phonenumber,
      'profileImage': profileimage,
      'Region': region,
    };

    await docUser.set(json);
    createUserWithEmailAndPassword();
  }

  Future<void> createUserWithEmailAndPassword() async {
    try {
      await Auth().createUserWithEmailAndPassword(
        email: _controllersEmail.text,
        password: _controllersPassword.text,
      );
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessages = e.message;
      });
    }
  }

  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  File? _photo;
  final ImagePicker _picker = ImagePicker();

  Future imgFromGallery() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _photo = File(pickedFile.path);
        uploadFile();
      } else {
        print('No image selected.');
      }
    });
  }

  Future imgFromCamera() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _photo = File(pickedFile.path);
        uploadFile();
      } else {
        print('No image selected.');
      }
    });
  }

  Future uploadFile() async {
    if (_photo == null) return;
    final fileName = basename(_photo!.path);
    final destination = 'UserImage/$fileName';

    try {
      final ref = firebase_storage.FirebaseStorage.instance
          .ref(destination)
          .child('UserImage/');
      await ref.putFile(_photo!);
      imageurl = await ref.getDownloadURL();
    } catch (e) {
      print('error occured');
    }
  }

  bool value = false;
  bool _isObscure = true;
  bool shouldCheck = false;
  get alignment => null;

  final List<String> genderItems = ['Male', 'Female', 'Other'];
  final List<String> regionItems = [
    'พุทธ',
    'อิสลาม',
    'คริสต์',
    'ไม่มีศาสนา',
    'อื่นๆ'
  ];
  String? selectedValue;
  String? selectedRegion;
  String? selectedDate;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) => Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 60),
            child: Column(children: [
              HeaderAccount("Create your Account", 40, "#000000"),
              /*GestureDetector(
                onTap: () {
                  _showPicker(context);
                },
                child: CircleAvatar(
                  radius: 60,
                  backgroundColor: HexColor("#5D5FEF"),
                  child: _photo != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: Image.file(
                            _photo!,
                            width: 110,
                            height: 110,
                            fit: BoxFit.fitHeight,
                          ),
                        )
                      : Container(
                          decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(50)),
                          width: 120,
                          height: 120,
                          child: Icon(
                            Icons.camera_alt,
                            color: Colors.grey[800],
                          ),
                        ),
                ),
              ),*/
              Container(
                child: Column(
                  children: [
                    const SizedBox(height: 20),

                    /*
                    CircleAvatar(
                      radius: 70,
                      backgroundImage: AssetImage('assets/images/profile.png'),
                      backgroundColor: HexColor("#5D5FEF"),
                      child: Stack(children: [
                        Align(
                          alignment: Alignment.bottomRight,
                          child: CircleAvatar(
                              radius: 22,
                              backgroundColor: HexColor("#DFDFFC"),
                              child: IconButton(
                                icon: Icon(Icons.camera_alt),
                                onPressed: () {
                                  UploadImageScreen();
                                },
                              )),
                        ),
                      ]),
                    ),*/
                    SizedboxHeaderForm("อีเมล : "),
                    TextFormField(
                      controller: _controllersEmail,
                      cursorColor: HexColor("#5D5FEF"),
                      textAlign: TextAlign.left,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          isDense: true, // Added this
                          contentPadding: EdgeInsets.all(14),
                          /*prefixIcon: Icon(
                            Icons.email,
                            color: Colors.black,
                          ),*/
                          hintText: 'Email',
                          hintStyle: TextStyle(fontSize: 14),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(60.0),
                            borderSide: BorderSide(
                              width: 0,
                              style: BorderStyle.none,
                              //fixedSize: MaterialStateProperty.all(const Size(350, 40)),
                            ),
                          ),
                          filled: true,
                          fillColor: HexColor("#DFDFFC"),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(60.0),
                            borderSide: BorderSide(
                              color: HexColor("#5D5FEF"),

                              //fixedSize: MaterialStateProperty.all(const Size(350, 40)),
                            ),
                          )),
                    ),
                    SizedboxHeaderForm("รหัสผ่าน : "),
                    TextFormField(
                      controller: _controllersPassword,
                      cursorColor: HexColor("#5D5FEF"),
                      textAlign: TextAlign.left,
                      obscureText: _isObscure,
                      keyboardType: TextInputType.visiblePassword,
                      decoration: InputDecoration(
                          isDense: true, // Added this
                          contentPadding: EdgeInsets.all(14),
                          /* prefixIcon: Icon(
                            Icons.lock,
                            color: Colors.black,
                          ),*/
                          hintText: 'Password',
                          hintStyle: TextStyle(fontSize: 14),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(60.0),
                            borderSide: BorderSide(
                              width: 0,
                              style: BorderStyle.none,
                              //fixedSize: MaterialStateProperty.all(const Size(350, 40)),
                            ),
                          ),
                          filled: true,
                          fillColor: HexColor("DFDFFC"),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(60.0),
                            borderSide: BorderSide(
                              color: HexColor("#5D5FEF"),

                              //fixedSize: MaterialStateProperty.all(const Size(350, 40)),
                            ),
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(_isObscure
                                ? Icons.visibility
                                : Icons.visibility_off),
                            color: HexColor("#5D5FEF"),
                            onPressed: () {
                              setState(() {
                                _isObscure = !_isObscure;
                              });
                            },
                          )),
                    ),
                    SizedboxHeaderForm("ชื่อจริง : "),
                    TextFormField(
                      controller: _controllersFirstName,
                      cursorColor: HexColor("#5D5FEF"),
                      textAlign: TextAlign.left,
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                          isDense: true, // Added this
                          contentPadding: EdgeInsets.all(14),
                          hintText: 'First name',
                          hintStyle: TextStyle(fontSize: 14),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(60.0),
                            borderSide: BorderSide(
                              width: 0,
                              style: BorderStyle.none,
                            ),
                          ),
                          filled: true,
                          fillColor: HexColor("DFDFFC"),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(60.0),
                            borderSide: BorderSide(
                              color: HexColor("#5D5FEF"),
                              //fixedSize: MaterialStateProperty.all(const Size(350, 40)),
                            ),
                          )),
                    ),
                    SizedboxHeaderForm("นามสกุล : "),
                    TextFormField(
                      controller: _controllersLastName,
                      cursorColor: HexColor("#5D5FEF"),
                      textAlign: TextAlign.left,
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                          isDense: true, // Added this
                          contentPadding: EdgeInsets.all(14),
                          hintText: 'Last name',
                          hintStyle: TextStyle(fontSize: 14),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(60.0),
                            borderSide: BorderSide(
                              width: 0,
                              style: BorderStyle.none,
                            ),
                          ),
                          filled: true,
                          fillColor: HexColor("DFDFFC"),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(60.0),
                            borderSide: BorderSide(
                              color: HexColor("#5D5FEF"),
                              //fixedSize: MaterialStateProperty.all(const Size(350, 40)),
                            ),
                          )),
                    ),
                    SizedboxHeaderForm("วัน/เดือน/ปี เกิด : "),
                    TextFormField(
                      controller: _controllersDateOfBirth,
                      cursorColor: HexColor("#5D5FEF"),
                      textAlign: TextAlign.left,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          isDense: true, // Added this
                          contentPadding: EdgeInsets.all(14),
                          hintText: 'Date of Birth',
                          hintStyle: TextStyle(fontSize: 14),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(60.0),
                            borderSide: BorderSide(
                              width: 0,
                              style: BorderStyle.none,
                            ),
                          ),
                          filled: true,
                          fillColor: HexColor("DFDFFC"),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(60.0),
                            borderSide: BorderSide(
                              color: HexColor("#5D5FEF"),
                              //fixedSize: MaterialStateProperty.all(const Size(350, 40)),
                            ),
                          ),
                          suffixIcon: Icon(
                            Icons.date_range_outlined,
                            color: HexColor("#5D5FEF"),
                          )),
                      readOnly: true, // when true user cannot edit text
                      onTap: () async {
                        DateTime? pickeddate = await DatePicker.showDatePicker(
                            context,
                            showTitleActions: true,
                            minTime: DateTime(1960, 12, 31),
                            maxTime: DateTime(2022, 12, 31), onChanged: (date) {
                          print('change $date');
                        }, onConfirm: (date) {
                          print('confirm $date');
                        }, currentTime: DateTime.now(), locale: LocaleType.th);

                        if (pickeddate != null) {
                          setState(() {
                            _controllersDateOfBirth.text =
                                DateFormat.yMMMMd('en_US').format(pickeddate);
                          });
                        }
                      },
                    ),
                    SizedboxHeaderForm("ศาสนา : "),
                    DropdownButtonFormField2(
                      searchController: _controllersRegion,
                      decoration: InputDecoration(
                        isDense: true, // Added this
                        contentPadding: EdgeInsets.all(0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(60.0),
                          borderSide: BorderSide(
                            width: 0,
                            style: BorderStyle.none,
                          ),
                        ),
                        filled: true,
                        fillColor: HexColor("DFDFFC"),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(60.0),
                          borderSide: BorderSide(
                            color: HexColor("#5D5FEF"),
                            //fixedSize: MaterialStateProperty.all(const Size(350, 40)),
                          ),
                        ),
                      ),
                      isExpanded: true,
                      hint: const Text(
                        'Select Your Region',
                        style: TextStyle(fontSize: 14),
                      ),
                      icon: Icon(
                        Icons.arrow_drop_down,
                        color: HexColor("#5D5FEF"),
                      ),
                      iconSize: 30,
                      buttonHeight: 60,
                      buttonPadding: const EdgeInsets.only(left: 20, right: 10),
                      dropdownDecoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: HexColor("#DFDFFC"),
                      ),
                      items: regionItems
                          .map((item) => DropdownMenuItem<String>(
                                value: item,
                                child: Text(
                                  item,
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                              ))
                          .toList(),
                      validator: (value) {
                        if (value == null) {
                          return 'Please select region.';
                        }
                      },
                      onChanged: (value) {
                        //Do something when changing the item if you want.
                      },
                      onSaved: (value) {
                        selectedRegion = value.toString();
                      },
                    ),
                    const SizedBox(height: 30),
                    SizedboxHeaderForm("หมายเลขโทรศัพท์ : "),
                    TextFormField(
                      controller: _controllersPhoneNumber,
                      cursorColor: HexColor("#5D5FEF"),
                      textAlign: TextAlign.left,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                          isDense: true, // Added this
                          contentPadding: EdgeInsets.all(14),
                          hintText: 'Phone Number',
                          hintStyle: TextStyle(fontSize: 14),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(60.0),
                            borderSide: BorderSide(
                              width: 0,
                              style: BorderStyle.none,
                            ),
                          ),
                          filled: true,
                          fillColor: HexColor("DFDFFC"),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(60.0),
                            borderSide: BorderSide(
                              color: HexColor("#5D5FEF"),
                              //fixedSize: MaterialStateProperty.all(const Size(350, 40)),
                            ),
                          )),
                    ),
                    SizedboxHeaderForm("เพศ : "),
                    DropdownButtonFormField2(
                      searchController: _controllersGender,
                      decoration: InputDecoration(
                        isDense: true, // Added this
                        contentPadding: EdgeInsets.all(0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(60.0),
                          borderSide: BorderSide(
                            width: 0,
                            style: BorderStyle.none,
                          ),
                        ),
                        filled: true,
                        fillColor: HexColor("DFDFFC"),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(60.0),
                          borderSide: BorderSide(
                            color: HexColor("#5D5FEF"),
                            //fixedSize: MaterialStateProperty.all(const Size(350, 40)),
                          ),
                        ),
                      ),
                      isExpanded: true,
                      hint: const Text(
                        'Select Your Gender',
                        style: TextStyle(fontSize: 14),
                      ),
                      icon: Icon(
                        Icons.arrow_drop_down,
                        color: HexColor("#5D5FEF"),
                      ),
                      iconSize: 30,
                      buttonHeight: 60,
                      buttonPadding: const EdgeInsets.only(left: 20, right: 10),
                      dropdownDecoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: HexColor("#DFDFFC"),
                      ),
                      items: genderItems
                          .map((item) => DropdownMenuItem<String>(
                                value: item,
                                child: Text(
                                  item,
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                              ))
                          .toList(),
                      validator: (value) {
                        if (value == null) {
                          return 'Please select gender.';
                        }
                      },
                      onChanged: (value) {
                        //Do something when changing the item if you want.
                      },
                      onSaved: (value) {
                        selectedValue = value.toString();
                      },
                    ),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
              Container(
                child: ElevatedButton(
                  onPressed: () {
                    final email = _controllersEmail.text;
                    final password = _controllersPassword.text;
                    final firstname = _controllersFirstName.text;
                    final lastname = _controllersLastName.text;
                    final dob = _controllersDateOfBirth.text;
                    final phonenumber = _controllersPhoneNumber.text;
                    final gender = _controllersGender.text;
                    final region = _controllersRegion.text;
                    //final filename = fileName.text;
                    createUser(
                        profileimage: imageurl,
                        email: email,
                        password: password,
                        firstname: firstname,
                        lastname: lastname,
                        dob: dob,
                        phonenumber: phonenumber,
                        gender: gender,
                        region: region);
                    //createUserWithEmailAndPassword();
                    /* signInWithEmailAndPassword();
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RegisterProfile()),
                  );*/
                  },
                  child: const Text('Sign up', style: TextStyle(fontSize: 18)),
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(HexColor("5D5FEF")),
                    fixedSize: MaterialStateProperty.all(const Size(300, 50)),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 50),
              DividerAccount("or continue with", 10),
              Container(
                child: ButtonBar(
                  alignment: MainAxisAlignment.center,
                  children: [
                    OutlinedButton(
                      // facebook button
                      onPressed: () {
                        AuthGoogle().signInWithGoogle();
                      },
                      child: FaIcon(FontAwesomeIcons.facebook),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.white,
                        onPrimary: HexColor("#5D5FEF"),
                        minimumSize: Size(50, 50),
                      ),
                    ),
                    OutlinedButton(
                      //google button
                      onPressed: () {
                        AuthGoogle().signInWithGoogle();
                      },
                      child: FaIcon(FontAwesomeIcons.google),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.white,
                        onPrimary: HexColor("#5D5FEF"),
                        minimumSize: Size(50, 50),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              BottomSignup(
                  "Already have an account?  ", "#000000", "Sign in", "#5D5FEF")
            ]),
          ),
        ),
      );
}

class BottomSignup extends StatelessWidget {
  String FirstTitle;
  String FistTitleColor;
  String SecondTitle;
  String SecondTitleColor;

  BottomSignup(this.FirstTitle, this.FistTitleColor, this.SecondTitle,
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
                    MaterialPageRoute(builder: (context) => SigninScreen()),
                  );
                }),
        ]),
      ),
    );
  }
}

class SizedboxHeaderForm extends StatelessWidget {
  String title;

  SizedboxHeaderForm(this.title);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40.0,
      child: Align(
        alignment: Alignment.bottomLeft,
        child: HeaderAccount(title, 14, "#000000"),
      ),
    );
  }
}
