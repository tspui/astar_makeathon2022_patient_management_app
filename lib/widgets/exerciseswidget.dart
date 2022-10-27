import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../class/exercises.dart';
import 'package:intl/intl.dart';

class ExerciseWidget extends StatefulWidget {
  Exercises exercises;
  String id;
  String name;

  ExerciseWidget(this.exercises, this.id, this.name);

  @override
  State<ExerciseWidget> createState() => _ExerciseWidgetState();
}

class _ExerciseWidgetState extends State<ExerciseWidget> {

  final now = new DateTime.now();
  PageController pageViewController = PageController(initialPage: 0);
  bool showSpinner = false;
  List assignedexercisecontent = [];
  List assignedexercisestatus = [];
  List assignedexercisedate = [];


  @override
  Widget build(BuildContext context) {
    String formatter = DateFormat.yMd().add_jm().format(now);
    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: Card(clipBehavior: Clip.antiAliasWithSaveLayer,
        elevation: 10,
        child: Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            color: Color(0xFFEEEEEE),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                      child: Padding(
                        padding:
                        const EdgeInsets.fromLTRB(10, 10, 10, 10),
                        child: SizedBox(
                          width: 500,
                          height: 200,
                          child: Image.asset(
                            widget.exercises.pic,
                            width: 200,
                          ),
                        ),
                      )),
                  Container(
                    width: 200,
                    decoration: const BoxDecoration(
                      color: Color(0xFFEEEEEE),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:  [
                        Padding(
                          padding:
                          EdgeInsets.fromLTRB(0, 65, 10, 0),
                          child: Text(
                            widget.exercises.name,

                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Colors.black,
                                fontFamily: "Poppins"
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Padding(
                            padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                            child:
                            TextButton(
                                style: ButtonStyle(
                                    foregroundColor:
                                    MaterialStateProperty.all<Color>(Colors.white),
                                    backgroundColor:
                                    MaterialStateProperty.all<Color>(Color(0xff006400)),
                                    padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                                        EdgeInsets.fromLTRB(50, 10, 50, 10)),
                                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(50.0)))),
                                child: Text('Assign',
                                    style: TextStyle(fontSize: 15, fontFamily: "Poppins")),

                                onPressed: ()
                                  async {
                                    setState(() {
                                      showSpinner = true;
                                    });
                                    try {

                                      final querySnapshot = await FirebaseFirestore.instance
                                          .collection('patientlist')
                                          .where('patientemail', isEqualTo: widget.id)
                                          .get();

                                      for (var doc in querySnapshot.docs) {
                                        // Getting data directly
                                        assignedexercisecontent = doc.get('assignedexercise.content');
                                        assignedexercisedate = doc.get('assignedexercise.date');
                                      }

                                      assignedexercisecontent.add(widget.exercises.name);
                                      assignedexercisedate.add(formatter);

                                      FirebaseFirestore.instance.collection('patientlist').doc(widget.id).set(
                                          {
                                            'assignedexercise': {'content': assignedexercisecontent, 'date': assignedexercisedate},
                                          },SetOptions(merge: true)

                                      );
                                      showAlertDialog(context, "You have successfully assigned this exercise to your patient!");
                                    }

                                    catch (e) {
                                      print("Failed to add patient: $e");
                                    }


                                    setState(() {
                                      showSpinner = false;
                                    });
                                  }

                                )
                        )


                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),


      ),
    );
  }
}

void goTabs(BuildContext context,  String? doctoremail) {
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