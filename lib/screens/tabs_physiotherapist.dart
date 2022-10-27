import 'package:astar/screens/acceptedappointmentdoctor.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dashboard.dart';
import 'blog.dart';

class TabsPhysio extends StatefulWidget {
  @override
  _TabsPhysioState createState() => _TabsPhysioState();
}

class _TabsPhysioState extends State<TabsPhysio> {

  final _auth = FirebaseAuth.instance;

  final List<Map<String, Object>> _pages = [
    {
      'page': DashboardPage(),
      'title': 'Dashboard',
    },
    {
      'page': BlogPage(),
      'title': 'Blog',
    },
    {
      'page': AcceptedAppointmentDoctor(),
      'title': 'Confirmed Appointments',
    }
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
    final doctoremail = routeArgs['doctoremail'];
    return Scaffold(

      // drawer: MainDrawer(),
        appBar: AppBar(
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.notifications,
                color: Colors.black,
              ),
              onPressed: () { goNotif(context, doctoremail);
                print(doctoremail);
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
                icon: Icon(Icons.date_range),
                label: 'Appointments',
              )
            ]));

  }
  void goLogin(BuildContext context) {
    {
      _auth.signOut();
      Navigator.pushNamed(context, '/login');

      //Implement logout functionality
    };
  }
}

void goNotif(BuildContext context, String? doctoremail) {

  Navigator.pushNamed(context, '/notifphysio', arguments: {
    "doctoremail": doctoremail
  });
}
