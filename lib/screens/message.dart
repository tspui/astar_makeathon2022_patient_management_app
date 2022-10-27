import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MessagePage extends StatefulWidget {
  const MessagePage({Key? key}) : super(key: key);

  @override
  State<MessagePage> createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  final now = new DateTime.now();
  final myController = TextEditingController();
  bool submit = false;
  late String feedback;
  List messagecontent = [];
  List messagestatus = [];
  List messagedate = [];
  void initState() {
    // TODO: implement initState
    super.initState();
    myController.addListener(() {
      setState(() {
        if (myController.text.isNotEmpty) {
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
    final id = routeArgs["id"];
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(
            "Message",
            style: TextStyle(color: Theme.of(context).colorScheme.secondary),

          ),
          leading: BackButton(onPressed:  () {
            goDashboard(context, doctoremail);
          }),
        ),
        body: ListView(
          children: [Padding(
            padding: EdgeInsets.fromLTRB(20, 80, 20, 0),
            child: Text("Send a feedback or message on your patient's progress!",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.black,
                    fontFamily: "Poppins",
                    fontSize: 25
                )
            ),
          ),
            Padding(
              padding: EdgeInsets.fromLTRB(45, 50, 45, 0),
              child: Container(
                width: 10.0,
                height: 350.0,
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
                      child: Text("Feedback/Message",
                        style: TextStyle(
                            fontSize: 18,
                            fontFamily: "Poppins",
                            color: Colors.black
                        ),),
                    ),
                    Padding(padding: EdgeInsets.fromLTRB(20, 15, 20, 0),
                        child: Theme(
                          data:Theme.of(context).copyWith(
                            colorScheme: ThemeData().colorScheme.copyWith(
                              primary:Color(0xff006400),
                            ),
                          ),
                          child: Column(
                            children: [
                              TextField(
                                  maxLines: 10,
                                  controller: myController,
                                  onChanged: (value)
                                  {feedback = value;},
                                  cursorColor: Colors.black,
                                  keyboardType: TextInputType.multiline,
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
                                    hintText: 'Enter your feedback',

                                  ),
                                  style: TextStyle(color: Colors.black, fontFamily: "Poppins")

                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(0, 12, 0, 0),
                                child: Text(formatter, textAlign: TextAlign.center, style: TextStyle(fontSize: 14, fontFamily: "Poppins"),),
                              )
                            ],
                          ),
                        )),

                  ],
                ),

              ),
            ),
            Padding(padding: EdgeInsets.fromLTRB(100, 70, 100, 0)),
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

                  final querySnapshot = await FirebaseFirestore.instance
                      .collection('patientlist')
                      .where('patientemail', isEqualTo: id)
                      .get();

                  for (var doc in querySnapshot.docs) {
                    // Getting data directly
                    messagecontent = doc.get('message.content');
                    messagedate = doc.get('message.date');
                  }

                  messagecontent.add(feedback);
                  messagedate.add(formatter);

                  FirebaseFirestore.instance.collection('patientlist').doc(id).set(
                      {
                        'message': {'content': messagecontent, 'date': messagedate},
                      },SetOptions(merge: true)

                  );
                  goDashboard(context, doctoremail);
                  showAlertDialog(context, "You have successfully sent a message to your patient!");

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

void goDashboard(BuildContext context,  String? doctoremail) {
  Navigator.pushNamed(context, '/tabsphysio', arguments: {
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