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
import 'package:mutemaidservice/screen/admin/MaidScreen/AddSuccess.dart';
import 'package:mutemaidservice/screen/user/Signin/SigninScreen.dart';
import 'package:path/path.dart';
import 'package:email_validator/email_validator.dart';
import 'package:validators/validators.dart';

class AddMaidScreen extends StatefulWidget {
  @override
  _AddMaidScreenState createState() => _AddMaidScreenState();
}

class _AddMaidScreenState extends State<AddMaidScreen> {
  static const String _title = 'Sign Up | Mute Maid Service';
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  String? errorMessages = '';
  String imageurl =
      'https://firebasestorage.googleapis.com/v0/b/mutemaidservice-5c04b.appspot.com/o/UserImage%2Fprofile.png?alt=media&token=71e218a0-8801-4cf4-bdd6-2b5b91fdd88c';
  String _password = '';
  String _uid = '';

  // final TextEditingController _controllersEmail = TextEditingController();
  // final TextEditingController _controllersPassword = TextEditingController();
  final TextEditingController _controllersFirstName = TextEditingController();
  final TextEditingController _controllersLastName = TextEditingController();
  final TextEditingController _controllersDateOfBirth = TextEditingController();
  final TextEditingController _controllersPhoneNumber = TextEditingController();
  final TextEditingController _controllersGender = TextEditingController();
  final TextEditingController _controllersRegion = TextEditingController();
  final TextEditingController _controllersListen = TextEditingController();
  final TextEditingController _controllersVaccine = TextEditingController();
  final TextEditingController _controllersBankname = TextEditingController();
  final TextEditingController _controllersBankid = TextEditingController();
  Future createMaid({
    required String profileimage,
    // required String email,
    required String firstname,
    required String lastname,
    required String dob,
    required String phonenumber,
    required String gender,
    required String region,
    required int hearranking,
    required int vaccinated,
    required String commu,
    required String bankname,
    required String bankid,
    required List<String> date,
  }) async {
    final docMaid = await FirebaseFirestore.instance.collection('Housekeeper');

    final json = {
      // 'Email': email,
      'FirstName': firstname,
      'LastName': lastname,
      'DateOfBirth': dob,
      'PhoneNumber': phonenumber,
      'profileImage': profileimage,
      'Gender': gender,
      'Region': region,
      'HearRanking': hearranking,
      'Vaccinated': vaccinated,
      'CommunicationSkill': commu,
      'BankName': bankname,
      'BankID': bankid,
      'Money': 0,
      'DateAvailable': date,
    };
    await docMaid.add(json);

    //createUserWithEmailAndPassword(firstname, lastname, profileimage,phonenumber);
  }

  // final snackInvalidEmailFail = SnackBar(
  //   content: const Text('กรุณากรอกรูปแบบอีเมลให้ถูกต้อง'),
  //   backgroundColor: HexColor("#5D5FEF"),
  // );

  final snackBarEmailAlreadyInuseFail = SnackBar(
    content: const Text('อีเมลดังกล่าวได้ถูกใช้งานแล้ว'),
    backgroundColor: HexColor("#5D5FEF"),
  );

  // final snackBarPasswordFail = SnackBar(
  //   content: const Text('กรุณาตั้งรหัสผ่านมากกว่า 6 ตัวขึ้นไป'),
  //   backgroundColor: HexColor("#5D5FEF"),
  // );
  final snackBarSubmitFail = SnackBar(
    content: const Text('กรุณากรอกข้อมูลทุกช่องเพื่อเพื่อลงทะเบียนผู้ใช้'),
    backgroundColor: HexColor("#5D5FEF"),
  );
  final snackInvalidPhoneNumberFail = SnackBar(
    content: const Text('เบอร์โทรดังกล่าวได้ถูกใช้งานแล้ว'),
    backgroundColor: HexColor("#5D5FEF"),
  );

