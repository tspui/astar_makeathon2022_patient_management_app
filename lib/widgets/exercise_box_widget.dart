import 'package:flutter/material.dart';

import '../model/exercise_list.dart';
import '../screens/instructionpreview.dart';
import '../screens/video_info.dart';

class ExerciseBox extends StatelessWidget {
  const ExerciseBox({Key? key, required this.item}) : super(key: key);
  final Exercise item;

  @override
  Widget build(BuildContext context) {
    final routeArgs = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    final patientemail = routeArgs['patientemail'];
    return Container(
      padding: const EdgeInsets.all(2),
      height: 140,
      child: Card(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            GestureDetector(onTap:(){Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => VideoInfo(item: item)),
            );},

                child: Image.asset("images/" + item.imagePath)),
            Expanded(
                child: Center(
                  child: Container(
                    padding: const EdgeInsets.all(5),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            item.title,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                          Text(item.subtitle),
                        ]),
                  ),
                )),
            GestureDetector(onTap: (){Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => InstrucToPreview(item: item, patientemail: patientemail,)),
            );},child: Container(margin: const EdgeInsets.all(20), child: Text(item.time),)  )
          ],
        ),
      ),
    );
  }
}
