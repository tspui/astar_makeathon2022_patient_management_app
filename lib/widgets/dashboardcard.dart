import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';

class DashboardCard extends StatefulWidget {
  String? id;
   String name;
   String birthday;
  String height;
  String weight;
   String condition;
   String contact;
   String email;
  bool clicked;

  DashboardCard ({ Key? key, required this.id, required this.name, required this.birthday, required this.height, required this.weight, required this.condition, required this.contact, required this.clicked, required this.email}): super(key: key);

  @override
  State<DashboardCard> createState() => _DashboardCardState();
}

class _DashboardCardState extends State<DashboardCard> {

  PageController pageViewController = PageController(initialPage: 0);

  final birthdayController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var collection = FirebaseFirestore.instance.collection('patientlist');
    String name = widget.name;
    String condition = widget.condition;
    String contactnumber = widget.contact;
    String height = widget.height;
    String weight = widget.weight;
    String birthday = widget.birthday;
    String email = widget.email;
    final conditionController = TextEditingController(text: widget.condition);
    final nameController = TextEditingController(text: widget.name);
    final heightController = TextEditingController(text: widget.height);
    final weightController = TextEditingController(text: widget.weight);
    final contactController = TextEditingController(text: widget.contact);
    final emailController = TextEditingController(text: widget.email);

    birthdayController.addListener(() {

      if (birthdayController.text.isEmpty)
        {birthday = widget.birthday;}
      else
        {birthday = birthdayController.text;}
    });

