import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BlogAdd extends StatefulWidget {
  const BlogAdd({Key? key}) : super(key: key);

  @override
  State<BlogAdd> createState() => _BlogAddState();
}

class _BlogAddState extends State<BlogAdd> {
  final now = new DateTime.now();
  final titleController = TextEditingController();
  final contentController = TextEditingController();
  final nameController = TextEditingController();
  bool submit = false;
  late String title;
  late String name;
  late String content;
  void initState() {
    // TODO: implement initState
    super.initState();
    titleController.addListener(() {
      setState(() {
        if (titleController.text.isNotEmpty && contentController.text.isNotEmpty && nameController.text.isNotEmpty) {
          submit = true;
        }
        else {
          submit = false;
        }
      });
    });

    contentController.addListener(() {
      setState(() {
        if (titleController.text.isNotEmpty && contentController.text.isNotEmpty && nameController.text.isNotEmpty) {
          submit = true;
        }
        else {
          submit = false;
        }
      });
    });

    nameController.addListener(() {
      setState(() {
        if (titleController.text.isNotEmpty && contentController.text.isNotEmpty && nameController.text.isNotEmpty) {
          submit = true;
        }
        else {
          submit = false;
        }
      });
    });

  }
  @override
  Widget build(BuildContext context) {
    String formatter = DateFormat.yMd().add_jm().format(now);
    final routeArgs = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    final doctoremail = routeArgs["doctoremail"];
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(
            "Blog",
            style: TextStyle(color: Theme.of(context).colorScheme.secondary),

          ),
          leading: BackButton(onPressed:  () {
            goBlog(context, doctoremail);
          }),
        ),
        body: ListView(
          children: [Padding(
            padding: EdgeInsets.fromLTRB(20, 40, 20, 0),
            child: Text("Write a blog!",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.black,
                    fontFamily: "Poppins",
                    fontSize: 25
                )
            ),
          ),
            Padding(
              padding: EdgeInsets.fromLTRB(45, 30, 45, 0),
              child: Container(
                width: 10.0,
                height: 550.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(20.0),
                  ),
                  color: Colors.lightGreen,
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                      child: Text("Name",
                        style: TextStyle(
                            fontSize: 18,
                            fontFamily: "Poppins",
                            color: Colors.black
                        ),),
                    ),
                    Padding(padding: EdgeInsets.fromLTRB(20, 5, 20, 0),
                        child: Theme(
                          data:Theme.of(context).copyWith(
                            colorScheme: ThemeData().colorScheme.copyWith(
                              primary:Color(0xff006400),
                            ),
                          ),
                          child: Column(
                            children: [
                              TextField(
                                  controller: nameController,
                                  onChanged: (value)
                                  {name = value;},
                                  cursorColor: Colors.black,
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.black, width: 2.0)),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.black),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.black),
                                    ),
                                    fillColor: Colors.white,
                                    filled: true,
                                    hintText: 'Enter your name',

                                  ),
                                  style: TextStyle(color: Colors.black, fontFamily: "Poppins")

                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                                child: Text("Title",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontFamily: "Poppins",
                                      color: Colors.black
                                  ),),
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                                child: TextField(
                                    controller: titleController,
                                    onChanged: (value)
                                    {title = value;},
                                    cursorColor: Colors.black,
                                    keyboardType: TextInputType.text,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.black, width: 2.0)),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.black),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.black),
                                      ),
                                      fillColor: Colors.white,
                                      filled: true,
                                      hintText: "Enter your blog's title",

                                    ),
                                    style: TextStyle(color: Colors.black, fontFamily: "Poppins")

                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                                child: Text("Content",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontFamily: "Poppins",
                                      color: Colors.black
                                  ),),
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                                child: TextField(
                                    controller: contentController,
                                    maxLines: 10,
                                    onChanged: (value)
                                    {content = value;},
                                    cursorColor: Colors.black,
                                    keyboardType: TextInputType.text,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.black, width: 2.0)),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.black),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.black),
                                      ),
                                      fillColor: Colors.white,
                                      filled: true,
                                      hintText: "Enter your blog's content",

                                    ),
                                    style: TextStyle(color: Colors.black, fontFamily: "Poppins")

                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(0, 12, 0, 0),
                                child: Text(formatter, textAlign: TextAlign.center, style: TextStyle(fontSize: 14, fontFamily: "Poppins"),),
                              ),
                            ],
                          ),
                        )),

                  ],
                ),

              ),
            ),
            Padding(padding: EdgeInsets.fromLTRB(100, 30, 100, 0)),
            Container(
              width: 100,
              padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
              decoration: new BoxDecoration(
                color: (submit == true ) ? Color(0xff006400) : Colors.grey,
                shape: BoxShape.circle,
              ),
              child:
              (submit == true ) ? IconButton(onPressed:  () async{
                try {

                  FirebaseFirestore.instance.collection('blog').doc(doctoremail).set({

                    'title': title,
                    'content': content,
                    'date': formatter,
                    'author': name,

                  },SetOptions(merge: true))
                      .then((value) => Navigator.pushNamed(context, '/tabsphysio', arguments: {
                    "doctoremail": doctoremail
                  }));
                  showAlertDialog(context, "You have successfully assigned this exercise to your patient!");
                  goBlog(context, doctoremail);
                }
                catch (e) {
                  print("Failed to add feedback: $e");
                }


              }, icon:
              Icon(Icons.send, color: Colors.white),
                iconSize: 40,
              ) : IconButton(onPressed:  null, icon:
              Icon(Icons.send, color: Colors.white),
                iconSize: 40,
              ),)
          ],
        )
    );
  }
}

void goProgress(BuildContext context, String? id, String? doctoremail) {
  Navigator.pushNamed(context, '/progress', arguments: {
    'id': id,
    'doctoremail': doctoremail
  });
}

showAlertDialog(BuildContext context, String e) {
  // set up the button
  Widget okButton = TextButton(
    child: Text("OK", style: TextStyle(color: Color(0xff006400))),
    onPressed: () {
      Navigator.pop(context, '/exercise');
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Success!"),
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

void goBlog(BuildContext context, String? doctoremail) {

  Navigator.pushNamed(context, '/tabsphysio', arguments: {
    "doctoremail": doctoremail
  });
}