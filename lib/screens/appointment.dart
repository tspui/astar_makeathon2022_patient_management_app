import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';

class AppointmentPage extends StatefulWidget {
  const AppointmentPage({Key? key}) : super(key: key);

  @override
  State<AppointmentPage> createState() => _AppointmentPageState();
}
String _selectedDate = '';
class _AppointmentPageState extends State<AppointmentPage> {
  final now = new DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  @override
  Widget build(BuildContext context) {
    String formatter = DateFormat.yMd().add_jm().format(now);
    final routeArgs = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    final doctoremail = routeArgs['doctoremail'];
    final id = routeArgs['id'];
    String apptTime = '';
    String _dateCount = '';
    String _range = '';
    String _rangeCount = '';
    List appointmentcontent = [];
    List appointmentstatus = [];
    List appointmentdate = [];
    void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
      setState(() {
        if (args.value is PickerDateRange) {
          _range = '${DateFormat('dd/MM/yyyy').format(args.value.startDate)} -'
          // ignore: lines_longer_than_80_chars
              ' ${DateFormat('dd/MM/yyyy').format(args.value.endDate ?? args.value.startDate)}';
        } else if (args.value is DateTime) {
          _selectedDate = args.value.toString();
        } else if (args.value is List<DateTime>) {
          _dateCount = args.value.length.toString();
        } else {
          _rangeCount = args.value.length.toString();
        }
      });
    }

    return Scaffold(
      appBar: AppBar(
    title: Text("Schedule Appointment",
    style: TextStyle(color: Theme.of(context).colorScheme.secondary),
    ),
    leading: BackButton(onPressed:  () {goTabs(context, doctoremail);

    }),),
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(10, 70, 10, 20),
            child: Text("When do you want to schedule an appointment?",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize:25,
            ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(20, 40, 20, 0),
            child: Column(
              children: [
                Container(
                  child: SfDateRangePicker(
                    onSelectionChanged: _onSelectionChanged,
                  ),

                ),
                ElevatedButton(
                  onPressed: () {
                    _selectTime(context);
                  },
                  child: Text("Choose Time"),
                ),
                (selectedTime.minute<10)?Text("${selectedTime.hour}:0${selectedTime.minute}"):
                Text("${selectedTime.hour}:${selectedTime.minute}")
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(20, 60, 20, 10),
            child: TextButton(
              onPressed:() async{

                if (selectedTime.minute<10)
                {apptTime = "${selectedTime.hour}:0${selectedTime.minute}";}
                else
                {apptTime = "${selectedTime.hour}:${selectedTime.minute}";}

                _selectedDate + selectedTime.toString();
                if (_selectedDate != null && _selectedDate.length >= 12) {
                  _selectedDate = _selectedDate.substring(0, _selectedDate.length - 12);
                }
                print(_selectedDate);

                final querySnapshot = await FirebaseFirestore.instance
                    .collection('patientlist')
                    .where('patientemail', isEqualTo: id)
                    .get();

                for (var doc in querySnapshot.docs) {
                  // Getting data directly
                  appointmentcontent = doc.get('appointment.content');
                  appointmentdate = doc.get('appointment.date');
                }

                appointmentcontent.add(_selectedDate + apptTime);
                appointmentdate.add(formatter);

                FirebaseFirestore.instance.collection('patientlist').doc(id).set(
                    {
                    'appointment': {'content': appointmentcontent, 'date': appointmentdate},
                    },SetOptions(merge: true)

                );
                goTabs(context, doctoremail);
                showAlertDialog(context, "You have successfully made an appointment with this patient!");

                },
              style: ButtonStyle(

                  foregroundColor:MaterialStateProperty.all<Color>(Colors.white)
                  ,
                  backgroundColor:MaterialStateProperty.all<Color>(Color(0xff006400)),
                  padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                      EdgeInsets.fromLTRB(55, 10, 55, 10)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50.0)))),
              child: Text('Schedule',
                  style: TextStyle(fontSize: 20, fontFamily: "Poppins")),
            ),
          ),

        ],
      )

    );
  }

  _selectTime(BuildContext context) async {
    final TimeOfDay? timeOfDay = await showTimePicker(
      context: context,
      initialTime: selectedTime,
      initialEntryMode: TimePickerEntryMode.dial,

    );
    if(timeOfDay != null && timeOfDay != selectedTime)
    {
      setState(() {
        selectedTime = timeOfDay;
      });
    }
  }

}


void goTabs(BuildContext context, String? doctoremail)
{Navigator.pushNamed(
  context,
  '/tabsphysio',
  arguments: {
    'doctoremail': doctoremail
  }
);}

showAlertDialog(BuildContext context, String e) {
  // set up the button
  Widget okButton = TextButton(
    child: Text("OK", style: TextStyle(color: Color(0xff006400))),
    onPressed: () {
      Navigator.pop(context, '/exercise');
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Success!"),
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