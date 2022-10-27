import 'package:astar/widgets/assignedexercisecard2.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

import '../widgets/dashboardcard.dart';

class ScreenPatientPage extends StatefulWidget {
  const ScreenPatientPage({Key? key}) : super(key: key);

  @override
  State<ScreenPatientPage> createState() => _ScreenPatientPageState();
}

class _ScreenPatientPageState extends State<ScreenPatientPage> {

  @override
  Widget build(BuildContext context) {
    final routeArgs = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    final patientemail = routeArgs['patientemail'];

    final Stream<QuerySnapshot> patients =
    FirebaseFirestore.instance.collection('patientlist').where('patientemail', isEqualTo: patientemail).snapshots();
    return Scaffold(
      backgroundColor: Colors.white,
      body:
      StreamBuilder<QuerySnapshot>(
          stream: patients,
          builder: (BuildContext context,
              AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Text('Loading');
            }
            final data = snapshot.requireData;
            return
              data.size == 0 ? Center(child: Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: Text('No data found', style: TextStyle(
                  fontSize: 25,
                ),),
              )) :
              ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                    child: Container(
                      width: 800,
                      height: 100,
                      child:
                      data.docs[0]['assignedexercise.content'].isEmpty ? Center(child: Padding(
                        padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                        child: Text('', style: TextStyle(
                          fontSize: 25,
                        ),),
                      )):
                      const Padding(
                        padding: EdgeInsets.fromLTRB(0, 40, 0, 0),
                        child: Text("Assigned Exercises",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.black,
                                fontFamily: "Poppins",
                                fontSize: 25)),
                      ),
                    ),
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    physics: ScrollPhysics(),
                    child:
                    data.docs[0]['assignedexercise.content'].isEmpty ? Center(child: Padding(
                      padding: EdgeInsets.fromLTRB(0, 250, 0, 0),
                      child: Text('No assigned exercises found', style: TextStyle(
                        fontSize: 25,
                      ),),
                    )):
                    ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: data.docs[0]['assignedexercise.content'].length,
                      itemBuilder: (context, index) {
                        return  AssignedExercise2Card(photo:
                        data.docs[0]['assignedexercise.content'][index] == "Middle Scalene Stretch" ? "images/middle_scalene1.jpg" :
                        data.docs[0]['assignedexercise.content'][index] == "Seated Thoracic Extension with Shoulder Flex" ? "images/seated_thoracic.jpg":
                            data.docs[0]['assignedexercise.content'][index] == "Active Neck Lateral Flexion Stretch" ? "images/neck.jpg":
                            data.docs[0]['assignedexercise.content'][index] == "Seated Trunk Lateral Flexion and Rotation" ? "images/seatedTrunk.jpg": "images/hip.jpg"
                            , id: snapshot.data?.docs[0].id[index], name: data.docs[0]['assignedexercise.content'][index]
                            , date: data.docs[0]['assignedexercise.date'][index]);
                      },
                    ),
                  )],
              );
          }),
    );
  }
}
