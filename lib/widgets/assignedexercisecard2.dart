import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../class/exercises.dart';
import 'package:intl/intl.dart';

import '../model/exercise_list.dart';
import '../screens/instructionpreview.dart';

class AssignedExercise2Card extends StatefulWidget {
  String? id;
  String photo;
  String name;
  String date;

  AssignedExercise2Card ({ Key? key, required this.id, required this.photo, required this.name, required this.date}): super(key: key);

  @override
  State<AssignedExercise2Card> createState() => _AssignedExercise2CardState();
}

class _AssignedExercise2CardState extends State<AssignedExercise2Card> {

  PageController pageViewController = PageController(initialPage: 0);
  bool showSpinner = false;
  late final Exercise item;


  @override
  Widget build(BuildContext context) {
    final routeArgs = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    final patientemail = routeArgs['patientemail'];
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
                            widget.photo,
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
                          EdgeInsets.fromLTRB(0, 35, 10, 0),
                          child: Text(
                            widget.name,

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
                            padding: const EdgeInsets.fromLTRB(10, 20, 20, 10),
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
                                child: Text('Complete',
                                    style: TextStyle(fontSize: 15, fontFamily: "Poppins")),

                                onPressed: (){
                                  var ListExercise = Exercise.getExercises();
                                  if (widget.name == "Middle Scalene Stretch")
                                    {item = ListExercise[1];
                                    }
                                  else if (widget.name == "Seated Thoracic Extension with Shoulder Flex")
                                    {item = ListExercise[0];
                                    }
                                  else if (widget.name == "Active Neck Lateral Flexion Stretch")
                                    {item = ListExercise[2];
                                    }
                                  else if (widget.name == "Seated Trunk Lateral Flexion and Rotation")
                                    {
                                      item = ListExercise[3];
                                    }
                                  else
                                  {
                                    item = ListExercise[4];
                                  }

                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => InstrucToPreview(item: item, patientemail: patientemail,)),
                                  );

                                }

                            )
                        ),
                        Row(
                          children: [
                            Padding(
                                padding: EdgeInsets.fromLTRB(30, 10, 0, 0),
                                child: Text(
                                  widget.date,
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
