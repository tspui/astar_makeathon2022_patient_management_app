import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AddUser extends StatefulWidget {
  @override
  _AddUserState createState() => _AddUserState();
}

class _AddUserState extends State<AddUser> {
  final _auth = FirebaseAuth.instance;
  late String email;
  late String condition;
  late String weight;
  late String height;
  late String contactnumber;
  late String code;
  late String name;

  bool showSpinner = false;

  final myController1 = TextEditingController();
  final myController2 = TextEditingController();
  final myController3 = TextEditingController();
  final myController4 = TextEditingController();
  final myController5 = TextEditingController();
  final myController6 = TextEditingController();
  final myController7 = TextEditingController();
  final myController8 = TextEditingController();
  bool submit = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    myController2.text = "";

    myController1.addListener(() {
      setState(() {
        if (
        myController1.text.isNotEmpty &&
            myController2.text.isNotEmpty &&
            myController3.text.length == 8 &&
            myController4.text.isNotEmpty &&
            myController5.text.isNotEmpty &&
            myController6.text.isNotEmpty &&
            myController7.text.isNotEmpty &&
            myController8.text.isNotEmpty
        ) {
          submit = true;
        } else {
          submit = false;
        }
      });
    });
    myController2.addListener(() {
      setState(() {
        if (
        myController1.text.isNotEmpty &&
            myController2.text.isNotEmpty &&
            myController3.text.length == 8 &&
            myController4.text.isNotEmpty &&
            myController5.text.isNotEmpty &&
            myController6.text.isNotEmpty &&
            myController7.text.isNotEmpty &&
            myController8.text.isNotEmpty) {
          submit = true;
        } else {
          submit = false;
        }
      });
    });
    myController3.addListener(() {
      setState(() {
        if (
        myController1.text.isNotEmpty &&
            myController2.text.isNotEmpty &&
            myController3.text.length == 8 &&
            myController4.text.isNotEmpty &&
            myController5.text.isNotEmpty &&
            myController6.text.isNotEmpty  &&
            myController7.text.isNotEmpty &&
            myController8.text.isNotEmpty) {
          submit = true;
        } else {
          submit = false;
        }
      });
    });
    myController4.addListener(() {
      setState(() {
        if (
        myController1.text.isNotEmpty &&
            myController2.text.isNotEmpty &&
            myController3.text.length == 8 &&
            myController4.text.isNotEmpty &&
            myController5.text.isNotEmpty &&
            myController6.text.isNotEmpty  &&
            myController7.text.isNotEmpty &&
            myController8.text.isNotEmpty) {
          submit = true;
        } else {
          submit = false;
        }
      });
    });

    myController5.addListener(() {
      setState(() {
        if (
        myController1.text.isNotEmpty &&
            myController2.text.isNotEmpty &&
            myController3.text.length == 8 &&
            myController4.text.isNotEmpty &&
            myController5.text.isNotEmpty &&
            myController6.text.isNotEmpty  &&
            myController7.text.isNotEmpty &&
            myController8.text.isNotEmpty) {
          submit = true;
        } else {
          submit = false;
        }
      });
    });
    myController6.addListener(() {
      setState(() {
        if (
        myController1.text.isNotEmpty &&
            myController2.text.isNotEmpty &&
            myController3.text.length == 8 &&
            myController4.text.isNotEmpty &&
            myController5.text.isNotEmpty &&
            myController6.text.isNotEmpty  &&
            myController7.text.isNotEmpty &&
            myController8.text.isNotEmpty) {
          submit = true;
        } else {
          submit = false;
        }
      });
    });

    myController7.addListener(() {
      setState(() {
        if (
        myController1.text.isNotEmpty &&
            myController2.text.isNotEmpty &&
            myController3.text.length == 8 &&
            myController4.text.isNotEmpty &&
            myController5.text.isNotEmpty &&
            myController6.text.isNotEmpty  &&
            myController7.text.isNotEmpty &&

            myController8.text.isNotEmpty
        ) {
          submit = true;
        } else {
          submit = false;
        }
      });
    });

