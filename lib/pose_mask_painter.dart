//import 'dart:ui' as ui;

import 'dart:math';

import 'package:flutter/widgets.dart';
import 'package:body_detection/models/pose.dart';
import 'package:body_detection/models/pose_landmark.dart';
import 'package:body_detection/models/pose_landmark_type.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'dart:math' as math;
import 'package:flutter_tts/flutter_tts.dart';
import 'package:text_to_speech/text_to_speech.dart';
import 'package:vector_math/vector_math.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';

//import 'package:firebase_signin/screens/result.dart';
// for neck exercise
bool tiltHead = false;
bool ntiltHead = false;
bool clockPosition = false;
bool downPosition = false;
bool upPosition = true;
var reps = 0;
var neckreps = 0;
var maxRadius = 0;

class PoseMaskPainter extends CustomPainter {
  final FlutterTts flutterTts = FlutterTts();
  TextToSpeech tts = TextToSpeech();

  PoseMaskPainter({
    required this.pose,
    // required this.mask,
    required this.imageSize,
    required this.videoName,
  }) {
    flutterTts.setLanguage('en');
    flutterTts.setSpeechRate(0.4);
  }
  final String videoName;
  final Pose? pose;
  //final ui.Image? mask;
  final Size imageSize;
  final pointPaint = Paint()..color = const Color.fromRGBO(255, 255, 255, 0.8);
  final targetPaint0 = Paint()..color = const Color.fromARGB(204, 218, 18, 18);
  final targetPaint1 = Paint()..color = Color.fromARGB(204, 214, 211, 10);
  final targetPaint2 = Paint()..color = Color.fromARGB(204, 11, 110, 224);
  final leftPointPaint = Paint()..color = const Color.fromRGBO(223, 157, 80, 1);
  final rightPointPaint = Paint()
    ..color = const Color.fromRGBO(100, 208, 218, 1);
  final linePaint = Paint()
    ..color = const Color.fromRGBO(255, 255, 255, 0.9)
    ..strokeWidth = 3;
  //final maskPaint = Paint()
  //..colorFilter = const ColorFilter.mode(
  //Color.fromRGBO(0, 0, 255, 0.5), BlendMode.srcOut);

  @override
  void paint(Canvas canvas, Size size) {
    //_paintMask(canvas, size);
    _paintPose(canvas, size);
  }

