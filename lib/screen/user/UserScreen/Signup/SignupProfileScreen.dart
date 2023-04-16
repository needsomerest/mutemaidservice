import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:mutemaidservice/component/HeaderAccount.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class RegisterProfile extends StatefulWidget {
  const RegisterProfile({super.key});

  @override
  State<RegisterProfile> createState() => _RegisterProfileState();
}

class _RegisterProfileState extends State<RegisterProfile> {
  DateTime? _chosenDateTime;
  final List<String> genderItems = ['Male', 'Female', 'Other'];

  String? selectedValue;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('โปรไฟล์')),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedboxHeaderForm("ชื่อจริง : "),
                TextFormField(
                  cursorColor: HexColor("#5D5FEF"),
                  textAlign: TextAlign.left,
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                      isDense: true, // Added this
                      contentPadding: EdgeInsets.all(14),
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
                  cursorColor: HexColor("#5D5FEF"),
                  textAlign: TextAlign.left,
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                      isDense: true, // Added this
                      contentPadding: EdgeInsets.all(14),
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
                  cursorColor: HexColor("#5D5FEF"),
                  textAlign: TextAlign.left,
                  keyboardType: TextInputType.datetime,
                  decoration: InputDecoration(
                      isDense: true, // Added this
                      contentPadding: EdgeInsets.all(14),
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
                ),
                SizedboxHeaderForm("หมายเลขโทรศัพท์ : "),
                TextFormField(
                  cursorColor: HexColor("#5D5FEF"),
                  textAlign: TextAlign.left,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                      isDense: true, // Added this
                      contentPadding: EdgeInsets.all(14),
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
                  icon: const Icon(
                    Icons.arrow_drop_down,
                    color: Colors.black45,
                  ),
                  iconSize: 30,
                  buttonHeight: 60,
                  buttonPadding: const EdgeInsets.only(left: 20, right: 10),
                  dropdownDecoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
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
                ElevatedButton(
                  onPressed: () {
                    Alert(
                      context: context,
                      type: AlertType.success,
                      title: "Successful !",
                      desc: "Create Profile",
                    ).show();

                    /*
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HomeScreen()),
                    );*/
                  },
                  child: const Text("ยืนยัน", style: TextStyle(fontSize: 18)),
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(HexColor("5D5FEF")),
                    fixedSize: MaterialStateProperty.all(const Size(350, 50)),
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
