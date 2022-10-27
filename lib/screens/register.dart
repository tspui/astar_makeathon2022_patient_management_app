import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../class/auth-exception-handler.dart';

class RegistrationPage extends StatefulWidget {
  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final _auth = FirebaseAuth.instance;
  late String email;
  late String password;
  late String contactno;
  late String address;
  late String name;

  bool showSpinner = false;
  bool _isHiddenPassword = true;

  void _togglePassword() {
    setState(() {
      _isHiddenPassword = !_isHiddenPassword;
    });
  }

  final myController = TextEditingController();
  final myController1 = TextEditingController();
  final myController2 = TextEditingController();
  final myController3 = TextEditingController();
  final myController4 = TextEditingController();
  bool submit = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    myController.addListener(() {
      setState(() {
        if (myController.text.isNotEmpty &&
            myController1.text.isNotEmpty &&
            myController2.text.isNotEmpty &&
            myController3.text.length == 8 &&
            myController4.text.isNotEmpty) {
          submit = true;
        } else {
          submit = false;
        }
      });
    });
    myController1.addListener(() {
      setState(() {
        if (myController.text.isNotEmpty &&
            myController1.text.isNotEmpty &&
            myController2.text.isNotEmpty &&
            myController3.text.length == 8 &&
            myController4.text.isNotEmpty) {
          submit = true;
        } else {
          submit = false;
        }
      });
    });
    myController2.addListener(() {
      setState(() {
        if (myController.text.isNotEmpty &&
            myController1.text.isNotEmpty &&
            myController2.text.isNotEmpty &&
            myController3.text.length == 8 &&
            myController4.text.isNotEmpty) {
          submit = true;
        } else {
          submit = false;
        }
      });
    });
    myController3.addListener(() {
      setState(() {
        if (myController.text.isNotEmpty &&
            myController1.text.isNotEmpty &&
            myController2.text.isNotEmpty &&
            myController3.text.length == 8 &&
            myController4.text.isNotEmpty) {
          submit = true;
        } else {
          submit = false;
        }
      });
    });
    myController4.addListener(() {
      setState(() {
        if (myController.text.isNotEmpty &&
            myController1.text.isNotEmpty &&
            myController2.text.isNotEmpty &&
            myController3.text.length == 8 &&
            myController4.text.isNotEmpty) {
          submit = true;
        } else {
          submit = false;
        }
      });
    });
  }

  // @override
  // void dispose() {
  //   // Clean up the controller when the widget is disposed.
  //   myController.dispose();
  //   super.dispose();
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          "Register (Physiotherapist)",
          style: TextStyle(color: Theme.of(context).colorScheme.secondary),
        ),
      ),
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: ListView(children: [
          Row(
            children: [
              new Flexible(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(60, 100, 50, 0),
                  child: Text("Full Name",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 19, fontFamily: "Poppins")),
                ),
              ),
              new Flexible(
                child: Padding(
                    padding: EdgeInsets.fromLTRB(5, 100, 20, 0),
                    child: SizedBox(
                      height: 70.0,
                      child: Theme(
                        data: Theme.of(context).copyWith(
                          colorScheme: ThemeData().colorScheme.copyWith(
                                primary: Color(0xff006400),
                              ),
                        ),
                        child: TextField(
                            controller: myController,
                            onChanged: (value) {
                              name = value;
                            },
                            cursorColor: Colors.black,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.person),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                              ),
                              fillColor: Colors.white,
                              filled: true,
                              labelText: '',
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.black, width: 2.0)),
                            ),
                            style: TextStyle(color: Colors.black)),
                      ),
                    )),
              ),
            ],
          ),
          Row(
            children: [
              new Flexible(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(80, 10, 52, 0),
                  child: Text("Email",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 19, fontFamily: "Poppins")),
                ),
              ),
              new Flexible(
                child: Padding(
                    padding: EdgeInsets.fromLTRB(25, 20, 0, 0),
                    child: SizedBox(
                      height: 70.0,
                      child: Theme(
                        data: Theme.of(context).copyWith(
                          colorScheme: ThemeData().colorScheme.copyWith(
                                primary: Color(0xff006400),
                              ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                          child: TextField(
                              controller: myController1,
                              onChanged: (value) {
                                email = value;
                                //Do something with the user input.
                              },
                              cursorColor: Colors.black,
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                prefixIcon: Icon(Icons.email),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black),
                                ),
                                fillColor: Colors.white,
                                filled: true,
                                labelText: '',
                                hintText: 'example@123.com',
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.black, width: 2.0)),
                              ),
                              style: TextStyle(color: Colors.black)),
                        ),
                      ),
                    )),
              ),
            ],
          ),
          Row(
            children: [
              new Flexible(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(60, 10, 54, 0),
                  child: Text("Password",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 19, fontFamily: "Poppins")),
                ),
              ),
              new Flexible(
                child: Padding(
                    padding: EdgeInsets.fromLTRB(5, 20, 20, 0),
                    child: SizedBox(
                      height: 70.0,
                      width: 600,
                      child: Theme(
                        data: Theme.of(context).copyWith(
                          colorScheme: ThemeData().colorScheme.copyWith(
                                primary: Color(0xff006400),
                              ),
                        ),
                        child: TextField(
                            controller: myController2,
                            onChanged: (value) {
                              password = value;
                              //Do something with the user input.
                            },
                            obscureText: _isHiddenPassword,
                            cursorColor: Colors.black,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.security),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                              ),
                              fillColor: Colors.white,
                              filled: true,
                              labelText: '',
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.black, width: 2.0)),
                              suffixIcon: GestureDetector(
                                onTap: _togglePassword,
                                child: Icon(
                                  _isHiddenPassword
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                ),
                              ),
                            ),
                            style: TextStyle(color: Colors.black)),
                      ),
                    )),
              ),
            ],
          ),
          Row(
            children: [
              new Flexible(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(33, 15, 20, 0),
                  child: Text("Contact Number",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 19, fontFamily: "Poppins")),
                ),
              ),
              new Flexible(
                child: Padding(
                    padding: EdgeInsets.fromLTRB(5, 20, 20, 0),
                    child: SizedBox(
                      height: 70.0,
                      child: Theme(
                        data: Theme.of(context).copyWith(
                          colorScheme: ThemeData().colorScheme.copyWith(
                                primary: Color(0xff006400),
                              ),
                        ),
                        child: TextField(
                            controller: myController3,
                            onChanged: (value) {
                              contactno = value;
                              //Do something with the user input.
                            },
                            cursorColor: Colors.black,
                            keyboardType: TextInputType.phone,
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.call),
                              hintText: 'E.g. 12345678',
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                              ),
                              fillColor: Colors.white,
                              filled: true,
                              labelText: '+65',
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.black, width: 2.0)),
                            ),
                            style: TextStyle(color: Colors.black)),
                      ),
                    )),
              ),
            ],
          ),
          Row(
            children: [
              new Flexible(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(20, 0, 8, 0),
                  child: Text("Hospital/Clinic Name",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 19, fontFamily: "Poppins")),
                ),
              ),
              new Flexible(
                child: Padding(
                    padding: EdgeInsets.fromLTRB(0, 20, 25, 0),
                    child: SizedBox(
                      height: 80.0,
                      child: Theme(
                        data: Theme.of(context).copyWith(
                          colorScheme: ThemeData().colorScheme.copyWith(
                                primary: Color(0xff006400),
                              ),
                        ),
                        child: TextField(
                            controller: myController4,
                            onChanged: (value) {
                              // setState(() {
                              //
                              //
                              //   var _newMessage = value;
                              //
                              //   if(_newMessage.length > 0){  //add these lines
                              //     isInputEmpty2 = false;
                              //   } else {
                              //     isInputEmpty2 = true;
                              //   }
                              //
                              // });
                              address = value;
                              //Do something with the user input.
                            },
                            // onSaved: (val) {
                            //   address = val;
                            // },
                            // validator: (value) {
                            //   if (value!.isEmpty) {
                            //     return 'Please enter some name';
                            //   }
                            //   return null;
                            // },
                            cursorColor: Colors.black,
                            keyboardType: TextInputType.streetAddress,
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.house),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                              ),
                              fillColor: Colors.white,
                              filled: true,
                              labelText: '',
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.black, width: 2.0)),
                            ),
                            style: TextStyle(
                              color: Colors.black,
                            )),
                      ),
                    )),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(20, 50, 20, 10),
            child: TextButton(
              onPressed: (submit == true)
                  ? () async {
                      setState(() {
                        showSpinner = true;
                      });
                      try {
                        final newUser =
                            await _auth.createUserWithEmailAndPassword(
                                email: email, password: password);
                        FirebaseFirestore.instance
                            .collection('doctoremail')
                            .doc(email)
                            .set({'doctoremail': email,
                        'name': name,
                          'clinic': address,
                          'pic': "images/unknown.jpg"
                        })
                            .then((value) => print("Volunteer Added"))
                            .catchError((error) =>
                                print("Failed to add volunteer: $error"));
                        ;

                        FirebaseFirestore.instance
                            .collection('doctornotification')
                            .doc(email)
                            .set({
                          'appointment': {'content': [], 'date': [], 'by': []},
                          'message': {'content': [], 'date': [], 'by': []}

                        },SetOptions(merge: true));


                        if (newUser != null) {
                          Navigator.pushNamed(context, '/login');
                        }
                      } catch (e) {
                        final errorMsg =
                            AuthExceptionHandler.generateExceptionMessage(
                                AuthExceptionHandler.handleException(e));
                        showAlertDialog(context, errorMsg);
                      }
                      setState(() {
                        showSpinner = false;
                      });
                    }
                  : null,
              style: ButtonStyle(
                  foregroundColor: (submit == true)
                      ? MaterialStateProperty.all<Color>(Colors.white)
                      : MaterialStateProperty.all<Color>(Colors.white),
                  backgroundColor: (submit == true)
                      ? MaterialStateProperty.all<Color>(Color(0xff006400))
                      : MaterialStateProperty.all<Color>(Colors.grey),
                  padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                      EdgeInsets.fromLTRB(55, 10, 55, 10)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50.0)))),
              child: Text('Register',
                  style: TextStyle(fontSize: 20, fontFamily: "Poppins")),
            ),
          ),
          Padding(
              padding: EdgeInsets.fromLTRB(163, 40, 30, 0),
              child: Text("Already a user?",
                  style: TextStyle(fontSize: 12, fontFamily: "Poppins"))),
          Row(children: [
            new Flexible(
              child: Padding(
                padding: EdgeInsets.fromLTRB(177, 3, 0, 0),
                child: Text("Click",
                    style: TextStyle(fontSize: 12, fontFamily: "Poppins")),
              ),
            ),
            new Flexible(
              child: Padding(
                padding: EdgeInsets.fromLTRB(3, 3, 0, 0),
                child: GestureDetector(
                  child: Text("here",
                      style: TextStyle(
                          fontSize: 12,
                          fontFamily: "Poppins",
                          decoration: TextDecoration.underline)),
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      '/login',
                    );
                  },
                ),
              ),
            ),
          ])
        ]),
      ),
    );
  }
}

showAlertDialog(BuildContext context, String e) {
  // set up the button
  Widget okButton = TextButton(
    child: Text("OK", style: TextStyle(color: Color(0xff754E46))),
    onPressed: () {
      Navigator.pop(context, '/register');
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Error"),
    content: Text(e),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
