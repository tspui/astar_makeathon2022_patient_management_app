import 'package:astar/screens/acceptedappointmentpatient.dart';
import 'package:astar/screens/screenpatient.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'blogpatient.dart';
import 'dashboard.dart';
import 'blog.dart';
import 'messagepatient.dart';

class TabsPatient extends StatefulWidget {
  @override
  _TabsPatientState createState() => _TabsPatientState();
}

class _TabsPatientState extends State<TabsPatient> {

  final _auth = FirebaseAuth.instance;

  final List<Map<String, Object>> _pages = [
    {
      'page': ScreenPatientPage(),
      'title': 'Dashboard',
    },
    {
      'page': BlogPatientPage(),
      'title': 'Blog',
    },

    {
      'page': MessagePatientPage(),
      'title': 'Message',
    },

    {
      'page': AcceptedAppointmentPatient(),
      'title': 'Confirmed Appointments',
    },
  ];
  int _selectedPageIndex = 0;

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final routeArgs = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    final patientemail = routeArgs['patientemail'];
    return Scaffold(

      // drawer: MainDrawer(),
        appBar: AppBar(
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.notifications,
                color: Colors.black,
              ),
              onPressed: () {
                goNotif(context, patientemail);
                print(patientemail);
                // do something
              },
            )
          ],


          title: Text(
            _pages[_selectedPageIndex]['title'] as String,
            style: TextStyle(color: Theme.of(context).colorScheme.secondary),
          ),
          leading: BackButton(onPressed: () {
            goLogin(context);
          }),),
        body: _pages[_selectedPageIndex]['page'] as Widget,
        bottomNavigationBar: BottomNavigationBar(
            onTap: _selectPage,
            unselectedItemColor: Colors.grey,
            selectedItemColor: Theme.of(context).colorScheme.secondary,
            currentIndex: _selectedPageIndex,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.description),
                label: 'Dashboard',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.create_rounded),
                label: 'Blog',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.message),
                label: 'Message',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.date_range),
                label: 'Appointments',
              )

            ]));

  }
  void goLogin(BuildContext context) {
    {
      _auth.signOut();
      Navigator.pushNamed(context, '/loginpatient');

      //Implement logout functionality
    };
  }
}

void goNotif(BuildContext context, String? patientemail) {

  Navigator.pushNamed(context, '/notifpatient', arguments: {
    "patientemail": patientemail
  });

  print(patientemail);
}


