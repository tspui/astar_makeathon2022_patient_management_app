import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import '../widgets/dashboardcard.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../widgets/expandablewidget.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {

  bool clicked = false;

  @override
  Widget build(BuildContext context) {
    final routeArgs = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    final doctoremail = routeArgs['doctoremail'];

    final Stream<QuerySnapshot> patients =
    FirebaseFirestore.instance.collection('patientlist').where('doctoremail', isEqualTo: doctoremail).snapshots();
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
                    child: Text('No patients found', style: TextStyle(
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
                          child: const Padding(
                            padding: EdgeInsets.fromLTRB(0, 40, 0, 0),
                            child: Text("List of Patients",
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
                    child: ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: data.size,
                      itemBuilder: (context, index) {
                        return Slidable(
                            key: ValueKey(snapshot.data?.docs[index].id),
                            startActionPane: ActionPane(
                              motion: ScrollMotion(),
                              children: [
                                SlidableAction(
                                  onPressed: (context) async {
                                    DeletePatient(snapshot.data?.docs[index].id);
                                  },
                                  label: 'Delete',
                                  icon: Icons.delete_forever_outlined,
                                  backgroundColor: Colors.red,
                                ),
                                SlidableAction(
                                  onPressed: (context) {
                                    setState(() {
                                      clicked = true;
                                    });
                                  },
                                  label: 'Edit',
                                  icon: Icons.edit,
                                  backgroundColor: Colors.blue,
                                ),
                              ],
                            ),
                            endActionPane: ActionPane(
                              motion: ScrollMotion(),
                              children: [
                                SlidableAction(
                                  onPressed: (context) {
                                    goSchedule(context, snapshot.data?.docs[index].id, snapshot.data?.docs[index]['doctoremail']);
                                  },
                                  icon: Icons.date_range,
                                  backgroundColor: Colors.green,
                                ),
                                SlidableAction(
                                  onPressed: (context) {
                                    goExercises(
                                        context, snapshot.data?.docs[index].id,  snapshot.data?.docs[index]['doctoremail']);
                                  },
                                  icon: Icons.directions_run,
                                  backgroundColor: Colors.blue,
                                ),
                                SlidableAction(
                                  onPressed: (context) {
                                    goMessage(context, snapshot.data?.docs[index].id, snapshot.data?.docs[index]['doctoremail']);
                                  },
                                  icon: Icons.message,
                                  backgroundColor: Colors.orange,
                                ),
                              ],
                            ),
                            child: DashboardCard(
                              id: snapshot.data?.docs[index].id,
                              name: data.docs[index]['name'],
                              birthday: data.docs[index]['birthday'],
                              height: data.docs[index]['height'],
                              weight: data.docs[index]['weight'],
                              condition: data.docs[index]['condition'],
                              contact: data.docs[index]['contactnumber'],
                              email: data.docs[index]['patientemail'],
                              clicked: clicked,
                            ));
                      },
                    ),
                )],
                  );
              }),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xff006400),
        onPressed: () {addPatient(context, doctoremail);},
        child: const Icon(Icons.person_add),
      ),
    );
  }
}

void DeletePatient(id) {
  FirebaseFirestore.instance.collection("patientlist").doc(id).delete();
  FirebaseFirestore.instance.collection("patientemail").doc(id).delete();
  FirebaseFirestore.instance.collection("confirmedapptpatient").doc(id).delete();
}

void goExercises(BuildContext context, String? id, String? doctoremail) {

  Navigator.pushNamed(context, '/exercise', arguments: {
    'id': id,
    'doctoremail': doctoremail
  });
}

void goSchedule(BuildContext context, String? id, String? doctoremail) {

  Navigator.pushNamed(context, '/appointment', arguments: {
    'id': id,
    'doctoremail': doctoremail
  });
}

void goMessage(BuildContext context, String? id, String? doctoremail) {

  Navigator.pushNamed(context, '/message', arguments: {
    'id': id,
    'doctoremail': doctoremail
  });
}

void addPatient(BuildContext context, String? doctoremail) {

  Navigator.pushNamed(context, '/adduser', arguments: {
    "doctoremail": doctoremail
  });
}