  void _paintPose(Canvas canvas, Size size) {
    if (pose == null) return;

    final double hRatio =
    imageSize.width == 0 ? 1 : size.width / imageSize.width;
    final double vRatio =
    imageSize.height == 0 ? 1 : size.height / imageSize.height;

    offsetForPart(PoseLandmark part) =>
        Offset(part.position.x * hRatio, part.position.y * vRatio);
    var myList = [];
    var myRadius = [];
    var myShoulderList = [];
    var myNoseList = [];
    var myLeftShoulderList = [];
    var myLeftHipList = [];
    var myShoulderLeftList = [];
    // Landmark connections
    final landmarksByType = {for (final it in pose!.landmarks) it.type: it};
    for (final connection in connections) {
      final point1 = offsetForPart(landmarksByType[connection[0]]!);
      //print(point1);
      final point2 = offsetForPart(landmarksByType[connection[1]]!);
      canvas.drawLine(point1, point2, linePaint);
    }

    // calculate angles from three points
    final angleLandmarksByType = {
      for (final it in pose!.landmarks) it.type: it
    };

//----------Exercise type based on user response----

    for (final angle in angles) {
      final leftShoulder = offsetForPart(angleLandmarksByType[angle[0]]!);
      final leftElbow = offsetForPart(angleLandmarksByType[angle[1]]!);
      final leftWrist = offsetForPart(angleLandmarksByType[angle[2]]!);
      var hipAngles =
          (atan2((leftWrist.dy - leftElbow.dy), (leftWrist.dx - leftElbow.dx)) -
              atan2((leftShoulder.dy - leftElbow.dy),
                  (leftShoulder.dx - leftElbow.dx)))
              .abs() *
              (180 / pi);
      if (hipAngles > 180) {
        hipAngles = 360 - hipAngles;
      }

      TextSpan span = TextSpan(
        text: hipAngles.toStringAsFixed(2),
        style: const TextStyle(
          color: Color.fromARGB(255, 255, 0, 43),
          fontSize: 18,
          //shadows: [
          // ui.Shadow(
          //color: Color.fromRGBO(255, 255, 255, 1),
          // offset: Offset(1, 1),
          // blurRadius: 1,
          // ),
          // ],
        ),
      );
      TextPainter tp = TextPainter(text: span, textAlign: TextAlign.left);
      tp.textDirection = TextDirection.ltr;
      tp.layout();
      tp.paint(canvas, leftElbow);
      myList.add(hipAngles);
      // print(hipAngles.toString());

    }

    for (final target in targets) {
      final leftElbow = offsetForPart(angleLandmarksByType[target[0]]!);
      final leftShoulder = offsetForPart(angleLandmarksByType[target[1]]!);
      final leftWrist = offsetForPart(angleLandmarksByType[target[2]]!);
      final nose = offsetForPart(angleLandmarksByType[target[3]]!);
      final rightShoulder = offsetForPart(angleLandmarksByType[target[4]]!);
      final rightElbow = offsetForPart(angleLandmarksByType[target[5]]!);
      final leftKnee = offsetForPart(angleLandmarksByType[target[6]]!);
      final leftHip = offsetForPart(angleLandmarksByType[target[7]]!);
      final newPoint = Offset(leftElbow.dx,
          leftShoulder.dy); //----left elbow of x and left shoulder of y
      final nosePoint = Offset(
          leftShoulder.dx, nose.dy); //-----left shoulder of x and nose of y
      final newPoint2 = Offset(rightElbow.dx,
          rightShoulder.dy); //-----right elbow of x and right shouder of y
      final newPoint3 =
      Offset(leftKnee.dx, leftHip.dy); //--- left knww of x and lefthip of y

//-------------shoulderxx is angles between left shoulder-left elbow line and left shoulder-new point line
      var shoulderAngles =
          (atan2((newPoint.dy - leftElbow.dy), (newPoint.dx - leftElbow.dx)) -
              atan2((leftShoulder.dy - leftElbow.dy),
                  (leftShoulder.dx - leftElbow.dx)))
              .abs() *
              (180 / pi);
      if (shoulderAngles > 180) {
        shoulderAngles = 360 - shoulderAngles;
      }
      var shoulderxx = 90 - shoulderAngles;
      if (leftElbow.dx > leftShoulder.dx) {
        shoulderxx = 90 + shoulderAngles;
      }

//---------calculate angles between right shoulder and hips
      var shoulderAnglesR = (atan2((newPoint2.dy - rightElbow.dy),
          (newPoint2.dx - rightElbow.dx)) -
          atan2((rightShoulder.dy - rightElbow.dy),
              (rightShoulder.dx - rightElbow.dx)))
          .abs() *
          (180 / pi);
      if (shoulderAnglesR > 180) {
        shoulderAnglesR = 360 - shoulderAnglesR;
      }
      var shoulderxR = 90 - shoulderAnglesR;
      if (rightElbow.dx > rightShoulder.dx) {
        shoulderxR = 90 + shoulderAnglesR;
      }

//-------noseAngle is a angle between nose-nosepoint line and left shoulder-nosepoint line

      var noseAngles = (atan2(
          (nosePoint.dy - nose.dy), (nosePoint.dx - nose.dx)) -
          atan2(
              (leftShoulder.dy - nose.dy), (leftShoulder.dx - nose.dx)))
          .abs() *
          (180 / pi);
      if (noseAngles > 180) {
        noseAngles = 360 - noseAngles;
      }
//----------------calculate------ hip angles to knee---
      var hipAnglesL = (atan2((newPoint3.dy - leftKnee.dy),
          (newPoint3.dx - leftKnee.dx)) -
          atan2((leftHip.dy - leftKnee.dy), (leftHip.dx - leftKnee.dx)))
          .abs() *
          (180 / pi);
      if (hipAnglesL > 180) {
        hipAnglesL = 360 - hipAnglesL;
      }
      hipAnglesL = 90 - hipAnglesL;

      TextSpan span = TextSpan(
        text: noseAngles.toStringAsFixed(2),

        //text: noseAngles.toStringAsFixed(2),
        style: const TextStyle(
          color: Color.fromARGB(255, 255, 0, 43),
          fontSize: 18,
          //shadows: [
          // ui.Shadow(
          //color: Color.fromRGBO(255, 255, 255, 1),
          // offset: Offset(1, 1),
          // blurRadius: 1,
          // ),
          // ],
        ),
      );
      TextPainter tp = TextPainter(text: span, textAlign: TextAlign.left);
      tp.textDirection = TextDirection.ltr;
      tp.layout();
      //tp.paint(canvas, leftWrist);
      tp.paint(canvas, leftShoulder);
      //tp.paint(canvas, nose);
      myShoulderList.add(shoulderxx);
      myShoulderLeftList.add(shoulderxx);
      myNoseList.add(noseAngles);
      myLeftShoulderList.add(shoulderxx);
      myLeftHipList.add(hipAnglesL);

      // double radius = math.sqrt(math.pow(leftShoulder.dx - leftWrist.dx, 2) +
      //  math.pow(leftShoulder.dy - leftWrist.dy, 2));
      //var maxRadius = max(radius, radius);
      //print(radius);

      // var increAngle = radians(10);
      //var targetx = (maxRadius * cos(increAngle));
      // var targety = (maxRadius * sin(increAngle));

      // var target0 = Offset(targetx, targety);
      // canvas.drawCircle(target0, 10, targetPaint0);
      // canvas.drawLine(leftShoulder, target0, linePaint);
      // myRadius.add(maxRadius);

      // --------------angle guided shoulder based exercise----landscape---

      //var arcCenter = Offset(leftShoulder.dx, leftShoulder.dy);
      var arcRect = Rect.fromCircle(center: leftShoulder, radius: 90);
      // var arcCenter1 = Offset(rightShoulder.dx, rightShoulder.dy);
      var arcRect1 = Rect.fromCircle(center: rightShoulder, radius: 90);
      var arcRect2 = Rect.fromCircle(center: leftHip, radius: 90);
      var arcRect3 = Rect.fromCircle(center: nose, radius: 60);
      // var startAngle = radians(220);
      // var sweepAngle = radians(20);

      switch (videoName) {
        case 'neck_right.mp4':
          canvas.drawArc(
              arcRect, radians(220), radians(20), true, targetPaint2);
          break;
        case 'seated_thoracic.mp4':
          canvas.drawArc(
              arcRect, radians(310), radians(30), true, targetPaint2);
          canvas.drawArc(
              arcRect1, radians(20), radians(30), true, targetPaint2);
          break;
        case 'hip.mp4':
          canvas.drawArc(
              arcRect2, radians(110), radians(30), true, targetPaint2);
          break;
        case 'middle_scalene.mp4':
          canvas.drawArc(
              arcRect, radians(320), radians(30), true, targetPaint2);
          canvas.drawArc(
              arcRect3, radians(290), radians(30), true, targetPaint2);
          break;
      // case 'seatedTrunk.mp4':
      //canvas.drawArc(
      //   arcRect3, radians(110), radians(30), true, targetPaint2);
      //   break;
      }

      //canvas.drawArc(arcRect, startAngle, sweepAngle, true, targetPaint2);

      //----------angle end shoulder--------------
    }

    for (final part in pose!.landmarks) {
      // Landmark points

      canvas.drawCircle(offsetForPart(part), 5, pointPaint);
      if (part.type.isLeftSide) {
        canvas.drawCircle(offsetForPart(part), 3, leftPointPaint);
      } else if (part.type.isRightSide) {
        canvas.drawCircle(offsetForPart(part), 3, rightPointPaint);
      }

      // Landmark labels
      //TextSpan span = TextSpan(
      // text: part.type.toString().substring(16),
      // style: const TextStyle(
      // color: Color.fromRGBO(0, 128, 255, 1),
      // fontSize: 10,
      //shadows: [
      // ui.Shadow(
      //color: Color.fromRGBO(255, 255, 255, 1),
      // offset: Offset(1, 1),
      // blurRadius: 1,
      // ),
      // ],
      // ),
      //);
      //TextPainter tp = TextPainter(text: span, textAlign: TextAlign.left);
      //tp.textDirection = TextDirection.ltr;
      //tp.layout();
      // tp.paint(canvas, offsetForPart(part));
    }
    //inDownPosition(myList);
    // inUpPosition(myList);

    //print(reps);
    //print(downPosition);
    //print(upPosition);

    switch (videoName) {
      case 'seated_thoracic.mp4':
        inLeftRangeCardio(myShoulderList);
        inRightRangeCardio(myLeftShoulderList);
        outRange(myShoulderList);
        break;

      case 'middle_scalene.mp4':
        inLeftRangeScalene(myLeftShoulderList);
        outRangeScalene(myLeftShoulderList);
        noseRangeScalene(myNoseList);
        break;

      case 'neck_right.mp4':
        inRange(myShoulderList);
        noseRange(myNoseList);
        outRange(myShoulderList);

        break;

      case 'hip.mp4':
        inLeftRangeHip(myLeftHipList);
        inRightRangeHip(myLeftHipList);
        outRangeHip(myLeftHipList);
        break;
    }
  }

