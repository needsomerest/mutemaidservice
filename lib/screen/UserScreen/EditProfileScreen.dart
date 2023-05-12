import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_launcher_icons/xml_templates.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:mutemaidservice/model/auth.dart';
import 'package:mutemaidservice/screen/HomeScreen.dart';
import 'package:mutemaidservice/screen/UserScreen/Signup/SignupScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_database/firebase_database.dart';
import 'package:blur/blur.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  static const String _title = 'Edit Profile | Mute Maid Service';
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  String? errorMessages = '';
  String imageurl = '';
  String _password = '';
  String _DateOfBirth = '';
  final User? user = Auth().currentUser;

  final TextEditingController _controllersFirstName = TextEditingController();
  final TextEditingController _controllersLastName = TextEditingController();
  final TextEditingController _controllersDateOfBirth = TextEditingController();
  final TextEditingController _controllersPhoneNumber = TextEditingController();
  final TextEditingController _controllersGender = TextEditingController();
  final TextEditingController _controllersRegion = TextEditingController();

  final List<String> genderItems = ['ชาย', 'หญิง', 'อื่นๆ'];
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

  final snackBarUpdateProfileDone = SnackBar(
      content: const Text('สำเร็จ แก้ไขข้อมูลเสร็จสิ้น'),
      backgroundColor: HexColor("#5D5FEF"));

  final snackBarUpdateProfileFail = SnackBar(
      content: const Text('กรุณาเพิ่มข้อมูลให้ครบทุกช่อง'),
      backgroundColor: HexColor("#5D5FEF"));

  Future updateUser({
    required String useruid,
    required String firstname,
    required String lastname,
    required String dob,
    required String phonenumber,
    required String region,
    required String gender,
    required String profileimage,
  }) async {
    var collection = await FirebaseFirestore.instance
        .collection('User')
        .doc(useruid)
        .update({
      'FirstName': firstname,
      'LastName': lastname,
      'DateOfBirth': dob,
      'PhoneNumber': phonenumber,
      //'profileImage': profileimage,
      'Gender': gender,
      'Region': region,
      'profileimage': profileimage,
    }).then((result) {
      print("Update User true");
    }).catchError((onError) {
      print("onError");
    });
  }

  //FirebaseFirestore.instance.collection("Address").where('UserID', isEqualTo: _uid).snapshots(),

  Future<bool> userExists(phonenumber) async {
    return await FirebaseFirestore.instance
        .collection('User')
        .where('PhoneNumber', isEqualTo: phonenumber)
        .get()
        .then((value) => value.size > 1 ? true : false);
  }

  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  File? _photo;
  final ImagePicker _picker = ImagePicker();

  final snackBarUpPaymentFail = SnackBar(
      content: const Text('ไม่สามารถอัปโหลดรูปภาพได้ โปรดลองอีกครั้ง'));
  final snackBarUpPaymentDone =
      SnackBar(content: const Text('อัพโหลดรูปภาพสำเร็จ'));

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

  Future imgFromGallery() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _photo = File(pickedFile.path);
        uploadFile();
      } else {
        print('ไม่มีรูปที่เลือก');
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
        print('ไม่มีรูปที่เลือก');
      }
    });
  }

  Future uploadFile() async {
    if (_photo == null) return;
    final fileName = basename(_photo!.path);
    final destination = 'AddressImage/$fileName';

    try {
      final ref = firebase_storage.FirebaseStorage.instance
          .ref(destination)
          .child('AddressImage/');
      await ref.putFile(_photo!);
      imageurl = await ref.getDownloadURL();
    } catch (e) {
      print('error occured');
    }
  }

  @override
  Widget build(BuildContext context) {
    final _uid = user?.uid;

    final _oldphoto = user?.photoURL;
    CollectionReference users = FirebaseFirestore.instance.collection('User');

    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(_uid).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;

          _controllersFirstName.text = "${data['FirstName']}";
          _controllersLastName.text = "${data['LastName']}";
          _controllersPhoneNumber.text = "${data['PhoneNumber']}";
          // _controllersDateOfBirth.text = "${data['DateOfBirth']}";
          selectedGender = "${data['Gender']}";
          selectedRegion = "${data['Region']}";
          imageurl = "${data['profileImage']}";
          return Scaffold(
            backgroundColor: HexColor('#5D5FEF'),
            appBar: AppBar(
              elevation: 0.0,
              backgroundColor: HexColor('#5D5FEF'),
              centerTitle: true,
              leading: Icon(
                Icons.keyboard_backspace,
                color: Colors.white,
                size: 30,
              ),
              title: Text('โปรไฟล์',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ),
            body: SingleChildScrollView(
              child: Container(
                height: 930,
                width: double.infinity,
                // alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    GestureDetector(
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
                                  fit: BoxFit.fill,
                                ),
                              )
                            : Container(
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: NetworkImage(_oldphoto!),
                                      fit: BoxFit.fill,
                                    ),
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
                    ),
                    const SizedBox(height: 10),
                    Container(
                        // margin: EdgeInsets.only(top: 30),
                        height: 800,
                        decoration: BoxDecoration(
                            color: HexColor('#FFFFFF'),
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(40),
                                topLeft: Radius.circular(40))),
                        child: Padding(
                          padding: EdgeInsets.all(20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            // mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "แก้ไขข้อมูล",
                                style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                                textAlign: TextAlign.left,
                              ),
                              // Center(
                              //   child: GestureDetector(
                              //     onTap: () {
                              //       /* _showPicker(context);*/
                              //     },
                              //     child: CircleAvatar(
                              //       radius: 60,
                              //       backgroundColor: HexColor("#5D5FEF"),
                              //       child: _photo != null
                              //           ? ClipRRect(
                              //               borderRadius: BorderRadius.circular(50),
                              //               child: Image.file(
                              //                 _photo!,
                              //                 width: 110,
                              //                 height: 110,
                              //                 fit: BoxFit.fitHeight,
                              //               ),
                              //             )
                              //           : Container(
                              //               decoration: BoxDecoration(
                              //                   color: Colors.grey[200],
                              //                   borderRadius:
                              //                       BorderRadius.circular(50)),
                              //               width: 120,
                              //               height: 120,
                              //               child: Icon(
                              //                 Icons.camera_alt,
                              //                 color: Colors.grey[800],
                              //               ),
                              //             ),
                              //     ),
                              //   ),
                              // ),
                              SizedboxHeaderForm("ชื่อจริง : "),
                              TextFormField(
                                controller: _controllersFirstName,
                                cursorColor: HexColor("#5D5FEF"),
                                textAlign: TextAlign.left,
                                keyboardType: TextInputType.name,
                                decoration: InputDecoration(
                                    isDense: true, // Added this
                                    contentPadding: EdgeInsets.all(14),
                                    hintText: 'First Name',
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
                              SizedboxHeaderForm("นามสกุล : "),
                              TextFormField(
                                cursorColor: HexColor("#5D5FEF"),
                                controller: _controllersLastName,
                                textAlign: TextAlign.left,
                                keyboardType: TextInputType.name,
                                decoration: InputDecoration(
                                    isDense: true, // Added this
                                    contentPadding: EdgeInsets.all(14),
                                    hintText: 'Last Name',
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
                              SizedboxHeaderForm("วัน/เดือน/ปี เกิด : "),
                              TextFormField(
                                controller: _controllersDateOfBirth,
                                cursorColor: HexColor("#5D5FEF"),
                                textAlign: TextAlign.left,
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                    isDense: true, // Added this
                                    contentPadding: EdgeInsets.all(14),
                                    hintText: "${data['DateOfBirth']}",
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
                                readOnly:
                                    true, // when true user cannot edit text
                                onTap: () async {
                                  DateTime? pickeddate =
                                      await DatePicker.showDatePicker(context,
                                          showTitleActions: true,
                                          minTime: DateTime(1960, 12, 31),
                                          maxTime: DateTime(2022, 12, 31),
                                          onChanged: (date) {
                                    print('change $date');
                                  }, onConfirm: (date) {
                                    print('confirm $date');
                                  },
                                          currentTime: DateTime.now(),
                                          locale: LocaleType.th);

                                  if (pickeddate != null) {
                                    setState(() {
                                      _controllersDateOfBirth.text =
                                          DateFormat.yMMMMd('en_US')
                                              .format(pickeddate);
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
                                  'โปรดระบุศาสนาของคุณ',
                                  style: TextStyle(fontSize: 14),
                                ),
                                icon: Icon(
                                  Icons.arrow_drop_down,
                                  color: HexColor("#5D5FEF"),
                                ),
                                iconSize: 30,
                                buttonHeight: 60,
                                buttonPadding:
                                    const EdgeInsets.only(left: 20, right: 10),
                                dropdownDecoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: HexColor("#DFDFFC"),
                                ),
                                items: regionItems
                                    .map((itemRegion) =>
                                        DropdownMenuItem<String>(
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
                                    return 'โปรดระบุศาสนาของคุณ';
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
                                  'โปรดระบุเพศของคุณ',
                                  style: TextStyle(fontSize: 14),
                                ),
                                icon: Icon(
                                  Icons.arrow_drop_down,
                                  color: HexColor("#5D5FEF"),
                                ),
                                iconSize: 30,
                                buttonHeight: 60,
                                buttonPadding:
                                    const EdgeInsets.only(left: 20, right: 10),
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
                                    return 'โปรดระบุเพศของคุณ';
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
                              Center(
                                child: ElevatedButton(
                                  onPressed: () async {
                                    if (imageurl == 'null') {
                                      if (_oldphoto == 'null') {
                                        imageurl =
                                            'https://firebasestorage.googleapis.com/v0/b/mutemaidservice-5c04b.appspot.com/o/UserImage%2Fprofile.png?alt=media&token=71e218a0-8801-4cf4-bdd6-2b5b91fdd88c';
                                      }
                                    }

                                    if (_controllersFirstName.text.isEmpty ||
                                        _controllersLastName.text.isEmpty ||
                                        _controllersPhoneNumber.text.isEmpty) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                              snackBarUpdateProfileFail);
                                    } else {
                                      if (_controllersDateOfBirth
                                          .text.isEmpty) {
                                        _controllersDateOfBirth.text =
                                            "${data['DateOfBirth']}";
                                      }
                                      final firstname =
                                          _controllersFirstName.text;
                                      final lastname =
                                          _controllersLastName.text;
                                      final dob = _controllersDateOfBirth.text;
                                      final phonenumber =
                                          _controllersPhoneNumber.text;
                                      final gender = _controllersGender.text;
                                      final region = _controllersRegion.text;

                                      //bool result = await userExists(phonenumber);
                                      //if (result == false) {
                                      updateUser(
                                        useruid: _uid.toString(),
                                        firstname: firstname,
                                        lastname: lastname,
                                        dob: dob,
                                        phonenumber: phonenumber,
                                        gender: selectedGender.toString(),
                                        region: selectedRegion.toString(),
                                        profileimage: imageurl,
                                      );

                                      await FirebaseAuth.instance.currentUser
                                          ?.updateDisplayName(
                                              firstname + ' ' + lastname);

                                      await FirebaseAuth.instance.currentUser
                                          ?.updatePhotoURL(imageurl.toString());

                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                              snackBarUpdateProfileDone);
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  HomeScreen()));
                                    }
                                  },
                                  child: const Text('ยืนยัน',
                                      style: TextStyle(fontSize: 18)),
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                        HexColor("5D5FEF")),
                                    fixedSize: MaterialStateProperty.all(
                                        const Size(300, 50)),
                                    shape: MaterialStateProperty.all(
                                      RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        )),
                  ],
                ),
              ),
            ),
          );

          //  Text("Full Name: ${data['PhoneNumber']}");
        }

        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
