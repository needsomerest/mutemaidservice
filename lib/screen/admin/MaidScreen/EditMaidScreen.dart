import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
// import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:mutemaidservice/component/InfoJobAtom.dart';
import 'package:mutemaidservice/model/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:intl/intl.dart';
import 'package:mutemaidservice/screen/HomeScreen.dart';
import 'package:mutemaidservice/screen/admin/HomeScreen/HomeScreen.dart';
import 'package:mutemaidservice/screen/housekeeper/HomeScreen/HomeMaidScreen.dart';
import 'package:path/path.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import '../../user/UserScreen/Signup/SignupScreen.dart';

class EditMaidScreen extends StatefulWidget {
  String HousekeeperID;
  EditMaidScreen(this.HousekeeperID);
  // const EditScreen({super.key});

  @override
  State<EditMaidScreen> createState() => _EditMaidScreenState();
}

class _EditMaidScreenState extends State<EditMaidScreen> {
  static const String _title = 'Edit Profile | Mute Maid Service';
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  String? errorMessages = '';
  String imageurl = '';
  String _password = '';
  final User? user = Auth().currentUser;
  List<String> _selecteddate = [];

  final TextEditingController _controllersFirstName = TextEditingController();
  final TextEditingController _controllersLastName = TextEditingController();
  final TextEditingController _controllersDateOfBirth = TextEditingController();
  final TextEditingController _controllersPhoneNumber = TextEditingController();
  final TextEditingController _controllersGender = TextEditingController();
  final TextEditingController _controllersRegion = TextEditingController();

