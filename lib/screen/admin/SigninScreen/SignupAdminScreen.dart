import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:mutemaidservice/component/DividerAccount.dart';
import 'package:mutemaidservice/component/HeaderAccount.dart';
import 'package:mutemaidservice/model/AuthService/AuthGoogle.dart';
import 'package:mutemaidservice/model/auth.dart';
import 'package:mutemaidservice/screen/user/Signin/SigninScreen.dart';
import 'package:path/path.dart';
import 'package:email_validator/email_validator.dart';
import 'package:validators/validators.dart';
import 'package:regexpattern/regexpattern.dart';

class SignupAdminScreen extends StatefulWidget {
  @override
  _SignupAdminScreenState createState() => _SignupAdminScreenState();
}

class _SignupAdminScreenState extends State<SignupAdminScreen> {
  static const String _title = 'Sign Up | Mute Maid Service';
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  String? errorMessages = '';
  String imageurl =
      'https://firebasestorage.googleapis.com/v0/b/mutemaidservice-5c04b.appspot.com/o/UserImage%2Fprofile.png?alt=media&token=71e218a0-8801-4cf4-bdd6-2b5b91fdd88c';
  String _password = '';
  String _uid = '';

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

  Future createUser({
    required String useruid,
    required String profileimage,
    required String email,
    required String password,
    required String firstname,
    required String lastname,
    required String dob,
    required String phonenumber,
    required String gender,
    required String region,
  }) async {
    final docUser =
        await FirebaseFirestore.instance.collection('Admin').doc(useruid);

    final json = {
      'UserID': docUser.id,
      'Email': email,
      'Password': password,
      'FirstName': firstname,
      'LastName': lastname,
      'DateOfBirth': dob,
      'PhoneNumber': phonenumber,
      'profileImage': profileimage,
      'Gender': gender,
      'Region': region,
    };
    await docUser.set(json);

    //createUserWithEmailAndPassword(firstname, lastname, profileimage,phonenumber);
  }

  final snackBarEmailFail = SnackBar(
      content: const Text('The account already exists for that email.'));
  final snackBarPasswordFail = SnackBar(
      content: const Text(
          'The password is too weak. Please enter more than 6 characters.'));
  final snackBarPhoneNumberFail = SnackBar(
      content: const Text('The account already exists for that phone number.'));