    myController8.addListener(() {
      setState(() {
        if (
        myController1.text.isNotEmpty &&
            myController2.text.isNotEmpty &&
            myController3.text.length == 8 &&
            myController4.text.isNotEmpty &&
            myController5.text.isNotEmpty &&
            myController6.text.isNotEmpty  &&
            myController7.text.isNotEmpty &&

            myController8.text.isNotEmpty
        ) {
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
  String selectedItem = "";
  bool _selected = false;
  @override
  Widget build(BuildContext context) {
    bool empty = true;
    final routeArgs = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    final doctoremail = routeArgs['doctoremail'];

    List<String>items = [];

    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(
            "Add Patient",
            style: TextStyle(color: Theme.of(context).colorScheme.secondary),
          ),
        ),
        body: ListView(children: [
          Row(
            children: [
              new Flexible(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(60, 40, 53, 0),
                  child: Text("Email",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 19, fontFamily: "Poppins")),
                ),
              ),
              new Flexible(
                child: Padding(
                    padding: EdgeInsets.fromLTRB(0, 40, 0, 0),
                    child: SizedBox(
                      height: 70.0,
                      child: Theme(
                        data: Theme.of(context).copyWith(
                          colorScheme: ThemeData().colorScheme.copyWith(
                            primary: Color(0xff006400),
                          ),
                        ),
                        child: TextField(
                            controller: myController1,
                            onChanged: (value) {
                              email = value;
                              //Do something with the user input.
                            },
                            cursorColor: Colors.black,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                              ),
                              fillColor: Colors.white,
                              filled: true,
                              labelText: "",
                              alignLabelWithHint: true,
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
                  padding: EdgeInsets.fromLTRB(60, 15, 49, 0),
                  child: Text("Name",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 19, fontFamily: "Poppins")),
                ),
              ),
              new Flexible(
                child: Padding(
                    padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                    child: SizedBox(
                      height: 70.0,
                      child: Theme(
                        data: Theme.of(context).copyWith(
                          colorScheme: ThemeData().colorScheme.copyWith(
                            primary: Color(0xff006400),
                          ),
                        ),
                        child: TextField(
                            controller: myController8,
                            onChanged: (value) {
                              name = value;
                              //Do something with the user input.
                            },
                            cursorColor: Colors.black,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                              ),
                              fillColor: Colors.white,
                              filled: true,
                              labelText: "",
                              alignLabelWithHint: true,
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

          // Row(
          //   children: [
          //     new Flexible(
          //       child: Padding(
          //         padding: EdgeInsets.fromLTRB(60, 15, 55, 0),
          //         child: Text("Email",
          //             textAlign: TextAlign.center,
          //             style: TextStyle(fontSize: 19, fontFamily: "Poppins")),
          //       ),
          //     ),
          //     new Flexible(
          //       child: Padding(
          //           padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
          //           child: SizedBox(
          //             height: 70.0,
          //             child: Theme(
          //               data: Theme.of(context).copyWith(
          //                 colorScheme: ThemeData().colorScheme.copyWith(
          //                       primary: Color(0xff006400),
          //                     ),
          //               ),
          //               child: Padding(
          //                 padding: EdgeInsets.fromLTRB(0, 23, 0, 0),
          //                 child: StreamBuilder<QuerySnapshot>(
          //                   stream: FirebaseFirestore.instance.collection('patientlist').where('name', isEqualTo: selectedItem).snapshots(),
          //                   builder: (context, snapshot) {
          //                     if (snapshot.hasError) {
          //                       return Text(snapshot.error.toString());
          //                     }
          //                     else if (snapshot.connectionState == ConnectionState.waiting) {
          //                       return Text('Loading');
          //                     }
          //                     else{
          //                       final data = snapshot.requireData;
          //
          //                       if (data.size != 1) {
          //                         empty = true;
          //                       }
          //                       else
          //                         {email = snapshot.data?.docs[0]['email'];
          //                           empty = false;}
          //
          //                     return Text(
          //                         empty == false ? email : "Please select name from drop down list.",
          //                         style:
          //                             TextStyle(fontSize: 16, fontFamily: "Poppins"));
          //                   }}
          //                 ),
          //               ),
          //             ),
          //           )),
          //     ),
          //   ],
          // ),
          Row(
            children: [
              new Flexible(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(50, 15, 37, 0),
                  child: Text("Birthday",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 19, fontFamily: "Poppins")),
                ),
              ),
              new Flexible(
                child: Padding(
                    padding: EdgeInsets.fromLTRB(0, 25, 0, 0),
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
                            cursorColor: Colors.black,
                            readOnly: true,
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.calendar_today),
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
                            onTap: () async {
                              DateTime? pickedDate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(2000),
                                  //DateTime.now() - not to allow to choose before today.
                                  lastDate: DateTime(2101));

                              if (pickedDate != null) {
                                print(
                                    pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                                String formattedDate =
                                    DateFormat('yyyy-MM-dd').format(pickedDate);
                                print(
                                    formattedDate); //formatted date output using intl package =>  2021-03-16
                                //you can implement different kind of Date Format here according to your requirement

                                setState(() {
                                  myController2.text =
                                      formattedDate; //set output date to TextField value.
                                });
                              } else {
                                print("Date is not selected");
                              }
                            },
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
                  padding: EdgeInsets.fromLTRB(55, 15, 47, 0),
                  child: Text("Height",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 19, fontFamily: "Poppins")),
                ),
              ),
              new Flexible(
                child: Padding(
                    padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                    child: SizedBox(
                      height: 70.0,
                      child: Theme(
                        data: Theme.of(context).copyWith(
                          colorScheme: ThemeData().colorScheme.copyWith(
                                primary: Color(0xff006400),
                              ),
                        ),
                        child: TextField(
                            controller: myController5,
                            onChanged: (value) {
                              height = value;
                              //Do something with the user input.
                            },
                            cursorColor: Colors.black,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                              ),
                              fillColor: Colors.white,
                              filled: true,
                              labelText: "cm",
                              alignLabelWithHint: true,
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
                  padding: EdgeInsets.fromLTRB(55, 15, 45, 0),
                  child: Text("Weight",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 19, fontFamily: "Poppins")),
                ),
              ),
              new Flexible(
                child: Padding(
                    padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                    child: SizedBox(
                      height: 70.0,
                      child: Theme(
                        data: Theme.of(context).copyWith(
                          colorScheme: ThemeData().colorScheme.copyWith(
                                primary: Color(0xff006400),
                              ),
                        ),
                        child: TextField(
                            controller: myController6,
                            onChanged: (value) {
                              weight = value;
                              //Do something with the user input.
                            },
                            cursorColor: Colors.black,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                              ),
                              fillColor: Colors.white,
                              filled: true,
                              labelText: "kg",
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
                  padding: EdgeInsets.fromLTRB(45, 15, 30, 0),
                  child: Text("Condition",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 19, fontFamily: "Poppins")),
                ),
              ),
              new Flexible(
                child: Padding(
                    padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                    child: SizedBox(
                      height: 70.0,
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
                              //   var _newMessage = value;
                              //
                              //   if(_newMessage.length > 0){  //add these lines
                              //     isInputEmpty1 = false;
                              //   } else if (_newMessage.length == 0){
                              //     isInputEmpty1 = true;
                              //   }
                              //
                              // });
                              condition = value;
                              //Do something with the user input.
                            },
                            // onSaved: (val) {
                            //   contactno = val;
                            // },
                            // validator: (value) {
                            //   if (value!.isEmpty) {
                            //     return 'Please enter some name';
                            //   }
                            //   return null;
                            // },
                            // validator: (String? value) {
                            //   if (value!.isEmpty) {
                            //     return "Please enter your contact number";
                            //   }
                            //   return null;
                            // },
                            // controller: _contactnoController,
                            cursorColor: Colors.black,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                              ),
                              fillColor: Colors.white,
                              filled: true,
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
                  padding: EdgeInsets.fromLTRB(35, 3, 20, 0),
                  child: Text("Contact No.",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 19, fontFamily: "Poppins")),
                ),
              ),
              new Flexible(
                child: Padding(
                    padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                    child: SizedBox(
                      height: 80.0,
                      child: Theme(
                        data: Theme.of(context).copyWith(
                          colorScheme: ThemeData().colorScheme.copyWith(
                                primary: Color(0xff006400),
                              ),
                        ),
                        child: TextField(
                            controller: myController3,
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
                              contactnumber = value;
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
                            keyboardType: TextInputType.phone,
                            decoration: InputDecoration(
                              labelText: '+65',
                              hintText: '12345678',
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                              ),
                              fillColor: Colors.white,
                              filled: true,
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
          Row(
            children: [
              new Flexible(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(60, 0, 55, 0),
                  child: Text("Code",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 19, fontFamily: "Poppins")),
                ),
              ),
              new Flexible(
                child: Padding(
                    padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
                    child: SizedBox(
                      height: 80.0,
                      child: Theme(
                        data: Theme.of(context).copyWith(
                          colorScheme: ThemeData().colorScheme.copyWith(
                            primary: Color(0xff006400),
                          ),
                        ),
                        child: TextField(
                            controller: myController7,
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
                              code = value;
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
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                              ),
                              fillColor: Colors.white,
                              filled: true,
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
            padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
            child: TextButton(
              onPressed: (submit == true)
              ? () async {
              setState(() {
              showSpinner = true;
              });
              try {
                final newUser =
                await _auth.createUserWithEmailAndPassword(
                    email: email, password: code);
                FirebaseFirestore.instance
                    .collection('patientemail')
                    .doc(email)
                    .set({'patientemail': email});

                FirebaseFirestore.instance
                    .collection('confirmedapptpatient')
                    .doc(email)
                    .set({'appointment': {'content': [], 'with': []}});

                FirebaseFirestore.instance
                    .collection('confirmedapptdoc')
                    .doc(doctoremail)
                    .set({'appointment': {'content': [], 'with': []}});

              FirebaseFirestore.instance
                  .collection('patientlist')
                  .doc(email)
                  .set({
                'name': name,

                'height': height,
                'patientemail': email,
                'weight': weight,
                'condition': condition,
                'contactnumber': contactnumber,
                'birthday': myController2.text,
                'doctoremail': doctoremail,
                'appointment': {'content': [], 'date': []},
                'message': {'content': [], 'date': []},
                'assignedexercise': {'content': [], 'date': []}

              },SetOptions(merge: true))
                  .then((value) => Navigator.pushNamed(context, '/tabsphysio', arguments: {
                    "doctoremail": doctoremail
              }))
                  .catchError((error) =>
              print("Failed to add patient: $error"));}

              catch (e) {
                print("Failed to add patient: $e");
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
              child: Text('Add Patient',
                  style: TextStyle(fontSize: 20, fontFamily: "Poppins")),
            ),
          ),
        ]),
      ),
    );
  }
}