    void unclickButton() {
      setState(() {
        widget.clicked = false;
      });
    }
    return
      Card(
          clipBehavior: Clip.antiAliasWithSaveLayer,
                  elevation: 10,
                  child: Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: Color(0xFFEEEEEE),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Padding(
                                  padding: EdgeInsets.fromLTRB(15, 20, 10, 0),
                                  child: Text(
                                    'Name:',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                        color: Colors.black,
                                        fontFamily: "Poppins"),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
                                  child: widget.clicked == false
                                      ? Text(
                                    widget.name,
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.black,
                                        fontFamily: "Poppins"),
                                  )
                                      : SizedBox(
                                      width: 200,
                                      child: TextFormField(
                                          controller: nameController,
                                          onChanged: (value) {
                                            name = value;
                                            //Do something with the user input.
                                          },
                                          cursorColor: Colors.black,
                                          decoration: InputDecoration(
                                            contentPadding:
                                            EdgeInsets.symmetric(
                                                vertical: 10.0,
                                                horizontal: 10.0),
                                            enabledBorder:
                                            OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.black),
                                            ),
                                            focusedBorder:
                                            OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.black),
                                            ),
                                            fillColor: Colors.white,
                                            filled: true,
                                            labelText: '',
                                            border: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.black,
                                                    width: 1.0)),
                                          ),
                                          style: TextStyle(
                                              color: Colors.black))),
                                )
                              ],
                            ),
                            Row(
                              children: [
                                const Padding(
                                  padding: EdgeInsets.fromLTRB(15, 15, 10, 0),
                                  child: Text(
                                    'Email:',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                        color: Colors.black,
                                        fontFamily: "Poppins"),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
                                  child:Text(
                                    widget.email,
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.black,
                                        fontFamily: "Poppins"),
                                  ),
                                )
                              ],
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.fromLTRB(15, 15, 10, 0),
                                  child: Text(
                                    'Birthday:',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                        color: Colors.black,
                                        fontFamily: "Poppins"),
                                  ),
                                ),
                                Padding(
                                    padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
                                    child: widget.clicked == false
                                        ? Text(
                                      widget.birthday,
                                      style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.black,
                                          fontFamily: "Poppins"),
                                    )
                                        : SizedBox(
                                        width: 200,
                                        child: TextField(
                                            controller: birthdayController,
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
                                                DateFormat('yyyy-MM-dd').format(pickedDate);//formatted date output using intl package =>  2021-03-16
                                                //you can implement different kind of Date Format here according to your requirement

                                                setState(() {
                                                  birthdayController.text =
                                                      formattedDate;

                                                 //set output date to TextField value.
                                                }
                                                );
                                              } else {
                                                print("Date is not selected");
                                              }
                                            },
                                            style: TextStyle(color: Colors.black)))),
                              ],
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.fromLTRB(15, 15, 10, 0),
                                  child: Text(
                                    'Height:',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                        color: Colors.black,
                                        fontFamily: "Poppins"),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
                                  child: widget.clicked == false
                                      ? Text(
                                    widget.height + " cm",
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.black,
                                        fontFamily: "Poppins"),
                                  )
                                      : SizedBox(
                                      width: 200,
                                      child: TextFormField(
                                          controller: heightController,
                                          onChanged: (value) {
                                            height = value;
                                            //Do something with the user input.
                                          },
                                          cursorColor: Colors.black,
                                          decoration: InputDecoration(
                                            contentPadding:
                                            EdgeInsets.symmetric(
                                                vertical: 10.0,
                                                horizontal: 10.0),
                                            enabledBorder:
                                            OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.black),
                                            ),
                                            focusedBorder:
                                            OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.black),
                                            ),
                                            fillColor: Colors.white,
                                            filled: true,
                                            labelText: '',
                                            border: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.black,
                                                    width: 1.0)),
                                          ),
                                          style: TextStyle(
                                              color: Colors.black))),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.fromLTRB(15, 15, 10, 0),
                                  child: Text(
                                    'Weight:',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                        color: Colors.black,
                                        fontFamily: "Poppins"),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
                                  child: widget.clicked == false
                                      ? Text(
                                    widget.weight + " kg",
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.black,
                                        fontFamily: "Poppins"),
                                  )
                                      : SizedBox(
                                      width: 200,
                                      child: TextFormField(
                                          controller: weightController,
                                          onChanged: (value) {
                                            weight = value;
                                            //Do something with the user input.
                                          },
                                          cursorColor: Colors.black,
                                          decoration: InputDecoration(
                                            contentPadding:
                                            EdgeInsets.symmetric(
                                                vertical: 10.0,
                                                horizontal: 10.0),
                                            enabledBorder:
                                            OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.black),
                                            ),
                                            focusedBorder:
                                            OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.black),
                                            ),
                                            fillColor: Colors.white,
                                            filled: true,
                                            labelText: '',
                                            border: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.black,
                                                    width: 1.0)),
                                          ),
                                          style: TextStyle(
                                              color: Colors.black))),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.fromLTRB(15, 15, 10, 0),
                                  child: Text(
                                    'Condition:',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                        color: Colors.black,
                                        fontFamily: "Poppins"),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
                                  child: widget.clicked == false
                                      ? Text(
                                    widget.condition,
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.black,
                                        fontFamily: "Poppins"),
                                  )
                                      : SizedBox(
                                      width: 200,
                                      child: TextFormField(
                                          controller: conditionController,
                                          onChanged: (value) {
                                            condition = value;
                                            //Do something with the user input.
                                          },
                                          cursorColor: Colors.black,
                                          decoration: InputDecoration(
                                            contentPadding:
                                            EdgeInsets.symmetric(
                                                vertical: 10.0,
                                                horizontal: 10.0),
                                            enabledBorder:
                                            OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.black),
                                            ),
                                            focusedBorder:
                                            OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.black),
                                            ),
                                            fillColor: Colors.white,
                                            filled: true,
                                            labelText: '',
                                            border: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.black,
                                                    width: 1.0)),
                                          ),
                                          style: TextStyle(
                                              color: Colors.black))),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.fromLTRB(15, 15, 10, 15),
                                  child: Text(
                                    'Contact Number:',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                        color: Colors.black,
                                        fontFamily: "Poppins"),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(0, 15, 0, 15),
                                  child: widget.clicked == false
                                      ? Text(
                                    "+65 " + widget.contact,
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.black,
                                        fontFamily: "Poppins"),
                                  )
                                      : SizedBox(
                                      width: 200,
                                      child: TextFormField(
                                          controller: contactController,
                                          onChanged: (value) {
                                            contactnumber = value;
                                            //Do something with the user input.
                                          },
                                          cursorColor: Colors.black,
                                          decoration: InputDecoration(
                                            contentPadding:
                                            EdgeInsets.symmetric(
                                                vertical: 10.0,
                                                horizontal: 10.0),
                                            enabledBorder:
                                            OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.black),
                                            ),
                                            focusedBorder:
                                            OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.black),
                                            ),
                                            fillColor: Colors.white,
                                            filled: true,
                                            labelText: '',
                                            border: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.black,
                                                    width: 1.0)),
                                          ),
                                          style: TextStyle(
                                              color: Colors.black)))
                                ),
                              ],
                            ),
                            widget.clicked == true
                                ? Row(
                                  children: [Padding(
                                    padding:
                                    EdgeInsets.fromLTRB(30, 0, 30, 10),
                                    child: TextButton(

                                      onPressed: () {unclickButton();

                                      },
                                      style: ButtonStyle(
                                          foregroundColor:
                                          MaterialStateProperty.all<Color>(
                                              Colors.white),
                                          backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                              Colors.red),
                                          padding:
                                          MaterialStateProperty.all<EdgeInsetsGeometry>(
                                              EdgeInsets.fromLTRB(
                                                  40, 10, 40, 10)),
                                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                              RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(50.0)))),
                                      child: Text('Cancel',
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontFamily: "Poppins")),
                                    ),
                                  ),
                                    Padding(
                              padding:
                              EdgeInsets.fromLTRB(0, 0, 0, 10),
                              child: TextButton(

                                    onPressed: () async{
                                      await collection
                                          .doc(widget.id)
                                          .update({'condition' : condition,
                                        'name': name,
                                        'birthday': birthday,
                                        'weight': weight,
                                        'height': height,
                                        'contactnumber': contactnumber
                                      }) // <-- Updated data
                                          .then((_) => unclickButton())
                                          .catchError((error) => unclickButton());


                                    },
                                    style: ButtonStyle(
                                        foregroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Colors.white),
                                        backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Color(0xff006400)),
                                        padding:
                                        MaterialStateProperty.all<EdgeInsetsGeometry>(
                                            EdgeInsets.fromLTRB(
                                                40, 10, 40, 10)),
                                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(50.0)))),
                                    child: Text('Confirm',
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontFamily: "Poppins")),
                              ),
                            ),
                                  ],
                                )
                                : Padding(
                              padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                            )
                          ],
                        ),
                      ],
                    ),
                  )
        );
  }
}
void goSchedule(BuildContext context) {
  Navigator.pushNamed(
    context,
    '/appointment',
  );
}

void goExercise(BuildContext context) {
  Navigator.pushNamed(
    context,
    '/exercise',
  );
}