  final List<String> genderItems = ['Male', 'Female', 'Other'];
  final List<String> regionItems = [
    'พุทธ',
    'อิสลาม',
    'คริสต์',
    'ไม่มีศาสนา',
    'อื่นๆ'
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

  // String selectedGender = "อื่นๆ";
  // String selectedRegion = "อื่นๆ";
  String? selectedDate;

  final snackBarUpdateProfileDone =
      SnackBar(content: const Text('แก้ไขข้อมูลแม่บ้านสำเร็จ'));
  final snackBarUpdateProfileFail =
      SnackBar(content: const Text('ไม่สามารถแก้ไขข้อมูลได้'));

  Future updatemaid({
    required String useruid,
    required String fname,
    required String lname,
    required String dob,
    required String region,
    required String phonenumber,
    required String gender,
    required List<String> date,
  }) async {
    var collection = await FirebaseFirestore.instance
        .collection('Housekeeper')
        .doc(useruid)
        .update({
      'PhoneNumber': phonenumber,
      'Region': region,
      'FirstName': fname,
      'LastName': lname,
      'DateOfBirth': dob,
      'Gender': gender,
      'DateAvailable': date,
    }).then((result) {
      print("new User true");
    }).catchError((onError) {
      print("onError");
    });
  }

  Future<bool> userExists(phonenumber) async {
    return await FirebaseFirestore.instance
        .collection('Housekeeper')
        .where('PhoneNumber', isEqualTo: phonenumber)
        .get()
        .then((value) => value.size > 1 ? true : false);
  }

  Future<List<Map<String, dynamic>>> getDataFromFirebase() async {
    List<Map<String, dynamic>> data = [];

    // Query the User collection for a document that contains the Reservation with the given ID
    DocumentSnapshot<Map<String, dynamic>> userSnapshot =
        await FirebaseFirestore.instance
            .collection('Housekeeper')
            .doc(widget.HousekeeperID)
            .get();
    Map<String, dynamic> UserData = userSnapshot.data()!;
    data.add(UserData);

    print(
        'Number of User documents with Reservation ${widget.HousekeeperID}: ${userSnapshot.data()}');

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
    print(dataList[0]['DateAvailable']);
    setState(() {
      _selecteddate = List<String>.from(dataList[0]['DateAvailable']);
    });
    print(dataList);
    // print(dataList);
  }

  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  File? _photo;
  final ImagePicker _picker = ImagePicker();

  final snackBarUpPaymentFail =
      SnackBar(content: const Text('Image upload error. Please try again.'));
  final snackBarUpPaymentDone =
      SnackBar(content: const Text('Image uploaded successfully.'));

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
    String selectedGender = dataList[0]['Gender'];
    String selectedRegion = dataList[0]['Region'];
    // final _uid = widget.HousekeeperID;
    // final data = getUser(_uid);
    // getData(_uid);
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
          title: Text('แก้ไขข้อมูลส่วนตัว',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        ),
        body: SingleChildScrollView(
            child: SingleChildScrollView(
          child: Container(
            height: 1150,
            width: double.infinity,
            // alignment: Alignment.center,
            child: dataList.isEmpty
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      // StreamBuilder(
                      //   stream: FirebaseFirestore.instance
                      //       .collection('messages')
                      //       .snapshots(),
                      //   builder: (context, snapshot) {
                      //     if (snapshot.hasError) {
                      //       return Center(
                      //         child: Text(snapshot.error.toString()),
                      //       );
                      //     }
                      //     if (snapshot.hasData) {
                      //       final messages = snapshot.data!.docs;
                      //       List<Text> messageWigdets = [];
                      //       for (var message in messages) {
                      //         final messageText = message['text'];
                      //         final messageSender = message['sender'];
                      //         final messageWigdet =
                      //             Text('$messageText from $messageSender');
                      //         messageWigdets.add(messageWigdet);
                      //       }
                      //       return Expanded(
                      //         child: ListView(
                      //           children: [...messageWigdets],
                      //         ),
                      //       );
                      //     }
                      //     return const CircularProgressIndicator.adaptive();
                      //   },
                      // ),
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
                      //               // margin: EdgeInsets.all(20),
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
                      // SizedBox(
                      //   height: 20,
                      // ),
                      Container(
                          // margin: EdgeInsets.only(top: 30),
                          height: 1150,
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
                                // Text(
                                //   'แก้ไขข้อมูลส่วนตัว',
                                //   style: TextStyle(
                                //       fontSize: 18,
                                //       color: Colors.black,
                                //       fontWeight: FontWeight.bold),
                                //   textAlign: TextAlign.left,
                                // ),
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
                                      hintText: '${dataList[0]['FirstName']}',
                                      hintStyle: TextStyle(fontSize: 14),
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(60.0),
                                        borderSide: BorderSide(
                                          width: 0,
                                          style: BorderStyle.none,
                                          //fixedSize: MaterialStateProperty.all(const Size(350, 40)),
                                        ),
                                      ),
                                      filled: true,
                                      fillColor: HexColor("#DFDFFC"),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(60.0),
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
                                      hintText: '${dataList[0]['LastName']}',
                                      hintStyle: TextStyle(fontSize: 14),
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(60.0),
                                        borderSide: BorderSide(
                                          width: 0,
                                          style: BorderStyle.none,
                                          //fixedSize: MaterialStateProperty.all(const Size(350, 40)),
                                        ),
                                      ),
                                      filled: true,
                                      fillColor: HexColor("#DFDFFC"),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(60.0),
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
                                      hintText: "${dataList[0]['DateOfBirth']}",
                                      hintStyle: TextStyle(fontSize: 14),
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(60.0),
                                        borderSide: BorderSide(
                                          width: 0,
                                          style: BorderStyle.none,
                                        ),
                                      ),
                                      filled: true,
                                      fillColor: HexColor("DFDFFC"),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(60.0),
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
                                SizedboxHeaderForm("หมายเลขโทรศัพท์ : "),
                                TextFormField(
                                  controller: _controllersPhoneNumber,
                                  cursorColor: HexColor("#5D5FEF"),
                                  textAlign: TextAlign.left,
                                  keyboardType: TextInputType.phone,
                                  decoration: InputDecoration(
                                      icon: Icon(
                                        Icons.call,
                                        color: HexColor("#5D5FEF"),
                                        size: 45,
                                      ),
                                      isDense: true, // Added this
                                      contentPadding: EdgeInsets.all(14),
                                      hintText: '${dataList[0]['PhoneNumber']}',
                                      hintStyle: TextStyle(fontSize: 14),
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(60.0),
                                        borderSide: BorderSide(
                                          width: 0,
                                          style: BorderStyle.none,
                                        ),
                                      ),
                                      filled: true,
                                      fillColor: HexColor("DFDFFC"),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(60.0),
                                        borderSide: BorderSide(
                                          color: HexColor("#5D5FEF"),
                                          //fixedSize: MaterialStateProperty.all(const Size(350, 40)),
                                        ),
                                      )),
                                ),
                                SizedboxHeaderForm("ศาสนา : "),
                                DropdownButtonFormField2(
                                  searchController: _controllersRegion,
                                  decoration: InputDecoration(
                                    icon: Icon(
                                      Icons.church,
                                      color: HexColor("#5D5FEF"),
                                      size: 45,
                                    ),
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
                                  buttonPadding: const EdgeInsets.only(
                                      left: 20, right: 10),
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
                                      return 'Please select region.';
                                    }
                                    return null;
                                  },
                                  value: selectedRegion,
                                  onChanged: (value) {
                                    selectedRegion = value as String;
                                  },
                                  onSaved: (value) {
                                    selectedRegion = value.toString();
                                  },
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
                                  buttonPadding: const EdgeInsets.only(
                                      left: 20, right: 10),
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
                                SizedboxHeaderForm(
                                    "วันที่แม่บ้านไม่สะดวกรับงาน: "),
                                Container(
                                  height: 400,
                                  decoration: BoxDecoration(
                                      color: HexColor('#DFDFFC'),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(40))),
                                  child: Column(
                                    children: _optionsdate //_optionsdate
                                        .map(
                                          (date) => CheckboxListTile(
                                            title: Text(date),
                                            value: _selecteddate.contains(date),
                                            onChanged: (selected) =>
                                                // {
                                                //   if (selected!) {
                                                //     setState(() {
                                                //       _selecteddate.add(date);
                                                //     });
                                                //   } else {
                                                //     setState(() {
                                                //       _selecteddate.remove(date);
                                                //     });
                                                //   }
                                                // }
                                                _ondateSelected(
                                                    selected!, date),
                                          ),
                                        )
                                        .toList(),
                                  ),
                                ),
                                const SizedBox(height: 30),
                                Center(
                                  child: ElevatedButton(
                                    onPressed: () async {
                                      if (_controllersDateOfBirth
                                          .text.isEmpty) {
                                        _controllersDateOfBirth.text =
                                            "${dataList[0]['DateOfBirth']}";
                                      }
                                      if (_controllersFirstName.text.isEmpty) {
                                        _controllersFirstName.text =
                                            "${dataList[0]['FirstName']}";
                                      }
                                      if (_controllersLastName.text.isEmpty) {
                                        _controllersLastName.text =
                                            "${dataList[0]['LastName']}";
                                      }
                                      if (_controllersPhoneNumber
                                          .text.isEmpty) {
                                        _controllersPhoneNumber.text =
                                            "${dataList[0]['PhoneNumber']}";
                                      }
                                      if (_controllersGender.text.isEmpty) {
                                        _controllersGender.text =
                                            "${dataList[0]['Gender']}";
                                      }
                                      if (_controllersRegion.text.isEmpty) {
                                        _controllersRegion.text =
                                            "${dataList[0]['Region']}";
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
                                      updatemaid(
                                          useruid: widget.HousekeeperID,
                                          fname: firstname,
                                          lname: lastname,
                                          dob: dob,
                                          phonenumber: phonenumber,
                                          gender: selectedGender.toString(),
                                          region: selectedRegion.toString(),
                                          date: _selecteddate);
                                      // await FirebaseAuth.instance.currentUser
                                      //     ?.updateDisplayName(
                                      //         firstname + ' ' + lastname);
                                      // /* await FirebaseAuth.instance.currentUser
                                      //     ?.updatePhotoURL(imageurl);*/
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                              snackBarUpdateProfileDone);
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  HomeAdminScreen()));
                                    },
                                    child: const Text('ยืนยัน',
                                        style: TextStyle(fontSize: 18)),
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              HexColor("5D5FEF")),
                                      fixedSize: MaterialStateProperty.all(
                                          const Size(100, 50)),
                                      shape: MaterialStateProperty.all(
                                        RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(30),
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
        )));
  }
}
