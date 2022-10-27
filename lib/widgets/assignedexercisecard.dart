import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';

class AssignedExerciseCard extends StatefulWidget {
  String? id;
  String content;
  String timestamp;
  String name;

  AssignedExerciseCard ({ Key? key, required this.id, required this.content, required this.timestamp, required this.name}): super(key: key);

  @override
  State<AssignedExerciseCard> createState() => _AssignedExerciseCardState();
}

class _AssignedExerciseCardState extends State<AssignedExerciseCard> {

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
                Row(
                  children: [
                    Flexible(
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(15, 15, 10, 0),
                        child: Text(
                          'Your doctor (${widget.name}) assigned you an exercise!',
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
                              widget.content,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
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
                    SizedBox(
                      width: 400,
                      height: 50,
                      child: Center(
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                          child: TextButton(
                              style: ButtonStyle(
                                  foregroundColor:
                                  MaterialStateProperty.all<Color>(Colors.white),
                                  backgroundColor:
                                  MaterialStateProperty.all<Color>(Colors.orange),
                                  padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                                      EdgeInsets.fromLTRB(50, 10, 50, 10)),
                                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(50.0)))),
                              child: Text('Do exercise',
                                  style: TextStyle(fontSize: 15, fontFamily: "Poppins")),

                              onPressed: ()
                              {
                              }

                          ),
                        ),
                      ),
                    )
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


