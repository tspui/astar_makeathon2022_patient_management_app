import 'package:astar/widgets/doctorappointmentnotifcard.dart';
import 'package:astar/widgets/doctormsgnotifcard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../widgets/assignedexercisecard.dart';
import '../widgets/patientappointmentcard.dart';
import '../widgets/patientmsgcard.dart';

class NotificationPatient extends StatefulWidget {
  const NotificationPatient ({Key? key}) : super(key: key);

  @override
  State<NotificationPatient> createState() => _NotificationPatientState();
}

class _NotificationPatientState extends State<NotificationPatient> {

  @override
  Widget build(BuildContext context) {
    final routeArgs = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    List messagecontent = [];
    List messagedate = [];
    final patientemail = routeArgs['patientemail'];
    final Stream<QuerySnapshot> patientnotif =
    FirebaseFirestore.instance.collection('patientlist').where(FieldPath.documentId, isEqualTo: patientemail).snapshots();
    return Scaffold(
      appBar: AppBar(
        title: Text("Notification",
          style: TextStyle(color: Theme.of(context).colorScheme.secondary),
        ),
        leading: BackButton(onPressed:  () {
          goTabs(context, patientemail);

        }),),
      backgroundColor: Colors.white,
      body: ListView(
        children: [

          StreamBuilder<QuerySnapshot>(
              stream: patientnotif,
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Text(snapshot.error.toString());
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Text('Loading');
                }
                final data = snapshot.requireData;

                return SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  physics: ScrollPhysics(),
                  child: Column(
                    children: [
                      data.docs[0]['appointment.content'].isEmpty  && data.docs[0]['message.content'].isEmpty? Center(child: Padding(
                        padding: EdgeInsets.fromLTRB(0, 350, 0, 0),
                        child: Text('No notifications found', style: TextStyle(
                          fontSize: 25,
                        ),),
                      )) :
                      ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: data.docs[0]['appointment.content'].length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [ApptPatientCard(id: snapshot.data?.docs[0].id[index], apptdate: data.docs[0]['appointment.content'][index], timestamp: data.docs[0]['appointment.date'][index], patientemail: patientemail),

                            ],
                          );
                        },
                      ),
                      data.docs[0]['appointment.content'].isEmpty && data.docs[0]['message.content'].isEmpty ? Center(child: Padding(
                        padding: EdgeInsets.fromLTRB(0, 350, 0, 0),
                        child: Text('', style: TextStyle(
                          fontSize: 25,
                        ),),
                      )):
                      ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: data.docs[0]['message.content'].length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              Slidable(
                                  key: ValueKey(snapshot.data?.docs[0].id[index]),
                                  endActionPane: ActionPane(
                                    motion: ScrollMotion(),
                                    children: [
                                      SlidableAction(
                                        onPressed: (context) async {
                                          final querySnapshot5 = await FirebaseFirestore.instance
                                              .collection('patientlist')
                                              .where(FieldPath.documentId, isEqualTo: patientemail)
                                              .get();
                                          for (var doc in querySnapshot5.docs) {
                                            messagecontent = doc.get('message.content');
                                            messagedate = doc.get('message.date');
                                          }

                                          messagecontent.remove(data.docs[0]['message.content'][index]);
                                          messagedate.remove(data.docs[0]['message.date'][index]);

                                          FirebaseFirestore.instance.collection('patientlist').doc(patientemail).set(
                                              {
                                                'message': {'content': messagecontent, 'date': messagedate},
                                              },SetOptions(merge: true)

                                          );


                                        },
                                        icon: Icons.highlight_remove,
                                        backgroundColor: Colors.red,
                                      ),
                                    ],
                                  ),
                                  child: MsgPatientCard(id: snapshot.data?.docs[0].id[index], content: data.docs[0]['message.content'][index], timestamp: data.docs[0]['message.date'][index], by: patientemail)),

                            ],
                          );
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

void goTabs(BuildContext context,  String? patientemail) {
  Navigator.pushNamed(context, '/tabspatient', arguments: {
    'patientemail': patientemail
  });
}