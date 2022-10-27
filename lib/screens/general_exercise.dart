import 'package:flutter/material.dart';
// import 'package:firebase_signin/model/days.dart';
// import 'package:firebase_signin/constants.dart';
// import 'package:firebase_signin/reusable_widgets/reusable_widget.dart';
// import 'package:firebase_signin/reusable_widgets/heading_widget.dart';
//import 'package:firebase_signin/preview.dart';
// import 'package:firebase_signin/screens/instruc_to_preview.dart';

import '../model/exercise_list.dart';
import '../widgets/exercise_box_widget.dart';
// import '../widget/exercise_box_widget.dart';

class GeneralExercise extends StatelessWidget {
  final int currentDay = 4;
  GeneralExercise({Key? key}) : super(key: key);
  final items = Exercise.getExercises();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.redAccent,
      height: MediaQuery.of(context).size.height,
      width: double.infinity,
      child: Column(
        children: [
          // _buildDateSection(),
          buildActivitySection(context)],
      ),
    );
  }

  Widget buildActivitySection(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.85,
      decoration: const BoxDecoration(
        // color: CustomColors.kBackgroundColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
      ),
      // Ideally these cards should be the data fetched from API or they have a specific model but for simplicity let's just go like this :)

      child: Column(mainAxisAlignment: MainAxisAlignment.end, children: [
        // const HeadingWidget(
        //   text1: 'ACTIVITY',
        //   text2: 'Show All',
        // ),
        Expanded(
          child: ListView.builder(
            //shrinkWrap: true,
            itemCount: items.length,
            itemBuilder: (context, index) {
              return
                ExerciseBox(item: items[index]);


            },
          ),
        ),
      ]),
    );
  }

  // Container _buildDateSection() {
  //   return Container(
  //     height: 100,
  //     // color: Colors.red,
  //     child: ListView.builder(
  //         itemCount: days.length,
  //         scrollDirection: Axis.horizontal,
  //         itemBuilder: (context, index) {
  //           int dayValue = int.parse(days[index].dayNumber);
  //           return Container(
  //             padding: const EdgeInsets.all(6.0),
  //             margin: const EdgeInsets.symmetric(horizontal: 4.0),
  //             child: Column(
  //               children: [
  //                 Expanded(
  //                   flex: 1,
  //                   child: Container(),
  //                 ),
  //                 // Text(
  //                 //   days[index].dayName,
  //                 //   style: TextStyle(
  //                 //       fontSize: 15,
  //                 //       fontWeight: FontWeight.bold,
  //                 //       color: dayValue == currentDay
  //                 //           ? CustomColors.kPrimaryColor
  //                 //           : currentDay < dayValue
  //                 //           ? CustomColors.kLightColor
  //                 //           : Colors.white),
  //                 // ),
  //                 Expanded(
  //                   flex: 2,
  //                   child: Container(),
  //                 ),
  //                 // CircleAvatar(
  //                 //     backgroundColor: dayValue == currentDay
  //                 //         ? CustomColors.kPrimaryColor
  //                 //         : Colors.transparent,
  //                 //     child: Text(
  //                 //       days[index].dayNumber,
  //                 //       style: TextStyle(
  //                 //           fontWeight: FontWeight.bold,
  //                 //           color: dayValue >= currentDay
  //                 //               ? CustomColors.kLightColor
  //                 //               : Colors.white),
  //                 //     )),
  //                 Expanded(
  //                   flex: 1,
  //                   child: Container(),
  //                 ),
  //               ],
  //             ),
  //           );
  //         }),
  //   );
  // }
}
