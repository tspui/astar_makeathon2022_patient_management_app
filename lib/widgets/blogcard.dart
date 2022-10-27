import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';

class BlogCard extends StatefulWidget {
  String? id;
  String name;
  String date;
  String content;
  String title;

  BlogCard ({ Key? key, required this.id, required this.name, required this.date, required this.content, required this.title}): super(key: key);

  @override
  State<BlogCard> createState() => _BlogCardState();
}

class _BlogCardState extends State<BlogCard> {

  PageController pageViewController = PageController(initialPage: 0);

  final birthdayController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    String name = widget.name;
    String date = widget.date;
    String content = widget.content;
    String title = widget.title;

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
                        Padding(
                          padding: EdgeInsets.fromLTRB(15, 15, 0, 0),
                          child:Text(
                            widget.title,
                            style: TextStyle(
                                fontSize: 30,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
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
                            'Author:',
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
                              widget.name,
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.black,
                                  fontFamily: "Poppins"),
                            )),
                      ],
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(15, 15, 10, 0),
                          child: Text(
                            'Date Posted:',
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
                            widget.date,
                            style: TextStyle(
                                fontSize: 15,
                                color: Colors.black,
                                fontFamily: "Poppins"),
                          ),
                        ),
                      ],
                    ),
                    Row( children: <Widget>[
                      Flexible(
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(15, 15, 10, 10),
                          child:Text(
                            widget.content,
                            style: TextStyle(
                                fontSize: 15,
                                color: Colors.black,
                                fontFamily: "Poppins"),
                          ),
                        ),
                      ),
                    ], )
                  ],
                ),
          )
      );
  }
}