  // Future<void> createUserWithEmailAndPassword(
  //   String firstname,
  //   String lastname,
  //   String profileimage,
  //   String phonenumber,
  // ) async {
  //   try {
  //     final UserCredential = await Auth().createUserWithEmailAndPassword(
  //         email: _controllersEmail.text.trim(),
  //         password: _controllersPassword.text.trim(),
  //         username: firstname + ' ' + lastname,
  //         img: profileimage);
  //   } on FirebaseAuthException catch (e) {
  //     if (e.code == 'weak-password') {
  //     } else if (e.code == 'email-already-in-use') {
  //       print('อีเมลดังกล่าวได้ถูกใช้งานแล้ว');
  //     }
  //   } catch (e) {
  //     print(e);
  //   }
  // }

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
        print('ไม่พบรูปภาพที่ถูกเลือก');
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
        print('ไม่พบรูปภาพที่ถูกเลือก');
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
      print('มีข้อผิดพลาดบางอย่างเกิดขึ้น กรุณาลองใหม่อีกครั้ง');
    }
  }

  bool value = false;
  bool _isObscure = true;
  bool shouldCheck = false;
  get alignment => null;

  final List<String> genderItems = ['ชาย', 'หญิง', 'อื่นๆ'];
  final List<String> regionItems = [
    'พุทธ',
    'อิสลาม',
    'คริสต์',
    'ไม่มีศาสนา',
    'อื่นๆ'
  ];
  final List<String> ListenItems = ['0', '1', '2', '3', '4', '5'];
  final List<String> VaccineItems = ['0', '1', '2', '3', '4', '5'];
  List<String> _selectedOptions = [];
  List<String> _selecteddate = [];

  final _options = [
    'ภาษามือ',
    'การเขียน',
    'ภาพ',
    'ล่าม',
  ];

  final _optionsdate = [
    'Mon',
    'Tue',
    'Wed',
    'Thu',
    'Fri',
    'Sat',
    'Sun',
  ];

  void _onOptionSelected(bool selected, String option) {
    if (selected) {
      setState(() {
        _selectedOptions.add(option);
      });
    } else {
      setState(() {
        _selectedOptions.remove(option);
      });
    }
  }

  void _ondateSelected(bool selected, String option) {
    if (selected) {
      setState(() {
        _selecteddate.add(option);
      });
    } else {
      setState(() {
        _selecteddate.remove(option);
      });
    }
  }

  String selectedGender = "อื่นๆ";
  String selectedRegion = "อื่นๆ";
  String selectedListen = '0';
  String selectedVaccine = "3";
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

  // String _displayText = 'โปรดระบุรหัสผ่าน';

  // void _checkPassword(String value) {
  //   _password = value.trim();

  //   if (_password.isEmpty) {
  //     setState(() {
  //       _strength = 0;
  //       _displayText = 'โปรดระบุรหัสผ่าน';
  //     });
  //   } else if (_password.length < 6) {
  //     setState(() {
  //       _strength = 1 / 4;
  //       _displayText = 'รหัสผ่านสั้นเกินไป';
  //     });
  //   } else if (_password.length < 8) {
  //     setState(() {
  //       _strength = 2 / 4;
  //       _displayText = 'รหัสผ่านอยู่ในเกณฑ์ไม่รัดกุม';
  //     });
  //   } else {
  //     if (!letterReg.hasMatch(_password) || !numReg.hasMatch(_password)) {
  //       setState(() {
  //         // Password length >= 8
  //         // But doesn't contain both letter and digit characters
  //         _strength = 3 / 4;
  //         _displayText = 'รหัสผ่านอยู่ในเกณฑ์แข็งแรง';
  //       });
  //     } else {
  //       // Password length >= 8
  //       // Password contains both letter and digit characters
  //       setState(() {
  //         _strength = 1;
  //         _displayText = 'รหัสผ่านอยู่ในเกณฑ์ดี';
  //       });
  //     }
  //   }
  // }

  Future<bool> userExists(phonenumber) async {
    return await FirebaseFirestore.instance
        .collection('Housekeeper')
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
              HeaderAccount("ฟอร์มเพิ่มแม่บ้าน ", 40, "#000000"),
              Container(
                child: Column(
                  children: [
                    const SizedBox(height: 20),
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
                    SizedboxHeaderForm("ระดับการได้ยิน : "),
                    DropdownButtonFormField2(
                      searchController: _controllersListen,
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
                        'เลือกระดับการได้ยินของคุณ',
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
                      items: ListenItems.map(
                          (itemListen) => DropdownMenuItem<String>(
                                value: itemListen,
                                child: Text(
                                  itemListen,
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                              )).toList(),
                      validator: (value) {
                        if (value == null) {
                          return 'โปรดเลือกระดับการได้ยินของคุณ';
                        }
                      },
                      value: selectedListen,
                      onChanged: (value) {
                        selectedListen = value as String;
                      },
                      onSaved: (value) {
                        selectedListen = value.toString();
                      },
                    ),
                    SizedboxHeaderForm("รับวัคซีนป้องกันโควิด 19 จำนวน : "),
                    DropdownButtonFormField2(
                      searchController: _controllersVaccine,
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
                        'คุณได้รับวัคซีนมาแล้วกี่เข็ม',
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
                      items: VaccineItems.map(
                          (itemVaccine) => DropdownMenuItem<String>(
                                value: itemVaccine,
                                child: Text(
                                  itemVaccine,
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                              )).toList(),
                      validator: (value) {
                        if (value == null) {
                          return 'โปรดเลือกจำนวนวัคซีนที่คุณเคยได้รับ';
                        }
                      },
                      value: selectedVaccine,
                      onChanged: (value) {
                        selectedVaccine = value as String;
                      },
                      onSaved: (value) {
                        selectedVaccine = value.toString();
                      },
                    ),
                    SizedboxHeaderForm("สื่อสารด้วย: "),
                    Container(
                      height: 230,
                      decoration: BoxDecoration(
                          color: HexColor('#DFDFFC'),
                          borderRadius: BorderRadius.all(Radius.circular(40))),
                      child: Column(
                        children: _options
                            .map(
                              (option) => CheckboxListTile(
                                title: Text(option),
                                value: _selectedOptions.contains(option),
                                onChanged: (selected) =>
                                    _onOptionSelected(selected!, option),
                              ),
                            )
                            .toList(),
                      ),
                    ),
                    SizedboxHeaderForm("วันที่แม่บ้านไม่สะดวกรับงาน: "),
                    Container(
                      height: 400,
                      decoration: BoxDecoration(
                          color: HexColor('#DFDFFC'),
                          borderRadius: BorderRadius.all(Radius.circular(40))),
                      child: Column(
                        children: _optionsdate //_optionsdate
                            .map(
                              (date) => CheckboxListTile(
                                title: Text(date),
                                value: _selecteddate.contains(date),
                                onChanged: (selected) =>
                                    _ondateSelected(selected!, date),
                              ),
                            )
                            .toList(),
                      ),
                    ),
                    SizedboxHeaderForm("ชื่อธนาคาร  : "),
                    TextFormField(
                      controller: _controllersBankname,
                      cursorColor: HexColor("#5D5FEF"),
                      textAlign: TextAlign.left,
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                          isDense: true, // Added this
                          contentPadding: EdgeInsets.all(14),
                          hintText: 'Bank name',
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
                    SizedboxHeaderForm("หมายเลขบัญชี  : "),
                    TextFormField(
                      controller: _controllersBankid,
                      cursorColor: HexColor("#5D5FEF"),
                      textAlign: TextAlign.left,
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                          isDense: true, // Added this
                          contentPadding: EdgeInsets.all(14),
                          hintText: 'Bank ID',
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
                    const SizedBox(height: 30),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  final firstname = _controllersFirstName.text;
                  final lastname = _controllersLastName.text;
                  final dob = _controllersDateOfBirth.text;
                  final phonenumber = _controllersPhoneNumber.text;
                  final bankname = _controllersBankname.text;
                  final bankid = _controllersBankid.text;
                  bool result = await userExists(phonenumber);
                  if (result == false) {
                    createMaid(
                        profileimage: imageurl,
                        // email: email,
                        firstname: firstname,
                        lastname: lastname,
                        dob: dob,
                        phonenumber: phonenumber,
                        gender: selectedGender.toString(),
                        region: selectedRegion.toString(),
                        hearranking: int.parse(selectedListen),
                        vaccinated: int.parse(selectedVaccine),
                        bankid: bankid,
                        bankname: bankname,
                        commu: _selectedOptions.join(', '),
                        date: _selecteddate);

                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => AddSuccess()));
                  } else {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(snackInvalidPhoneNumberFail);
                  }
                },
                child: const Text('บันทึก', style: TextStyle(fontSize: 18)),
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