  Future<void> createUserWithEmailAndPassword(
    String firstname,
    String lastname,
    String profileimage,
    String phonenumber,
  ) async {
    try {
      final UserCredential = await Auth().createUserWithEmailAndPassword(
          email: _controllersEmail.text.trim(),
          password: _controllersPassword.text.trim(),
          username: firstname + ' ' + lastname,
          img: profileimage);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
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
  String selectedGender = "อื่นๆ";
  String selectedRegion = "อื่นๆ";
  String? selectedDate;
  final _formKey = GlobalKey<FormState>();
  double _strength = 0;
  // 0: No password
  // 1/4: Weak
  // 2/4: Medium
  // 3/4: Strong
  // 1: Great

  RegExp numReg = RegExp(r".*[0-9].*");
  RegExp letterReg = RegExp(r".*[A-Za-z].*");

  String _displayText = 'Please enter a password';

  void _checkPassword(String value) {
    _password = value.trim();

    if (_password.isEmpty) {
      setState(() {
        _strength = 0;
        _displayText = 'Please enter you password';
      });
    } else if (_password.length < 6) {
      setState(() {
        _strength = 1 / 4;
        _displayText = 'Your password is too short';
      });
    } else if (_password.length < 8) {
      setState(() {
        _strength = 2 / 4;
        _displayText = 'Your password is acceptable but not strong';
      });
    } else {
      if (!letterReg.hasMatch(_password) || !numReg.hasMatch(_password)) {
        setState(() {
          // Password length >= 8
          // But doesn't contain both letter and digit characters
          _strength = 3 / 4;
          _displayText = 'Your password is strong';
        });
      } else {
        // Password length >= 8
        // Password contains both letter and digit characters
        setState(() {
          _strength = 1;
          _displayText = 'Your password is great';
        });
      }
    }
  }

  Future<bool> userExists(phonenumber) async {
    return await FirebaseFirestore.instance
        .collection('Admin')
        .where('PhoneNumber', isEqualTo: phonenumber)
        .get()
        .then((value) => value.size > 0 ? true : false);
  }

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
                    Column(
                      children: [
                        SizedboxHeaderForm("รหัสผ่าน : "),
                        TextFormField(
                          controller: _controllersPassword,
                          cursorColor: HexColor("#5D5FEF"),
                          textAlign: TextAlign.left,
                          onChanged: (value) => _checkPassword(value),
                          obscureText: true,
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
                        Text(
                          _displayText,
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.deepPurpleAccent,
                          ),
                        ),
                        // The strength indicator bar
                        LinearProgressIndicator(
                          value: _strength,
                          backgroundColor: Colors.grey[300],
                          color: _strength <= 1 / 4
                              ? Colors.red
                              : _strength == 2 / 4
                                  ? Colors.yellow
                                  : _strength == 3 / 4
                                      ? Colors.blue
                                      : Colors.green,
                          minHeight: 15,
                        ),
                      ],
                    ),
                    SizedboxHeaderForm("ชื่อจริง : "),
                    TextFormField(
                      controller: _controllersFirstName,
                      cursorColor: HexColor("#5D5FEF"),
                      textAlign: TextAlign.left,
                      keyboardType: TextInputType.name,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please Enter Email';
                        } else {
                          return null;
                        }
                      },
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
                          .map((itemRegion) => DropdownMenuItem<String>(
                                value: itemRegion,
                                child: Text(
                                  itemRegion,
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
                      value: selectedRegion,
                      onChanged: (value) {
                        selectedRegion = value as String;
                      },
                      onSaved: (value) {
                        selectedRegion = value.toString();
                      },
                    ),
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
                      items: <String>['ผู้ชาย', 'ผู้หญิง', 'อื่นๆ']
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
                      value: selectedGender,
                      onChanged: (value) {
                        selectedGender = value as String;
                      },
                      onSaved: (value) {
                        selectedGender = value.toString();
                      },
                    ),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
              Container(
                child: ElevatedButton(
                  onPressed: () async {
                    final email = _controllersEmail.text;
                    final password = _controllersPassword.text;
                    final firstname = _controllersFirstName.text;
                    final lastname = _controllersLastName.text;
                    final dob = _controllersDateOfBirth.text;
                    final phonenumber = _controllersPhoneNumber.text;
                    final gender = _controllersGender.text;
                    final region = _controllersRegion.text;
                    //final filename = fileName.text;

                    bool result = await userExists(phonenumber);
                    if (result == false) {
                      bool success = false;
                      try {
                        final userCredential =
                            await _firebaseAuth.createUserWithEmailAndPassword(
                                email: _controllersEmail.text.trim(),
                                password: _controllersPassword.text.trim());
                        User? user = userCredential.user;
                        _uid = user!.uid;
                        await userCredential.user
                            ?.updateDisplayName(firstname + ' ' + lastname);
                        await userCredential.user
                            ?.updatePhotoURL(imageurl.toString());

                        success = true;
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'weak-password') {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(snackBarPasswordFail);
                        } else if (e.code == 'email-already-in-use') {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(snackBarEmailFail);
                        }
                      } catch (e) {
                        print(e);
                      }
                      if (success == true) {
                        createUser(
                            useruid: _uid.toString(),
                            profileimage: imageurl,
                            email: email,
                            password: password,
                            firstname: firstname,
                            lastname: lastname,
                            dob: dob,
                            phonenumber: phonenumber,
                            gender: selectedGender.toString(),
                            region: selectedRegion.toString());
                        //}
                      } else {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(snackBarPhoneNumberFail);
                      }

                      /* createUserWithEmailAndPassword();
                     signInWithEmailAndPassword(); snackBarEmailFail
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RegisterProfile()),
                  );*/
                    }
                    ;
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
                child: Center(
                  child: ButtonBar(
                    alignment: MainAxisAlignment.center,
                    buttonPadding:
                        EdgeInsets.symmetric(horizontal: 30, vertical: 10),
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
