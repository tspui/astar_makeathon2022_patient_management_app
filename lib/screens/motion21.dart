import 'package:flutter/material.dart';

class Motion21Days extends StatefulWidget {
  const Motion21Days({Key? key}) : super(key: key);

  @override
  State<Motion21Days> createState() => _Motion21DaysState();
}

class _Motion21DaysState extends State<Motion21Days> {
  @override
  Widget build(BuildContext context) {
    final routeArgs = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    final patientemail = routeArgs['email'];
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "21 Days Challenge",
            style: TextStyle(color: Theme.of(context).colorScheme.secondary),
          ),
          leading: BackButton(onPressed: (){
            goDashboardPatient(context, patientemail);
          }),
        ),
        body:
        Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(30, 40, 30, 20),
              child: Text("Complete all the range motion stretches in 21 days!", style: TextStyle(fontFamily: "Poppins", fontSize: 25), textAlign: TextAlign.center,),
            ),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(35, 20, 0, 0),
                  child: Container(
                    width: 70.0,
                    height: 70.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10.0),
                      ),
                      color: Color(0xFFE8E8E8),
                    ),
                    child: Center(
                      child: Text("1", textAlign: TextAlign.center, style: TextStyle(fontSize: 20),),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(20, 20, 0, 0),
                  child: Container(
                    width: 70.0,
                    height: 70.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10.0),
                      ),
                      color: Color(0xFFE8E8E8),
                    ),
                    child: Center(
                      child: Text("2", textAlign: TextAlign.center, style: TextStyle(fontSize: 20),),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(20, 20, 0, 0),
                  child: Container(
                    width: 70.0,
                    height: 70.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10.0),
                      ),
                      color: Color(0xFFE8E8E8),
                    ),
                    child: Center(
                      child: Text("3", textAlign: TextAlign.center, style: TextStyle(fontSize: 20),),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(20, 20, 0, 0),
                  child: Container(
                    width: 70.0,
                    height: 70.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10.0),
                      ),
                      color: Color(0xFFE8E8E8),
                    ),
                    child: Center(
                      child: Text("4", textAlign: TextAlign.center, style: TextStyle(fontSize: 20),),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(35, 20, 0, 0),
                  child: Container(
                    width: 70.0,
                    height: 70.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10.0),
                      ),
                      color: Color(0xFFE8E8E8),
                    ),
                    child: Center(
                      child: Text("5", textAlign: TextAlign.center, style: TextStyle(fontSize: 20),),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(20, 20, 0, 0),
                  child: Container(
                    width: 70.0,
                    height: 70.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10.0),
                      ),
                      color: Color(0xFFE8E8E8),
                    ),
                    child: Center(
                      child: Text("6", textAlign: TextAlign.center, style: TextStyle(fontSize: 20),),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(20, 20, 0, 0),
                  child: Container(
                    width: 70.0,
                    height: 70.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10.0),
                      ),
                      color: Color(0xFFE8E8E8),
                    ),
                    child: Center(
                      child: Text("7", textAlign: TextAlign.center, style: TextStyle(fontSize: 20),),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(20, 20, 0, 0),
                  child: Container(
                    width: 70.0,
                    height: 70.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10.0),
                      ),
                      color: Color(0xFFE8E8E8),
                    ),
                    child: Center(
                      child: Text("8", textAlign: TextAlign.center, style: TextStyle(fontSize: 20),),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(35, 20, 0, 0),
                  child: Container(
                    width: 70.0,
                    height: 70.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10.0),
                      ),
                      color: Color(0xFFE8E8E8),
                    ),
                    child: Center(
                      child: Text("9", textAlign: TextAlign.center, style: TextStyle(fontSize: 20),),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(20, 20, 0, 0),
                  child: Container(
                    width: 70.0,
                    height: 70.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10.0),
                      ),
                      color: Color(0xFFE8E8E8),
                    ),
                    child: Center(
                      child: Text("10", textAlign: TextAlign.center, style: TextStyle(fontSize: 20),),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(20, 20, 0, 0),
                  child: Container(
                    width: 70.0,
                    height: 70.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10.0),
                      ),
                      color: Color(0xFFE8E8E8),
                    ),
                    child: Center(
                      child: Text("11", textAlign: TextAlign.center, style: TextStyle(fontSize: 20),),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(20, 20, 0, 0),
                  child: Container(
                    width: 70.0,
                    height: 70.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10.0),
                      ),
                      color: Color(0xFFE8E8E8),
                    ),
                    child: Center(
                      child: Text("12", textAlign: TextAlign.center, style: TextStyle(fontSize: 20),),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(35, 20, 0, 0),
                  child: Container(
                    width: 70.0,
                    height: 70.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10.0),
                      ),
                      color: Color(0xFFE8E8E8),
                    ),
                    child: Center(
                      child: Text("13", textAlign: TextAlign.center, style: TextStyle(fontSize: 20),),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(20, 20, 0, 0),
                  child: Container(
                    width: 70.0,
                    height: 70.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10.0),
                      ),
                      color: Color(0xFFE8E8E8),
                    ),
                    child: Center(
                      child: Text("14", textAlign: TextAlign.center, style: TextStyle(fontSize: 20),),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(20, 20, 0, 0),
                  child: Container(
                    width: 70.0,
                    height: 70.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10.0),
                      ),
                      color: Color(0xFFE8E8E8),
                    ),
                    child: Center(
                      child: Text("15", textAlign: TextAlign.center, style: TextStyle(fontSize: 20),),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(20, 20, 0, 0),
                  child: Container(
                    width: 70.0,
                    height: 70.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10.0),
                      ),
                      color: Color(0xFFE8E8E8),
                    ),
                    child: Center(
                      child: Text("16", textAlign: TextAlign.center, style: TextStyle(fontSize: 20),),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(35, 20, 0, 0),
                  child: Container(
                    width: 70.0,
                    height: 70.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10.0),
                      ),
                      color: Color(0xFFE8E8E8),
                    ),
                    child: Center(
                      child: Text("17", textAlign: TextAlign.center, style: TextStyle(fontSize: 20),),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(20, 20, 0, 0),
                  child: Container(
                    width: 70.0,
                    height: 70.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10.0),
                      ),
                      color: Color(0xFFE8E8E8),
                    ),
                    child: Center(
                      child: Text("18", textAlign: TextAlign.center, style: TextStyle(fontSize: 20),),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(20, 20, 0, 0),
                  child: Container(
                    width: 70.0,
                    height: 70.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10.0),
                      ),
                      color: Color(0xFFE8E8E8),
                    ),
                    child: Center(
                      child: Text("19", textAlign: TextAlign.center, style: TextStyle(fontSize: 20),),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(20, 20, 0, 0),
                  child: Container(
                    width: 70.0,
                    height: 70.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10.0),
                      ),
                      color: Color(0xFFE8E8E8),
                    ),
                    child: Center(
                      child: Text("20", textAlign: TextAlign.center, style: TextStyle(fontSize: 20),),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(35, 20, 0, 0),
                  child: Container(
                    width: 70.0,
                    height: 70.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10.0),
                      ),
                      color: Color(0xFFE8E8E8),
                    ),
                    child: Center(
                      child: Text("21", textAlign: TextAlign.center, style: TextStyle(fontSize: 20),),
                    ),
                  ),
                ),
              ],
            ),
          ],
        )
    );
  }
}

void goDashboardPatient(BuildContext context,  String? patientemail) {
  Navigator.pushNamed(context, '/tabspatient', arguments: {
    'patientemail': patientemail
  });
}
