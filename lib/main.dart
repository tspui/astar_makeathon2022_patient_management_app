// @dart=2.9
import 'package:astar/screens/appointmentpatient.dart';
import 'package:astar/screens/blogadd.dart';
import 'package:astar/screens/blogpatient.dart';
import 'package:astar/screens/exercise21.dart';
import 'package:astar/screens/general_exercise.dart';
import 'package:astar/screens/messagepatient.dart';
import 'package:astar/screens/motion21.dart';
import 'package:astar/screens/notificationpatient.dart';
import 'package:astar/screens/notificationphysio.dart';
import 'package:astar/screens/physiolist.dart';
import 'package:astar/screens/tabs_patient.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'screens/login.dart';
import 'screens/register.dart';
import 'screens/tabs_physiotherapist.dart';
import 'screens/appointment.dart';
import 'screens/exercise.dart';
import 'screens/progress.dart';
import 'screens/adduser.dart';
import 'firebase_options.dart';
import 'screens/loginpatient.dart';
import 'screens/registerpatient.dart';
import 'screens/screenpatient.dart';
import 'screens/message.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'XPhysio',
      theme:
      ThemeData(
          scaffoldBackgroundColor: Colors.white,
          primaryColor: Colors.black,
          colorScheme: ColorScheme.fromSwatch(
            primarySwatch: Colors.lightGreen,
            accentColor: Colors.black,
            backgroundColor: Colors.white,

          ),
          fontFamily: "Poppins",
          textTheme: Theme.of(context).textTheme.copyWith(
              headline6: TextStyle(
                fontFamily: "Poppins",
                fontSize: 20,
                fontWeight: FontWeight.bold,
              )
          )
      ),
      routes: {
        '/': (context) => Home(),
        '/login': (context) => LoginPage(),
        '/register': (context) => RegistrationPage(),
        '/tabsphysio': (context) => TabsPhysio(),
        '/appointment': (context) => AppointmentPage(),
        '/exercise': (context) => ExercisePage(),
        '/progress': (context) => ProgressPage(),
        '/adduser': (context) => AddUser(),
        '/loginpatient': (context) => LoginPatientPage(),
        '/registerpatient': (context) => RegistrationPatientPage(),
        '/screenpatient': (context) => ScreenPatientPage(),
        '/message': (context) => MessagePage(),
        '/tabspatient': (context) => TabsPatient(),
        '/blogpatient': (context) => BlogPatientPage(),
        '/exercise21': (context) => Exercise21Days(),
        '/motion21': (context) => Motion21Days(),
        '/physiolist': (context) => PhysioList(),
        '/blogadd': (context) => BlogAdd(),
        '/notifphysio': (context) => NotificationPhysio(),
        '/notifpatient': (context) => NotificationPatient(),
        '/messagepatient': (context) => MessagePatientPage(),
        '/appointmentpatient': (context) => AppointmentPatientPage(),
        // '/instructionpreview': (context) => GeneralExercise()
      },
    );
  }
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: ListView(
          children: [
            Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 50, 0, 0),
                child: Image.asset('images/X-Physio.png',
                    width: 376, height: 400, fit: BoxFit.cover)),
            Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                      child: TextButton(
                        style: ButtonStyle(
                            foregroundColor:
                            MaterialStateProperty.all<Color> (Colors.black),
                            backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.lightGreen),
                            padding:
                            MaterialStateProperty.all<EdgeInsetsGeometry>(
                                EdgeInsets.fromLTRB(80, 10, 80, 10)),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius:
                                    BorderRadius.circular(50.0)))),
                        onPressed:  () {
                          Navigator.pushNamed(
                            context,
                            '/loginpatient',
                          );
                        },
                        child: Text('Patient',
                            style:
                            TextStyle(fontSize: 20, fontFamily: "Poppins")),
                      ),
                    ),
                    Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 50, 0, 0),
                        child: TextButton(
                          style: ButtonStyle(
                              foregroundColor: MaterialStateProperty.all<Color>(
                                  Colors.black),
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.lightGreen),
                              padding:
                              MaterialStateProperty.all<EdgeInsetsGeometry>(
                                  EdgeInsets.fromLTRB(40, 10, 40, 10)),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius:
                                      BorderRadius.circular(50.0)))),
                          onPressed: () {
                            Navigator.pushNamed(
                              context,
                              '/login',
                            );
                          },
                          child: Text('Physiotherapist',
                              style: TextStyle(
                                  fontSize: 20, fontFamily: "Poppins")),
                        ))
                  ],
                ))
          ],
        ));
  }

}
