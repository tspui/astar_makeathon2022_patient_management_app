import 'package:astar/widgets/confirmedapptpatient.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';


class AcceptedAppointmentPatient extends StatefulWidget {
  const AcceptedAppointmentPatient({Key? key}) : super(key: key);

  @override
  State<AcceptedAppointmentPatient> createState() => _AcceptedAppointmentPatientState();
}

class _AcceptedAppointmentPatientState extends State<AcceptedAppointmentPatient> {
  @override
  Widget build(BuildContext context) {
    final routeArgs = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    final patientemail = routeArgs['patientemail'];
    List appointmentcontent = [];
    List appointmentwith = [];
    final Stream<QuerySnapshot> patientacceptedappt =
    FirebaseFirestore.instance.collection('confirmedapptpatient').where(FieldPath.documentId, isEqualTo: patientemail).snapshots();
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: [

          StreamBuilder<QuerySnapshot>(
              stream: patientacceptedappt,
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Text(snapshot.error.toString());
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Text('Loading');
                }
                final data = snapshot.requireData;

                print(data.docs);

                return SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  physics: ScrollPhysics(),
                  child: Column(
                    children: [
                      data.docs[0]['appointment.content'].isEmpty ? Center(child: Padding(
                        padding: EdgeInsets.fromLTRB(0, 350, 0, 0),
                        child: Text('No confirmed appointments', style: TextStyle(
                          fontSize: 25,
                        ),),
                      )) :
                      ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount:  data.docs[0]['appointment.content'].length,
                        itemBuilder: (context, index) {
                          return  Slidable(

                              key: ValueKey(snapshot.data?.docs[0].id[index]),
                              endActionPane: ActionPane(
                                motion: ScrollMotion(),
                                children: [
                                  SlidableAction(
                                    onPressed: (context) async {
                                      final querySnapshot5 = await FirebaseFirestore.instance
                                          .collection('confirmedapptpatient')
                                          .where(FieldPath.documentId, isEqualTo: patientemail)
                                          .get();
                                      for (var doc in querySnapshot5.docs) {
                                        appointmentcontent = doc.get('appointment.content');
                                        appointmentwith = doc.get('appointment.with');
                                      }

                                      appointmentcontent.remove(data.docs[0]['appointment.content'][index]);
                                      appointmentwith.remove(data.docs[0]['appointment.with'][index]);

                                      FirebaseFirestore.instance.collection('confirmedapptpatient').doc(patientemail).set(
                                          {
                                            'appointment': {'content': appointmentcontent, 'with': appointmentwith},
                                          },SetOptions(merge: true)

                                      );


                                    },
                                    icon: Icons.highlight_remove,
                                    backgroundColor: Colors.red,
                                  ),
                                ],
                              ),


                              child: ConfirmedApptPatient(id: snapshot.data?.docs[0].id[index], apptdate: data.docs[0]['appointment.content'][index],  doctorname: data.docs[0]['appointment.with'][index],));

                        },
                      ),

                    ],
                  ),
                );
              })
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          print(patientemail);
          goSchedule(context, patientemail);
          },
        backgroundColor: Color(0xff006400),
        child: const Icon(Icons.add),
      ),
    );
  }
  }

void goSchedule(BuildContext context,  String? patientemail) {
  Navigator.pushNamed(context, '/appointmentpatient', arguments: {
    'patientemail': patientemail
  });
}