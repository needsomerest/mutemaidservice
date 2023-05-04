import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:mutemaidservice/component/InfoJobAtom.dart';
import 'package:mutemaidservice/model/Data/maidData.dart';
import 'package:mutemaidservice/model/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:intl/intl.dart';
import 'package:mutemaidservice/screen/HomeScreen.dart';
import 'package:mutemaidservice/screen/housekeeper/HomeScreen/HomeMaidScreen.dart';
import 'package:mutemaidservice/screen/housekeeper/MenuScreen/ProfileMaidScreen.dart';
import 'package:path/path.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import '../../user/UserScreen/Signup/SignupScreen.dart';

class EditScreen extends StatefulWidget {
  final Maid maid;
  EditScreen({Key? key, required this.maid}) //required this.addressData
      : super(key: key);

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  // final HousekeeperID = "9U9xNdySRx475ByRhjBw";
  static const String _title = 'Edit Profile | Mute Maid Service';
  // final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  String? errorMessages = '';
  String imageurl = '';
  String _password = '';
  // final User? user = Auth().currentUser;

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
  String selectedGender = "อื่นๆ";
  String selectedRegion = "อื่นๆ";
  String? selectedDate;

  final snackBarUpdateProfileDone =
      SnackBar(content: const Text('สำเร็จ แก้ไขข้อมูลเสร็จสิ้น'));
  final snackBarPhoneExits = SnackBar(
      content: const Text('เบอร์โทรนี้มีอยู่แล้วในระบบ โปรดใส่หมายเลขอื่น'));

