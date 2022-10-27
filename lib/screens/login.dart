import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late String email;
  late String password;
  bool showSpinner = false;
  bool _isHidden = true;
  final myController = TextEditingController();
  final myController1 = TextEditingController();
  bool submit = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    myController.addListener(() {
      setState(() {
        if (myController.text.isNotEmpty && myController1.text.isNotEmpty) {
          submit = true;
        } else {
          submit = false;
        }
      });
    });
    myController1.addListener(() {
      setState(() {
        if (myController.text.isNotEmpty && myController1.text.isNotEmpty) {
          submit = true;
        } else {
          submit = false;
        }
      });
    });
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          title: Text(
            "Login (Physiotherapist)",
            style: TextStyle(color: Theme.of(context).colorScheme.secondary),
          ),
          leading: BackButton(onPressed: () {
            Navigator.pushNamed(
              context,
              '/',
            );
          })),
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: ListView(children: [
          Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
              child: Image.asset('images/X-Physio.png',
                  width: 376, height: 320, fit: BoxFit.cover)),
          Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
              child: Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.fromLTRB(40.0, 0, 40, 0),
                  width: 20.0,
                  height: 240.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(20.0),
                    ),
                    color: Colors.lightGreen,
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          new Flexible(
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(20, 40, 0, 0),
                              child: Text("Email Address",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 19, fontFamily: "Poppins")),
                            ),
                          ),
                          new Flexible(
                            child: Padding(
                                padding: EdgeInsets.fromLTRB(13, 45, 0, 0),
                                child: SizedBox(
                                  height: 70.0,
                                  child: Theme(
                                    data: Theme.of(context).copyWith(
                                      colorScheme:
                                          ThemeData().colorScheme.copyWith(
                                                primary: Color(0xff006400),
                                              ),
                                    ),
                                    child: TextField(
                                        controller: myController,
                                        onChanged: (value) {
                                          email = value;
                                          //Do something with the user input.
                                        },
                                        cursorColor: Colors.black,
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        decoration: InputDecoration(
                                          suffixIcon: Icon(Icons.email),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide:
                                                BorderSide(color: Colors.black),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide:
                                                BorderSide(color: Colors.black),
                                          ),
                                          fillColor: Colors.white,
                                          filled: true,
                                          labelText: '',
                                          border: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.black,
                                                  width: 2.0)),
                                        ),
                                        style: TextStyle(color: Colors.black)),
                                  ),
                                )),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          new Flexible(
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(35, 15, 34, 0),
                              child: Text("Password",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 19, fontFamily: "Poppins")),
                            ),
                          ),
                          new Flexible(
                            child: Padding(
                                padding: EdgeInsets.fromLTRB(5, 20, 8, 0),
                                child: SizedBox(
                                  height: 70.0,
                                  child: Theme(
                                    data: Theme.of(context).copyWith(
                                      colorScheme:
                                          ThemeData().colorScheme.copyWith(
                                                primary: Color(0xff006400),
                                              ),
                                    ),
                                    child: TextField(
                                        controller: myController1,
                                        onChanged: (value) {
                                          password = value;
                                          //Do something with the user input.
                                        },
                                        obscureText: _isHidden,
                                        cursorColor: Colors.black,
                                        keyboardType: TextInputType.text,
                                        decoration: InputDecoration(
                                          enabledBorder: OutlineInputBorder(
                                            borderSide:
                                                BorderSide(color: Colors.black),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide:
                                                BorderSide(color: Colors.black),
                                          ),
                                          fillColor: Colors.white,
                                          filled: true,
                                          labelText: '',
                                          border: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.black,
                                                  width: 2.0)),
                                          suffixIcon: GestureDetector(
                                            onTap: _togglePasswordView,
                                            child: Icon(
                                              _isHidden
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
                      )
                    ],
                  ))),
          Row(
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(43, 50, 10, 10),
                child: TextButton(
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      '/register',
                    );
                  },
                  style: ButtonStyle(
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.white),
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Color(0xff006400)),
                      padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                          EdgeInsets.fromLTRB(40, 10, 40, 10)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50.0)))),
                  child: Text('Register',
                      style: TextStyle(fontSize: 20, fontFamily: "Poppins")),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(8, 50, 10, 10),
                child: TextButton(
                  onPressed:
                    (submit == true)
                        ? () async {
                            setState(() {
                              showSpinner = true;
                            });
                            try {
                              final user =
                                  await _auth.signInWithEmailAndPassword(
                                      email: email, password: password);

                              if (user != null) {

                                FirebaseFirestore.instance
                                    .collection('doctoremail')
                                    .where('doctoremail', isEqualTo: email)
                                    .get()
                                    .then((checkSnapshot) {
                                  if (checkSnapshot.size == 1) {
                                    Navigator.pushNamed(context, '/tabsphysio',
                                        arguments: {'doctoremail': email});
                                  }
                                  else
                                  {showAlertDialog(context);

                                  }
                                });
                              }
                            } catch (e) {
                              showAlertDialog(context);
                            }
                            ;

                            setState(() {
                              showSpinner = false;
                            });
                          }
                        : null,
                  style: ButtonStyle(
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.white),
                      backgroundColor: (submit == true)
                          ? MaterialStateProperty.all<Color>(Color(0xff006400))
                          : MaterialStateProperty.all<Color>(Colors.grey),
                      padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                          EdgeInsets.fromLTRB(55, 10, 55, 10)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50.0)))),
                  child: Text('Login',
                      style: TextStyle(fontSize: 20, fontFamily: "Poppins")),
                ),
              )
            ],
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(120, 30, 0, 0),
            child: Row(children: [
              new Flexible(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(0, 3, 0, 0),
                  child: Text("Forget Password? Click",
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
                      null;
                    },
                  ),
                ),
              ),
            ]),
          )
        ]),
      ),
    );
  }

  void _togglePasswordView() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }
}

showAlertDialog(BuildContext context) {
  // set up the button
  Widget okButton = TextButton(
    child: Text("OK", style: TextStyle(color: Color(0xff006400))),
    onPressed: () {
      Navigator.pop(context, '/login');
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Invalid Email Address or Password"),
    content:
        Text("Please check your email address or your password and try again!"),
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
