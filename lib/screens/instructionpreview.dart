import 'package:flutter/material.dart';
// import 'package:firebase_signin/screens/signin_screen.dart';
//import 'package:firebase_signin/screens/exercise_screen.dart';
import 'package:body_detection/models/pose.dart';
import 'package:body_detection/body_detection.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:body_detection/models/image_result.dart';

import '../model/exercise_list.dart';
import 'camera_screen.dart';
import 'general_exercise.dart';
// import 'package:firebase_signin/pose_mask_painter.dart';
// import 'package:firebase_signin/screens/camera_screen.dart';
// import 'package:firebase_signin/screens/general_exercise.dart';

class InstrucToPreview extends StatefulWidget {
  var patientemail;

  InstrucToPreview({Key? key, required this.item, required this.patientemail}) : super(key: key);
  final Exercise item;

  //static String videoName(String input1) {
  // return input1;
  //}

  @override
  State<InstrucToPreview> createState() => _InstrucToPreviewState();
}

class _InstrucToPreviewState extends State<InstrucToPreview> {
  //final items = Exercise.getExercises();

  // String videoname = "assets/images/" + item.videoPath;
  int _selectedTabIndex = 0;
  bool _isDetectingPose = true;
  Pose? _detectedPose;
  Image? _cameraImage;
  Size _imageSize = Size.zero;
  late String videoName1;


  @override
  void initState() {
    super.initState();
    videoName1 = widget.item.videoPath;
  }

  //videoName(String videoPath) {}

  Future<void> _startCameraStream() async {
    final request = await Permission.camera.request();
    print(request);
    if (request.isGranted) {
      await BodyDetection.startCameraStream(
        onFrameAvailable: _handleCameraImage,
        onPoseAvailable: (pose) {
          if (!_isDetectingPose) return;
          _handlePose(pose);
        },
        // onMaskAvailable: (mask) {
        //if (!_isDetectingBodyMask) return;
        // _handleBodyMask(mask);
        // },
      );
    }
  }

  Future<void> _stopCameraStream() async {
    await BodyDetection.stopCameraStream();

    setState(() {
      _cameraImage = null;
      _imageSize = Size.zero;
    });
  }

  void  _handleCameraImage(ImageResult result) {
    // Ignore callback if navigated out of the page.
    if (!mounted) return;

    // To avoid a memory leak issue.
    // https://github.com/flutter/flutter/issues/60160
    PaintingBinding.instance.imageCache.clear();
    PaintingBinding.instance.imageCache.clearLiveImages();

    final image = Image.memory(
      result.bytes,
      gaplessPlayback: true,
      fit: BoxFit.contain,
    );

    setState(() {
      _cameraImage = image;
      _imageSize = result.size;
    });
  }

  void _handlePose(Pose? pose) {
    // Ignore if navigated out of the page.
    if (!mounted) return;

    setState(() {
      _detectedPose = pose;
    });
  }

  Future<void> _toggleDetectPose() async {
    if (_isDetectingPose) {
      await BodyDetection.disablePoseDetection();
    } else {
      await BodyDetection.enablePoseDetection();
    }

    setState(() {
      _isDetectingPose = !_isDetectingPose;
      _detectedPose = null;
    });
  }

  //Widget? get _selectedTab => _selectedTabIndex == 0
  //? null
  //: _selectedTabIndex == 1
  //  ? _cameraDetectionView
  //  : null;

  void _onTabEnter(int index) {
    // Camera tab
    if (index == 1) {
      _startCameraStream();

      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => CameraScreen(videoName: videoName1)),
      );
    }
  }

  void _onTabExit(int index) {
    // Camera tab
    if (index == 0) {
      _stopCameraStream();
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => GeneralExercise()),
      );
    }
  }
  //void _backScreen(int index) {
  // back tab
  //if (index == 0) {
  // Navigator.push(
  //  context,
  //  MaterialPageRoute(builder: (context) => const ExerciseScreen()),
  //);
  // }
//  }

  void _onTabSelectTapped(int index) {
    // _onTabExit(_selectedTabIndex);
    //print(_selectedTabIndex.toString());
    //_onTabEnter(index);

    setState(() {
      _selectedTabIndex = index;
    });
    _onTabExit(_selectedTabIndex);
    _onTabEnter(_selectedTabIndex);
    // print(_selectedTabIndex.toString());
  }

  @override
  Widget build(BuildContext context) {
    // final routeArgs = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    // final patientemail = routeArgs['patientemail'];
    //final exercise = ModalRoute.of(context)!.settings.arguments as Exercise;
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            leading: BackButton(onPressed: (){
              Navigator.pushNamed(context, '/tabspatient', arguments: {"patientemail": widget.patientemail});
            },
              color: Colors.black,),
            // title: const Text('Body detection'),
            title: const Text('Instructions',  style: TextStyle(color: Colors.black, fontSize: 23, fontWeight: FontWeight.bold),),
            backgroundColor: Colors.lightGreen,

          ),
          // bottomNavigationBar: BottomNavigationBar(
          //   items: const <BottomNavigationBarItem>[
          //     BottomNavigationBarItem(
          //       icon: Icon(Icons.arrow_back),
          //       label: 'Back',
          //     ),
          //     BottomNavigationBarItem(
          //       icon: Icon(Icons.camera),
          //       label: 'Camera',
          //     ),
          //   ],
          //   currentIndex: _selectedTabIndex,
          //   onTap: _onTabSelectTapped,
          // ),
          body: Column(
            children: [
              Container(
                  margin: const EdgeInsets.only(left: 20, right: 20, bottom: 10, top:10),
                  padding: const EdgeInsets.all(10)
              ),
              Container(
                //color: Colors.amber,
                margin: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
                padding: const EdgeInsets.all(10),
                child: const Text(
                  'Please rotate your device to Landscape Mode',
                  style: TextStyle(fontSize: 22, color: Colors.black),
                  textAlign: TextAlign.justify,
                ),
              ),
              Container(
                //color: Colors.amber,
                margin: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
                padding: const EdgeInsets.all(10),
                child: const Text(
                  'If you want to auto-set the device orientation to landscape as you enter the preview mode, enable "Auto set orientation" in the settings',
                  style: TextStyle(fontSize: 22, color: Colors.black),
                  textAlign: TextAlign.justify,
                ),
              ),
              Container(
                //color: Colors.amber,
                margin: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
                padding: const EdgeInsets.all(10),
                child: const Text(
                  'Rotate to the Left! Click the "Camera icon to start exercise."',
                  style: TextStyle(fontSize: 22, color: Colors.black),
                  textAlign: TextAlign.justify,
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 50, 0, 0),
                child: ElevatedButton(
                  onPressed: () {_onTabEnter(1);},
                  child: Icon(Icons.camera_alt, color: Colors.black),
                  style: ElevatedButton.styleFrom(
                      shape: CircleBorder(),
                      padding: EdgeInsets.all(20),
                      backgroundColor: Colors.lightGreen// <-- Splash color
                  ),
                ),
              )
            ],
          )),
    );
  }
}