  // void _paintMask(Canvas canvas, Size size) {
  // if (mask == null) return;

  //canvas.drawImageRect(
  //   mask!,
  //   Rect.fromLTWH(0, 0, mask!.width.toDouble(), mask!.height.toDouble()),
  //   Rect.fromLTWH(0, 0, size.width, size.height),
  //   maskPaint);
  // }

  @override
  bool shouldRepaint(PoseMaskPainter oldDelegate) {
    return oldDelegate.pose != pose ||
        //oldDelegate.mask != mask ||
        oldDelegate.imageSize != imageSize;
  }

  List<List<PoseLandmarkType>> get angles => [
    [
      PoseLandmarkType.leftShoulder,
      PoseLandmarkType.leftElbow,
      PoseLandmarkType.leftWrist,
    ],
    [
      PoseLandmarkType.rightHip,
      PoseLandmarkType.rightKnee,
      PoseLandmarkType.rightAnkle
    ],
    [
      PoseLandmarkType.rightShoulder,
      PoseLandmarkType.rightElbow,
      PoseLandmarkType.rightWrist,
    ],
    [
      PoseLandmarkType.leftHip,
      PoseLandmarkType.leftKnee,
      PoseLandmarkType.leftAnkle
    ],
  ];

  List<List<PoseLandmarkType>> get targets => [
    [
      PoseLandmarkType.rightElbow,
      PoseLandmarkType.rightShoulder,
      PoseLandmarkType.rightWrist,
      PoseLandmarkType.nose,
      PoseLandmarkType.leftShoulder,
      PoseLandmarkType.leftElbow,
      PoseLandmarkType.rightKnee,
      PoseLandmarkType.rightHip,
    ]
  ];

