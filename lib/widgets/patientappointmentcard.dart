import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';

class ApptPatientCard extends StatefulWidget {
  String? id;
  String apptdate;
  String timestamp;
  String patientemail;
  ApptPatientCard ({ Key? key, required this.id, required this.apptdate, required this.timestamp, required this.patientemail}): super(key: key);

  @override
  State<ApptPatientCard> createState() => _ApptPatientCardState();
}

class _ApptPatientCardState extends State<ApptPatientCard> {
  String doctoremail = '';
  List appointmentcontent = [];
  List appointmentwith = [];
  List appointmentcontent2 = [];
  List appointmentwith2 = [];
  List appointmentcontent3 = [];
  List appointmentdate3 = [];
  List appointmentcontent4 = [];
  List appointmentdate4 = [];


  PageController pageViewController = PageController(initialPage: 0);

  final birthdayController = TextEditingController();
  @override
  Widget build(BuildContext context) {

    return
      Card(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          elevation: 10,
          child: Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Color(0xFFEEEEEE),
            ),
            child:
            Column(
              children: [
                Row(
                  children: [
                    Flexible(
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(40, 15, 10, 0),
                        child: Text(
                          'Your doctor booked an appointment with you!',
                          style: TextStyle(
                              fontSize: 15,
                              color: Colors.black,
                              fontFamily: "Poppins"),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(35, 15, 10, 0),
                      child: Text(
                        'Appointment Date & Time:',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            color: Colors.black,
                            fontFamily: "Poppins"),
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
                        child:Text(
                          widget.apptdate,
                          style: TextStyle(
                              fontSize: 15,
                              color: Colors.black,
                              fontFamily: "Poppins"
                          ),
                        )),
                  ],
                ),
                Row(
                  children: [
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
                            child: Text('Accept',
                                style: TextStyle(fontSize: 15, fontFamily: "Poppins")),

                            onPressed: ()
                            async{


                              final querySnapshot2 = await FirebaseFirestore.instance
                                  .collection('patientlist')
                                  .where('patientemail', isEqualTo: widget.patientemail)
                                  .get();
                              for (var doc in querySnapshot2.docs) {
                                doctoremail = doc.get('doctoremail');
                              }

                              final querySnapshot = await FirebaseFirestore.instance
                                  .collection('confirmedapptpatient')
                                  .where(FieldPath.documentId, isEqualTo: widget.patientemail)
                                  .get();

                              for (var doc in querySnapshot.docs) {
                                // Getting data directly
                                appointmentcontent = doc.get('appointment.content');
                                appointmentwith = doc.get('appointment.with');
                              }

                              appointmentcontent.add(widget.apptdate);
                              appointmentwith.add(doctoremail);

                              FirebaseFirestore.instance.collection('confirmedapptpatient').doc(widget.patientemail).set(
                                  {
                                    'appointment': {'content': appointmentcontent, 'with': appointmentwith},
                                  },SetOptions(merge: true)

                              );

                              final querySnapshot3 = await FirebaseFirestore.instance
                                  .collection('confirmedapptdoc')
                                  .where(FieldPath.documentId, isEqualTo: doctoremail)
                                  .get();

                              for (var doc in querySnapshot3.docs) {
                                // Getting data directly
                                appointmentcontent2 = doc.get('appointment.content');
                                appointmentwith2 = doc.get('appointment.with');
                              }

                              appointmentcontent2.add(widget.apptdate);
                              appointmentwith2.add(widget.patientemail);

                              FirebaseFirestore.instance.collection('confirmedapptdoc').doc(doctoremail).set(
                                  {
                                    'appointment': {'content': appointmentcontent2, 'with': appointmentwith2},
                                  },SetOptions(merge: true)

                              );
                              print(widget.patientemail);

                              final querySnapshot4 = await FirebaseFirestore.instance
                                  .collection('patientlist')
                                  .where(FieldPath.documentId, isEqualTo: widget.patientemail)
                                  .get();
                              for (var doc in querySnapshot4.docs) {
                                appointmentcontent3 = doc.get('appointment.content');
                                appointmentdate3 = doc.get('appointment.date');
                              }

                              print(appointmentcontent3);
                              print(appointmentdate3);

                              appointmentcontent3.remove(widget.apptdate);
                              appointmentdate3.remove(widget.timestamp);

                              print(appointmentcontent3);
                              print(appointmentdate3);

                              FirebaseFirestore.instance.collection('patientlist').doc(widget.patientemail).set(
                                  {
                                    'appointment': {'content': appointmentcontent3, 'date': appointmentdate3},
                                  },SetOptions(merge: true)

                              );



                            },

                        )
                    ),
                    Padding(
                        padding: const EdgeInsets.fromLTRB(40, 10, 20, 0),
                        child:
                        TextButton(
                            style: ButtonStyle(
                                foregroundColor:
                                MaterialStateProperty.all<Color>(Colors.white),
                                backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.red),
                                padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                                    EdgeInsets.fromLTRB(50, 10, 50, 10)),
                                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(50.0)))),
                            child: Text('Decline',
                                style: TextStyle(fontSize: 15, fontFamily: "Poppins")),

                            onPressed: ()
                            async{
                            final querySnapshot5 = await FirebaseFirestore.instance
                                .collection('patientlist')
                                .where(FieldPath.documentId, isEqualTo: widget.patientemail)
                                .get();
                            for (var doc in querySnapshot5.docs) {
                            appointmentcontent4 = doc.get('appointment.content');
                            appointmentdate4 = doc.get('appointment.date');
                            }

                            appointmentcontent4.remove(widget.apptdate);
                            appointmentdate4.remove(widget.timestamp);

                            FirebaseFirestore.instance.collection('patientlist').doc(widget.patientemail).set(
                                {
                                  'appointment': {'content': appointmentcontent4, 'date': appointmentdate4},
                                },SetOptions(merge: true)

                            );

                            },

                        )
                    )
                  ],
                ),
                Row(
                  children: [
                    Padding(
                        padding: EdgeInsets.fromLTRB(0, 10, 0, 5),
                        child: Text(
                          widget.timestamp,
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
          )
      );
  }
}

showAlertDialog(BuildContext context, String e, String b) {
  // set up the button
  Widget okButton = TextButton(
    child: Text("OK", style: TextStyle(color: Color(0xff006400))),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text(b),
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

