import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';

class MsgPatientCard extends StatefulWidget {
  String? id;
  String content;
  String timestamp;
  String by;

  MsgPatientCard ({ Key? key, required this.id, required this.content, required this.timestamp, required this.by}): super(key: key);

  @override
  State<MsgPatientCard> createState() => _MsgPatientCardState();
}

class _MsgPatientCardState extends State<MsgPatientCard> {

  PageController pageViewController = PageController(initialPage: 0);

  final birthdayController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final routeArgs = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    final patientemail = routeArgs['patientemail'];

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
                Row(
                  children: [
                    Flexible(
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(15, 15, 10, 0),
                        child: Text(
                          'Your doctor sent you a message!',
                          style: TextStyle(
                              fontSize: 15,
                              color: Colors.black,
                              fontFamily: "Poppins"),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Padding(
                        padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
                        child:SizedBox(
                          width: 400,
                          height: 20,
                          child: Center(
                            child: Text(
                              '"' + widget.content + '"',
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.black,
                                  fontFamily: "Poppins"
                              ),
                            ),
                          ),
                        )),
                  ],
                ),
                Row(
                  children: [
                    Padding(
                        padding: EdgeInsets.fromLTRB(0, 10, 0, 5),
                        child: Text(
                          widget.timestamp,
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                              fontStyle: FontStyle.italic,
                              fontFamily: "Poppins"),
                          textAlign: TextAlign.right,
                        )
                    ),
                  ],
                ),
              ],
            ),
          )
      );
  }
}