  Future updatemaid({
    required String useruid,
    required String phonenumber,
    required String region,
    required String url,
  }) async {
    var collection = await FirebaseFirestore.instance
        .collection('Housekeeper')
        .doc(useruid)
        .update({
      'PhoneNumber': phonenumber,
      'Region': region,
      'profileImage': url
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
        .then((value) => value.size > 0 ? true : false);
  }

  Future getUser(uid) async {
    return await FirebaseFirestore.instance
        .collection("User")
        .doc(uid)
        .get()
        .then(
          (value) => print("Successfully completed"),
          onError: (e) => print("Error completing: $e"),
        );
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
    // getData(_uid);
    return Scaffold(
        backgroundColor: HexColor('#5D5FEF'),
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: HexColor('#5D5FEF'),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(
              Icons.keyboard_backspace,
              color: Colors.white,
              size: 30,
            ),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          ProfileMaidScreen(maid: widget.maid)));
            },
          ),
          title: Text('แก้ไขข้อมูลส่วนตัว',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        ),
        body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("Housekeeper")
              .doc(widget.maid.HousekeeperID)
              .snapshots(),
          builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return SingleChildScrollView(
                child: Container(
                  height: 755,
                  width: double.infinity,
                  // color: Colors.red,
                  // alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Center(
                        child: GestureDetector(
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
                                    // margin: EdgeInsets.all(20),
                                    decoration: BoxDecoration(
                                        color: Colors.grey[200],
                                        borderRadius:
                                            BorderRadius.circular(50)),
                                    width: 120,
                                    height: 120,
                                    child: Icon(
                                      Icons.camera_alt,
                                      color: Colors.grey[800],
                                    ),
                                  ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                          height: 615,
                          decoration: BoxDecoration(
                              color: HexColor('#FFFFFF'),
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(40),
                                  topLeft: Radius.circular(40))),
                          child: Padding(
                            padding: EdgeInsets.all(20.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedboxHeaderForm("ชื่อ - นามสกุล :"),
                                InfoJobAtom("assets/images/maid.png",
                                    "${snapshot.data!.get('FirstName')} ${snapshot.data!.get('LastName')}"),
                                SizedboxHeaderForm("วันเกิด : "),
                                InfoJobAtom("assets/images/birthday-cake.png",
                                    "${snapshot.data!.get('DateOfBirth')}"),
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
                                      hintText:
                                          "${snapshot.data!.get('PhoneNumber')}",
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
                                  hint: Text(
                                    "${snapshot.data!.get('Region')}",
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
                                InfoJobAtom("assets/images/equality.png",
                                    "${snapshot.data!.get('Gender')}"),
                                const SizedBox(height: 30),
                                Center(
                                  child: ElevatedButton(
                                    onPressed: () async {
                                      String phonenumber = "";
                                      String region = "";
                                      if (_controllersPhoneNumber.text == "") {
                                        phonenumber =
                                            snapshot.data!.get('PhoneNumber');
                                      } else {
                                        phonenumber =
                                            _controllersPhoneNumber.text;
                                      }
                                      if (imageurl == "") {
                                        imageurl = widget.maid.ProfileImage;
                                      }
                                      if (_controllersRegion.text == "") {
                                        region = snapshot.data!.get('Region');
                                      } else {
                                        region = _controllersRegion.text;
                                      }

                                      bool result =
                                          await userExists(phonenumber);
                                      if (result == false ||
                                          _controllersPhoneNumber.text == "") {
                                        updatemaid(
                                            useruid: widget.maid.HousekeeperID,
                                            phonenumber: phonenumber,
                                            region: selectedRegion.toString(),
                                            url: imageurl);
                                        widget.maid.ProfileImage = imageurl;
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                                snackBarUpdateProfileDone);
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    HomeMaidScreen(
                                                      maid: widget.maid,
                                                    )));
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(snackBarPhoneExits);
                                      }

                                      // await FirebaseAuth.instance.currentUser
                                      //     ?.updateDisplayName(
                                      //         firstname + ' ' + lastname);
                                      // /* await FirebaseAuth.instance.currentUser
                                      //     ?.updatePhotoURL(imageurl);*/
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
              );
            }
          },
        )
        // SingleChildScrollView(
        //   child: Container(
        //     height: 760,
        //     width: double.infinity,
        //     color: Colors.red,
        //     // alignment: Alignment.center,
        //     child: Column(
        //       mainAxisAlignment: MainAxisAlignment.start,
        //       children: [
        //         Center(
        //           child: GestureDetector(
        //             onTap: () {
        //               /* _showPicker(context);*/
        //             },
        //             child: CircleAvatar(
        //               radius: 60,
        //               backgroundColor: HexColor("#5D5FEF"),
        //               child: _photo != null
        //                   ? ClipRRect(
        //                       borderRadius: BorderRadius.circular(50),
        //                       child: Image.file(
        //                         _photo!,
        //                         width: 110,
        //                         height: 110,
        //                         fit: BoxFit.fitHeight,
        //                       ),
        //                     )
        //                   : Container(
        //                       // margin: EdgeInsets.all(20),
        //                       decoration: BoxDecoration(
        //                           color: Colors.grey[200],
        //                           borderRadius:
        //                               BorderRadius.circular(50)),
        //                       width: 120,
        //                       height: 120,
        //                       child: Icon(
        //                         Icons.camera_alt,
        //                         color: Colors.grey[800],
        //                       ),
        //                     ),
        //             ),
        //           ),
        //         ),
        //         SizedBox(
        //           height: 20,
        //         ),
        //         Container(
        //             height: 615,
        //             decoration: BoxDecoration(
        //                 color: HexColor('#FFFFFF'),
        //                 borderRadius: BorderRadius.only(
        //                     topRight: Radius.circular(40),
        //                     topLeft: Radius.circular(40))),
        //             child: Padding(
        //               padding: EdgeInsets.all(20.0),
        //               child: Column(
        //                 crossAxisAlignment: CrossAxisAlignment.start,
        //                 children: [
        //                   SizedboxHeaderForm("ชื่อ - นามสกุล :"),
        //                   InfoJobAtom("assets/images/maid.png",
        //                       "${HousekeeperDoc['FirstName']} ${HousekeeperDoc['LastName']}"),
        //                   SizedboxHeaderForm("วันเกิด : "),
        //                   InfoJobAtom(
        //                       "assets/images/birthday-cake.png",
        //                       "${HousekeeperDoc['DateOfBirth']}"),
        //                   SizedboxHeaderForm("หมายเลขโทรศัพท์ : "),
        //                   TextFormField(
        //                     controller: _controllersPhoneNumber,
        //                     cursorColor: HexColor("#5D5FEF"),
        //                     textAlign: TextAlign.left,
        //                     keyboardType: TextInputType.phone,
        //                     decoration: InputDecoration(
        //                         icon: Icon(
        //                           Icons.call,
        //                           color: HexColor("#5D5FEF"),
        //                           size: 45,
        //                         ),
        //                         isDense: true, // Added this
        //                         contentPadding: EdgeInsets.all(14),
        //                         hintText: 'Phone Number',
        //                         hintStyle: TextStyle(fontSize: 14),
        //                         border: OutlineInputBorder(
        //                           borderRadius:
        //                               BorderRadius.circular(60.0),
        //                           borderSide: BorderSide(
        //                             width: 0,
        //                             style: BorderStyle.none,
        //                           ),
        //                         ),
        //                         filled: true,
        //                         fillColor: HexColor("DFDFFC"),
        //                         focusedBorder: OutlineInputBorder(
        //                           borderRadius:
        //                               BorderRadius.circular(60.0),
        //                           borderSide: BorderSide(
        //                             color: HexColor("#5D5FEF"),
        //                             //fixedSize: MaterialStateProperty.all(const Size(350, 40)),
        //                           ),
        //                         )),
        //                   ),
        //                   SizedboxHeaderForm("ศาสนา : "),
        //                   DropdownButtonFormField2(
        //                     searchController: _controllersRegion,
        //                     decoration: InputDecoration(
        //                       icon: Icon(
        //                         Icons.church,
        //                         color: HexColor("#5D5FEF"),
        //                         size: 45,
        //                       ),
        //                       isDense: true, // Added this
        //                       contentPadding: EdgeInsets.all(0),
        //                       border: OutlineInputBorder(
        //                         borderRadius:
        //                             BorderRadius.circular(60.0),
        //                         borderSide: BorderSide(
        //                           width: 0,
        //                           style: BorderStyle.none,
        //                         ),
        //                       ),
        //                       filled: true,
        //                       fillColor: HexColor("DFDFFC"),
        //                       focusedBorder: OutlineInputBorder(
        //                         borderRadius:
        //                             BorderRadius.circular(60.0),
        //                         borderSide: BorderSide(
        //                           color: HexColor("#5D5FEF"),
        //                           //fixedSize: MaterialStateProperty.all(const Size(350, 40)),
        //                         ),
        //                       ),
        //                     ),
        //                     isExpanded: true,
        //                     hint: const Text(
        //                       'Select Your Region',
        //                       style: TextStyle(fontSize: 14),
        //                     ),
        //                     icon: Icon(
        //                       Icons.arrow_drop_down,
        //                       color: HexColor("#5D5FEF"),
        //                     ),
        //                     iconSize: 30,
        //                     buttonHeight: 60,
        //                     buttonPadding: const EdgeInsets.only(
        //                         left: 20, right: 10),
        //                     dropdownDecoration: BoxDecoration(
        //                       borderRadius: BorderRadius.circular(15),
        //                       color: HexColor("#DFDFFC"),
        //                     ),
        //                     items: regionItems
        //                         .map((itemRegion) =>
        //                             DropdownMenuItem<String>(
        //                               value: itemRegion,
        //                               child: Text(
        //                                 itemRegion,
        //                                 style: const TextStyle(
        //                                   fontSize: 14,
        //                                 ),
        //                               ),
        //                             ))
        //                         .toList(),
        //                     validator: (value) {
        //                       if (value == null) {
        //                         return 'Please select region.';
        //                       }
        //                       return null;
        //                     },
        //                     value: selectedRegion,
        //                     onChanged: (value) {
        //                       selectedRegion = value as String;
        //                     },
        //                     onSaved: (value) {
        //                       selectedRegion = value.toString();
        //                     },
        //                   ),
        //                   SizedboxHeaderForm("เพศ : "),
        //                   InfoJobAtom("assets/images/equality.png",
        //                       "ผู้หญิง"),
        //                   const SizedBox(height: 30),
        //                   Center(
        //                     child: ElevatedButton(
        //                       onPressed: () async {
        //                         final phonenumber =
        //                             _controllersPhoneNumber.text;
        //                         final region =
        //                             _controllersRegion.text;

        //                         //bool result = await userExists(phonenumber);
        //                         //if (result == false) {
        //                         updatemaid(
        //                             useruid:
        //                                 widget.maid.HousekeeperID,
        //                             phonenumber: phonenumber,
        //                             region:
        //                                 selectedRegion.toString());

        //                         // await FirebaseAuth.instance.currentUser
        //                         //     ?.updateDisplayName(
        //                         //         firstname + ' ' + lastname);
        //                         // /* await FirebaseAuth.instance.currentUser
        //                         //     ?.updatePhotoURL(imageurl);*/
        //                         ScaffoldMessenger.of(context)
        //                             .showSnackBar(
        //                                 snackBarUpdateProfileDone);
        //                         Navigator.push(
        //                             context,
        //                             MaterialPageRoute(
        //                                 builder: (context) =>
        //                                     HomeMaidScreen(
        //                                       maid: widget.maid,
        //                                     )));
        //                       },
        //                       child: const Text('ยืนยัน',
        //                           style: TextStyle(fontSize: 18)),
        //                       style: ButtonStyle(
        //                         backgroundColor:
        //                             MaterialStateProperty.all(
        //                                 HexColor("5D5FEF")),
        //                         fixedSize: MaterialStateProperty.all(
        //                             const Size(100, 50)),
        //                         shape: MaterialStateProperty.all(
        //                           RoundedRectangleBorder(
        //                             borderRadius:
        //                                 BorderRadius.circular(30),
        //                           ),
        //                         ),
        //                       ),
        //                     ),
        //                   )
        //                 ],
        //               ),
        //             )),
        //       ],
        //     ),
        //   ),
        // );
        // }).toList(),
        // ),
        //   );
        // }
        // }),
        );
  }
}