  List<List<PoseLandmarkType>> get connections => [
    // [PoseLandmarkType.leftEar, PoseLandmarkType.leftEyeOuter],
    // [PoseLandmarkType.leftEyeOuter, PoseLandmarkType.leftEye],
    // [PoseLandmarkType.leftEye, PoseLandmarkType.leftEyeInner],
    //[PoseLandmarkType.leftEyeInner, PoseLandmarkType.nose],
    //[PoseLandmarkType.nose, PoseLandmarkType.rightEyeInner],
    //[PoseLandmarkType.rightEyeInner, PoseLandmarkType.rightEye],
    //[PoseLandmarkType.rightEye, PoseLandmarkType.rightEyeOuter],
    //[PoseLandmarkType.rightEyeOuter, PoseLandmarkType.rightEar],
    //[PoseLandmarkType.mouthLeft, PoseLandmarkType.mouthRight],
    [PoseLandmarkType.leftShoulder, PoseLandmarkType.rightShoulder],
    [PoseLandmarkType.leftShoulder, PoseLandmarkType.leftHip],
    [PoseLandmarkType.rightShoulder, PoseLandmarkType.rightHip],
    [PoseLandmarkType.rightShoulder, PoseLandmarkType.rightElbow],
    [PoseLandmarkType.rightWrist, PoseLandmarkType.rightElbow],
    [PoseLandmarkType.rightWrist, PoseLandmarkType.rightThumb],
    [PoseLandmarkType.rightWrist, PoseLandmarkType.rightIndexFinger],
    [PoseLandmarkType.rightWrist, PoseLandmarkType.rightPinkyFinger],
    [PoseLandmarkType.leftHip, PoseLandmarkType.rightHip],
    [PoseLandmarkType.leftHip, PoseLandmarkType.leftKnee],
    [PoseLandmarkType.rightHip, PoseLandmarkType.rightKnee],
    [PoseLandmarkType.rightKnee, PoseLandmarkType.rightAnkle],
    [PoseLandmarkType.leftKnee, PoseLandmarkType.leftAnkle],
    [PoseLandmarkType.leftElbow, PoseLandmarkType.leftShoulder],
    [PoseLandmarkType.leftWrist, PoseLandmarkType.leftElbow],
    [PoseLandmarkType.leftWrist, PoseLandmarkType.leftThumb],
    [PoseLandmarkType.leftWrist, PoseLandmarkType.leftIndexFinger],
    [PoseLandmarkType.leftWrist, PoseLandmarkType.leftPinkyFinger],
    [PoseLandmarkType.leftAnkle, PoseLandmarkType.leftHeel],
    [PoseLandmarkType.leftAnkle, PoseLandmarkType.leftToe],
    [PoseLandmarkType.rightAnkle, PoseLandmarkType.rightHeel],
    [PoseLandmarkType.rightAnkle, PoseLandmarkType.rightToe],
    [PoseLandmarkType.rightHeel, PoseLandmarkType.rightToe],
    [PoseLandmarkType.leftHeel, PoseLandmarkType.leftToe],
    [PoseLandmarkType.rightIndexFinger, PoseLandmarkType.rightPinkyFinger],
    [PoseLandmarkType.leftIndexFinger, PoseLandmarkType.leftPinkyFinger],
  ];
  void inDownPosition(list) {
    if (list[0] > 70 && list[0] < 100 && upPosition == true) {
      downPosition = true;
      upPosition = false;
      //flutterTts.speak('Up');
    }
  }

