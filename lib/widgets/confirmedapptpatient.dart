import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';

class ConfirmedApptPatient extends StatefulWidget {
  String? id;
  String apptdate;
  String doctorname;

  ConfirmedApptPatient ({ Key? key, required this.id, required this.apptdate, required this.doctorname}): super(key: key);

  @override
  State<ConfirmedApptPatient> createState() => _ConfirmedApptPatientState();
}

class _ConfirmedApptPatientState extends State<ConfirmedApptPatient> {

  PageController pageViewController = PageController(initialPage: 0);

  final birthdayController = TextEditingController();
  @override
  Widget build(BuildContext context) {

    return
      Card(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          elevation: 10,
          child: Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Color(0xFFEEEEEE),
            ),
            child:
            Column(
              children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(15, 15, 10, 0),
                        child: Text(
                          'Confirmed Appointment Date & Time:',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: Colors.black,
                              fontFamily: "Poppins"),
                        ),
                      ),
                    Padding(
                        padding: EdgeInsets.fromLTRB(0, 15, 0, 10),
                        child:Text(
                          widget.apptdate,
                          style: TextStyle(
                              fontSize: 15,
                              color: Colors.black,
                              fontFamily: "Poppins"
                          ),
                        )),
              ],
            ),
          )
      );
  }
}


