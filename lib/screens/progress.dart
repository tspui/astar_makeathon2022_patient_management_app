import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ProgressPage extends StatelessWidget {
  const ProgressPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final routeArgs = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    final doctoremail = routeArgs["doctoremail"];
    final id = routeArgs["id"];

    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        title: Text("Past Progress",
          style: TextStyle(color: Theme.of(context).colorScheme.secondary),
        ),
        leading: BackButton(onPressed:  () {
          goExercise(context, id, doctoremail);
        }),),
      body:
      ListView(
          children: [Padding(
      padding: const EdgeInsets.fromLTRB(0, 30, 0, 20),
      child: Container(
        width: 800,
        height: 100,
        child: const Padding(
          padding: EdgeInsets.fromLTRB(20, 40, 20, 0),
          child: Text("Average Accuracy Score of Exercise Movements", textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black,
                  fontFamily: "Poppins",
                  fontSize: 25
              )

          ),
        ),

      ),
    ),Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: Container(
              child: Column(
                children: [
                  SfCartesianChart(
                    primaryXAxis: CategoryAxis(),
                    series: <ChartSeries>[
                      LineSeries<ChartData, String>(
                          dataSource: [
                            // Bind data source
                            ChartData('Jan', 85),
                            ChartData('Feb', 78),
                            ChartData('Mar', 95),
                            ChartData('Apr', 86),
                            ChartData('May', 90),
                            ChartData('Jun', 80),
                            ChartData('Jul', 72),
                            ChartData('Aug', 93),
                          ],
                          xValueMapper: (ChartData data, _) => data.x,
                          yValueMapper: (ChartData data, _) => data.y
                      )
                    ]
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 40, 0, 0),
                    child: Text("Videos of Past Stretches", textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.black,
                            fontFamily: "Poppins",
                            fontSize: 25
                        )

                    ),
                  )
                ],
              ),

            ),

    )

          ]),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xff006400),
        onPressed: () {goMessage(context, id, doctoremail);},
        child: const Icon(Icons.message),
      ),
    );
  }
}
class ChartData {
  ChartData(this.x, this.y);
  final String x;
  final double? y;
}
void goExercise(BuildContext context, String? id, String? doctoremail) {
  Navigator.pushNamed(context, '/exercise', arguments: {
    'id': id,
    'doctoremail': doctoremail
  });
}

void goMessage(BuildContext context, String? id, String? doctoremail) {
  Navigator.pushNamed(context, '/message', arguments: {
    'id': id,
    'doctoremail': doctoremail
  });
}