import 'package:astar/widgets/physiocard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:dart_random_choice/dart_random_choice.dart';

class PhysioList extends StatefulWidget {
  const PhysioList({Key? key}) : super(key: key);

  @override
  State<PhysioList> createState() => _PhysioListState();
}

class _PhysioListState extends State<PhysioList> {
  @override
  Widget build(BuildContext context) {
    final routeArgs = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    final patientemail = routeArgs['patientemail'];
    final Stream<QuerySnapshot> doctors =
    FirebaseFirestore.instance.collection('doctoremail').snapshots();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "List of Physiotherapists",
          style: TextStyle(color: Theme.of(context).colorScheme.secondary),
        ),
        leading: BackButton(onPressed: (){goTabsPatient(context, patientemail);}),
      ),
      body:
        ListView(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 30, 20, 30),
              child: Text("Book an appointment with any of our affiliated physiotherapist!", style: TextStyle(fontSize: 25), textAlign: TextAlign.center,),
            ),
            StreamBuilder<QuerySnapshot>(
                stream: doctors,
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
                    child: ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: data.size,
                      itemBuilder: (context, index) {
                        return Slidable(
                            key: ValueKey(snapshot.data?.docs[index].id),
                            endActionPane: ActionPane(
                              motion: ScrollMotion(),
                              children: [
                                SlidableAction(
                                  onPressed: (context) {
                                    goAppointment(context, snapshot.data?.docs[index].id, patientemail);
                                  },
                                  label: 'Schedule',
                                  icon: Icons.date_range,
                                  backgroundColor: Colors.blue,
                                ),
                                SlidableAction(
                                  onPressed: (context) {
                                    goMessage(context, snapshot.data?.docs[index].id, patientemail);
                                  },
                                  label: 'Message',
                                  icon: Icons.message,
                                  backgroundColor: Colors.green,
                                ),
                              ],
                            ),
                            child: PhysioCard(
                              id: snapshot.data?.docs[index].id,
                              name: data.docs[index]['name'],
                              clinic: data.docs[index]['clinic'], pic:  data.docs[index]['pic'],

                            ));
                      },
                    ),
                  );
                })
          ],
        )
    );
  }
}

void goTabsPatient(BuildContext context,  String? patientemail) {
  Navigator.pushNamed(context, '/tabspatient', arguments: {
    'patientemail': patientemail
  });
}

void goMessage(BuildContext context, String? id, String? patientemail) {

  Navigator.pushNamed(context, '/messagepatient', arguments: {
    'id': id,
    'patientemail': patientemail
  });
}

void goAppointment(BuildContext context, String? id, String? patientemail) {

  Navigator.pushNamed(context, '/appointmentpatient', arguments: {
    'id': id,
    'patientemail': patientemail
  });
}