  void inUpPosition(list) {
    if (list[0] > 170 && list[0] < 180) {
      if (downPosition == true) {
        reps = reps + 1;
        //flutterTts.speak('Down');
      }
      downPosition = false;
      upPosition = true;
    }
  }

//------------NECK EXERCISE -------------------
  void inRange(list) {
    if (list[0] > 40 && list[0] < 55 && tiltHead == true) {
      //flutterTts.speak('Hold 5 seconds');
      //tts.speak("Hold 5 seconds");
      clockPosition = true;
      ntiltHead = true;
    }
  }

  void outRange(list) {
    if (list[0] < 15) {
      // if (ntiltHead == true) {
      // neckreps = neckreps + 1;
      // }
      //flutterTts.speak('Hold for 5 seconds');
      clockPosition = false;
      tiltHead = false;
      ntiltHead = false;
      FlutterRingtonePlayer.stop();
    }
  }

// check tilthead posture
  void noseRange(list) {
    if (list[0] > 50 && list[0] < 80) {
      tiltHead = true;
    } else {
      tiltHead = false;
      clockPosition = false;
    }
  }

  //-----------NECK EXERCISE END---------------
  //---------cardio----exercise----------
  void inLeftRangeCardio(list) {
    if (list[0] > 140 && list[0] < 170 && tiltHead == true) {
      //flutterTts.speak('Hold 5 seconds');
      //tts.speak("Hold 5 seconds");
      clockPosition = true;
      ntiltHead = true;
    }
  }

  void outRangeCardio(list) {
    if (list[0] < 15) {
      // if (ntiltHead == true) {
      // neckreps = neckreps + 1;
      // }
      //flutterTts.speak('Hold for 5 seconds');
      clockPosition = false;
      tiltHead = false;
      ntiltHead = false;
      FlutterRingtonePlayer.stop();
    }
  }

// check tilthead posture
  void inRightRangeCardio(list) {
    if (list[0] > 140 && list[0] < 180) {
      tiltHead = true;
    } else {
      tiltHead = false;
      clockPosition = false;
    }
  }
//-----------Hip exercise--------------

  void inLeftRangeHip(list) {
    if (list[0] > 20 && list[0] < 90 && tiltHead == true) {
      //flutterTts.speak('Hold 5 seconds');
      //tts.speak("Hold 5 seconds");
      clockPosition = true;
      ntiltHead = true;
    }
  }

  void outRangeHip(list) {
    if (list[0] < 15) {
      // if (ntiltHead == true) {
      // neckreps = neckreps + 1;
      // }
      //flutterTts.speak('Hold for 5 seconds');
      clockPosition = false;
      tiltHead = false;
      ntiltHead = false;
      FlutterRingtonePlayer.stop();
    }
  }

// check tilthead posture
  void inRightRangeHip(list) {
    if (list[0] > 25 && list[0] < 90) {
      tiltHead = true;
    } else {
      tiltHead = false;
      clockPosition = false;
    }
  }

  //--------middle_scalene exercise----------
  void inLeftRangeScalene(list) {
    if (list[0] > 120 && list[0] < 145 && tiltHead == true) {
      //flutterTts.speak('Hold 5 seconds');
      //tts.speak("Hold 5 seconds");
      clockPosition = true;
      ntiltHead = true;
    }
  }

  void outRangeScalene(list) {
    if (list[0] < 15) {
      // if (ntiltHead == true) {
      // neckreps = neckreps + 1;
      // }
      //flutterTts.speak('Hold for 5 seconds');
      clockPosition = false;
      tiltHead = false;
      ntiltHead = false;
      FlutterRingtonePlayer.stop();
    }
  }

  void noseRangeScalene(list) {
    if (list[0] > 30 && list[0] < 45) {
      tiltHead = true;
    } else {
      tiltHead = false;
      clockPosition = false;
    }
  }
}
