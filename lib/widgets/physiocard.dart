import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';

class PhysioCard extends StatefulWidget {
  String? id;
  String name;
  String pic;
  String clinic;

  PhysioCard ({ Key? key, required this.id, required this.name, required this.pic, required this.clinic}): super(key: key);

  @override
  State<PhysioCard> createState() => _PhysioCardState();
}

class _PhysioCardState extends State<PhysioCard> {

  PageController pageViewController = PageController(initialPage: 0);

  final birthdayController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var collection = FirebaseFirestore.instance.collection('doctoremail');
    String name = widget.name;
    String clinic = widget.clinic;
    final clinicController = TextEditingController(text: widget.clinic);
    final nameController = TextEditingController(text: widget.name);

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
                Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(20, 20, 0, 20),
                        child: Container(
                            width: 90,
                            height: 90,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              image: DecorationImage(
                                image: AssetImage(
                                    widget.pic),
                              ),
                              shape: BoxShape.circle,
                            )),
                      ),
                      Flexible(
                          child: Column(
                            children: [
                              Row(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.fromLTRB(20, 0, 10, 10),
                                      child: Text(
                                        'Name:',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15,
                                            color: Colors.black,
                                            fontFamily: "Poppins"),

                                      ),
                                    ),
                                    Text(
                                      widget.name,
                                      style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.black,
                                          fontFamily: "Poppins"),
                                    ),
                                  ]),
                              Row(children: [
                                Padding(
                                  padding: EdgeInsets.fromLTRB(20, 0, 10, 0),
                                  child: Text(
                                    'Clinic:',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                        color: Colors.black,
                                        fontFamily: "Poppins"),

                                  ),
                                ),
                                Flexible(
                                  child: Text(
                                    widget.clinic,
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.black,
                                        fontFamily: "Poppins"),
                                  ),
                                )

                              ])
                            ],
                          ))
                    ]
                ),

            ),
          );
  }
}


