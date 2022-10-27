import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';

class ConfirmedApptDoc extends StatefulWidget {
  String? id;
  String apptdate;
  String patientemail;

  ConfirmedApptDoc ({ Key? key, required this.patientemail, required this.id, required this.apptdate, }): super(key: key);

  @override
  State<ConfirmedApptDoc> createState() => _ConfirmedApptDocState();
}

class _ConfirmedApptDocState extends State<ConfirmedApptDoc> {

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
                  child: Center(
                    child: Text(
                      'Confirmed Appointment Date & Time with your patient, ${widget.patientemail}:',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: Colors.black,
                          fontFamily: "Poppins"),
                    ),
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


