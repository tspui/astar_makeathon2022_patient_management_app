import 'package:astar/widgets/confirmedapptdoctor.dart';
import 'package:astar/widgets/confirmedapptpatient.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';


class AcceptedAppointmentDoctor extends StatefulWidget {
  const AcceptedAppointmentDoctor({Key? key}) : super(key: key);

  @override
  State<AcceptedAppointmentDoctor> createState() => _AcceptedAppointmentDoctorState();
}

class _AcceptedAppointmentDoctorState extends State<AcceptedAppointmentDoctor> {
  @override
  Widget build(BuildContext context) {
    List appointmentcontent = [];
    List appointmentwith = [];
    final routeArgs = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    final doctoremail = routeArgs['doctoremail'];
    final Stream<QuerySnapshot> docacceptedappt =
    FirebaseFirestore.instance.collection('confirmedapptdoc').where(FieldPath.documentId, isEqualTo: doctoremail).snapshots();
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: [

          StreamBuilder<QuerySnapshot>(
              stream: docacceptedappt,
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
                                          .collection('confirmedapptdoc')
                                          .where(FieldPath.documentId, isEqualTo: doctoremail)
                                          .get();
                                      for (var doc in querySnapshot5.docs) {
                                        appointmentcontent = doc.get('appointment.content');
                                        appointmentwith = doc.get('appointment.with');
                                      }

                                      appointmentcontent.remove(data.docs[0]['appointment.content'][index]);
                                      appointmentwith.remove(data.docs[0]['appointment.with'][index]);

                                      FirebaseFirestore.instance.collection('confirmedapptdoc').doc(doctoremail).set(
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


                              child: ConfirmedApptDoc(id: snapshot.data?.docs[0].id[index], apptdate: data.docs[0]['appointment.content'][index],  patientemail: data.docs[0]['appointment.with'][index]));

                        },
                      ),

                    ],
                  ),
                );
              })
        ],
      ),
    );
  }
}