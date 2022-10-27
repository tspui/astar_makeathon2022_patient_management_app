import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import '../class/exerciselist.dart';
import '../widgets/exerciseswidget.dart';

class ExercisePage extends StatefulWidget {
  @override
  State<ExercisePage> createState() => _ExercisePageState();
}

class _ExercisePageState extends State<ExercisePage> {
  var exerciseList = ExerciseList().exerciselist;

  @override
  void initState() {
    // finalSelected = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final routeArgs = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    final id = routeArgs["id"];
    final doctoremail = routeArgs["doctoremail"];

    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Assign Exercises",
            style: TextStyle(color: Theme.of(context).colorScheme.secondary),
          ),
          leading: BackButton(onPressed: () {
            goTabs(context, doctoremail);
          }),
        ),
        body: ListView(children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
            child: Container(
              width: 800,
              height: 130,
              child: const Padding(
                padding: EdgeInsets.fromLTRB(0, 40, 0, 20),
                child: Text(
                    "Please select the exercise you want to assign your patients to.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.black,
                        fontFamily: "Poppins",
                        fontSize: 25)),
              ),
            ),
          ),
          SingleChildScrollView(
            child: ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: exerciseList.length,
                itemBuilder: (context, ind) {
                  var exerciseLists = exerciseList[ind];
                  print(doctoremail);
                  return ExerciseWidget(exerciseLists, id, doctoremail);
                }),
          )
        ]));
  }
}



void goTabs(BuildContext context,  String? doctoremail) {
  Navigator.pushNamed(context, '/tabsphysio', arguments: {
    'doctoremail': doctoremail
  });
}



