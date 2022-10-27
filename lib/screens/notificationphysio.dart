import 'package:astar/widgets/doctorappointmentnotifcard.dart';
import 'package:astar/widgets/doctormsgnotifcard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class NotificationPhysio extends StatefulWidget {
  const NotificationPhysio({Key? key}) : super(key: key);

  @override
  State<NotificationPhysio> createState() => _NotificationPhysioState();
}

class _NotificationPhysioState extends State<NotificationPhysio> {

  @override
  Widget build(BuildContext context) {
    final routeArgs = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    final doctoremail = routeArgs['doctoremail'];
    List messagecontent = [];
    List messagedate = [];
    List messageby= [];
    final Stream<QuerySnapshot> doctornotif =
    FirebaseFirestore.instance.collection('doctornotification').where(FieldPath.documentId, isEqualTo: doctoremail).snapshots();
    return Scaffold(
      appBar: AppBar(
        title: Text("Notification",
          style: TextStyle(color: Theme.of(context).colorScheme.secondary),
        ),
        leading: BackButton(onPressed:  () {
          goTabs(context, doctoremail);

        }),),
      backgroundColor: Colors.white,
      body: ListView(
        children: [

          StreamBuilder<QuerySnapshot>(
              stream: doctornotif,
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
                      data.docs[0]['appointment.content'].isEmpty &&  data.docs[0]['message.content'].isEmpty ? Center(child: Padding(
                        padding: EdgeInsets.fromLTRB(0, 350, 0, 0),
                        child: Text('No notifications found', style: TextStyle(
                          fontSize: 25,
                        ),),
                      )) :

                      ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: data.docs[0]['appointment.content']?.length?? 0 ,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              ApptDocCard(id: snapshot.data?.docs[0].id[index], apptdate: data.docs[0]['appointment.content'][index], timestamp: data.docs[0]['appointment.date'][index], name: data.docs[0]['appointment.by'][index], doctoremail: doctoremail),

                            ],
                          );
                        },
                      ),
                      data.docs[0]['message.content'].isEmpty && data.docs[0]['appointment.content'].isEmpty ? Center(child: Text('')):
                      ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: data.docs[0]['message.content']?.length ?? 0,
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
                                              .collection('doctornotification')
                                              .where(FieldPath.documentId, isEqualTo: doctoremail)
                                              .get();
                                          for (var doc in querySnapshot5.docs) {
                                            messagecontent = doc.get('message.content');
                                            messagedate = doc.get('message.date');
                                            messageby = doc.get('message.by');
                                          }

                                          messageby.remove(data.docs[0]['message.by'][index]);
                                          messagecontent.remove(data.docs[0]['message.content'][index]);
                                          messagedate.remove(data.docs[0]['message.date'][index]);

                                          FirebaseFirestore.instance.collection('doctornotification').doc(doctoremail).set(
                                              {
                                                'message': {'content': messagecontent, 'date': messagedate, 'by': messageby},
                                              },SetOptions(merge: true)

                                          );


                                        },
                                        icon: Icons.highlight_remove,
                                        backgroundColor: Colors.red,
                                      ),
                                    ],
                                  ),
                                  child: MsgDocCard(id: snapshot.data?.docs[0].id[index], content: data.docs[0]['message.content'][index], timestamp: data.docs[0]['message.date'][index], name: data.docs[0]['message.by'][index])),

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

void goTabs(BuildContext context,  String? doctoremail) {
  Navigator.pushNamed(context, '/tabsphysio', arguments: {
    'doctoremail': doctoremail
  });
}