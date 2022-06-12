import 'dart:async';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:badges/badges.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterfirebase/inside%20screens/Event.dart';
import 'package:flutterfirebase/inside%20screens/fees.dart';
import 'package:flutterfirebase/inside%20screens/shedule.dart';
import 'package:flutterfirebase/screens/drawer.dart';
import 'package:flutterfirebase/webView/profileWeb.dart';
import 'package:get/get.dart';
import 'package:marquee/marquee.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import '../pdfMark/page/pdf_page.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

//notification try

class mobileScreenLayout extends StatefulWidget {
  const mobileScreenLayout({Key? key}) : super(key: key);

  @override
  State<mobileScreenLayout> createState() => _mobileScreenLayoutState();
}

class _mobileScreenLayoutState extends State<mobileScreenLayout> {
  var _connectionStatus;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  bool _isBadgeEvent = false;

  final _oneSignalAppId = 'c16f7d34-3039-42fb-ac32-67808adf7250';
  var uid;
  var userData = {};
  bool isLoading = false;
  Future<void> checkOneSignal() async {
    if (!mounted) return;
    OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);
    OneSignal.shared.setAppId(_oneSignalAppId);
    //
    OneSignal.shared.promptUserForPushNotificationPermission().then((accepted) {
      print("Accepted permission: $accepted");
    });

    OneSignal.shared.setNotificationOpenedHandler((openedResult) {
      String notify = "";
      notify = openedResult.notification.title.toString();
      print(notify);
      if (notify == 'event') {
        Navigator.of(context)
            .pushReplacement(MaterialPageRoute(builder: (context) => event()));
      } else if (notify == 'schedule') {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => studentSchedule(
                  userId: userData['Uid'],
                  Course: userData['Course'],
                  Dept: userData['Dept'],
                  Batch: userData['Batch'],
                )));
      }
    });
  }

  getdata() async {
    setState(() {
      isLoading = true;
    });
    try {
      var userSnap =
          await FirebaseFirestore.instance.collection('student').doc(uid).get();

      // get post lENGTH

      userData = userSnap.data()!;

      setState(() {});
    } catch (e) {
      Get.snackbar('catch', '${e.toString()}');
      print(e.toString());
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();

    initConnectivity();
    uid = FirebaseAuth.instance.currentUser!.uid;
    checkOneSignal();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);

    getdata();
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  // Platform messages are asynchronous, so we initialize in an async method.

  Future<void> initConnectivity() async {
    ConnectivityResult result = ConnectivityResult.none;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      print(e.toString());
    }

    if (!mounted) {
      return Future.value(null);
    }

    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    switch (result) {
      case ConnectivityResult.wifi:
      case ConnectivityResult.mobile:
        // case ConnectivityResult.none:
        setState(() => _connectionStatus = true);
        print(_connectionStatus);

        break;
      default:
        setState(() => _connectionStatus = false);
        print(_connectionStatus);
        break;
    }
  }

  Widget getConnection() {
    if (_connectionStatus == true) {
      return Scaffold(
          backgroundColor: Colors.grey[200],
          drawer: NavigationDrawerWidget(
            userEmail: userData['email'],
            userId: userData['Uid'],
            course: userData['Course'],
          ),
          appBar: AppBar(
            title: Text('Bharathiar University'),
          ),
          body: ListView(
            children: [
              SizedBox(
                height: 200.0,
                child: Carousel(
                  images: [
                    ExactAssetImage("assets/dcalab.jpg"),
                    ExactAssetImage("assets/dcalab.jpg"),
                    ExactAssetImage("assets/bu.jpg")
                  ],
                  dotSize: 4.0,
                  dotSpacing: 15.0,
                  dotColor: Colors.lightGreenAccent,
                  indicatorBgPadding: 5.0,
                  dotBgColor: Colors.grey.withOpacity(0),
                  //borderRadius: false,
                  boxFit: BoxFit.cover,
                  moveIndicatorFromBottom: 180.0,
                  noRadiusForIndicator: true,
                  overlayShadow: false,
                  overlayShadowColors: Colors.white,
                  overlayShadowSize: 0.7,
                  animationDuration: Duration(milliseconds: 600),
                ),
              ),
              SizedBox(
                height: 15,
                child: InkWell(
                  onTap: () {
                    print('some');
                  },
                  child: Marquee(
                    text: 'Department Of Computer Applications',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                    scrollAxis: Axis.horizontal,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    blankSpace: 20.0,
                    velocity: 100.0,
                    pauseAfterRound: Duration(seconds: 1),
                    startPadding: 10.0,
                    accelerationDuration: Duration(seconds: 1),
                    accelerationCurve: Curves.linear,
                    decelerationDuration: Duration(milliseconds: 600),
                    decelerationCurve: Curves.easeOut,
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 20,
                child: DefaultTextStyle(
                  style: const TextStyle(
                    color: Colors.blue,
                    shadows: [
                      Shadow(
                        blurRadius: 3.0,
                        color: Colors.white,
                        offset: Offset(0, 0),
                      ),
                    ],
                  ),
                  child: AnimatedTextKit(
                    repeatForever: true,
                    animatedTexts: [
                      FlickerAnimatedText("திண்ணிய நெஞ்சம் வேண்டும்.",
                          speed: Duration(milliseconds: 2000)),
                    ],
                    onTap: () {
                      print("Tap Event");
                    },
                    totalRepeatCount: 2,
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              _isBadgeEvent
                  ? Badge(
                      padding: EdgeInsets.all(2),
                      elevation: 10, //padding for badge
                      shape: BadgeShape.square,

                      badgeContent: Text(
                        ' new  ',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 14),
                      ),
                      position: BadgePosition.topEnd(),
                      child: Card(
                        color: Colors.blue,
                        shadowColor: Colors.black,
                        child: ListTile(
                          hoverColor: Colors.green,
                          title: Text(
                            'Event',
                            style: TextStyle(color: Colors.white, fontSize: 15),
                          ),
                          trailing: Icon(Icons.keyboard_arrow_right),
                          onTap: () {
                            Get.to(event());
                          },
                        ),
                      ),
                    )
                  : Card(
                      color: Colors.blue,
                      shadowColor: Colors.black,
                      child: ListTile(
                        hoverColor: Colors.green,
                        title: Text(
                          'Event',
                          style: TextStyle(color: Colors.white, fontSize: 15),
                        ),
                        trailing: Icon(Icons.keyboard_arrow_right),
                        onTap: () {
                          Get.to(event());
                        },
                      ),
                    ),
              InkWell(
                child: _isBadgeEvent
                    ? Badge(
                        padding: EdgeInsets.all(2),
                        elevation: 10, //padding for badge

                        badgeContent: Text(
                          ' 2  ',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        position: BadgePosition.topEnd(),
                        child: Card(
                          color: Colors.blue,
                          shadowColor: Colors.black,
                          child: ListTile(
                            hoverColor: Colors.white70,
                            title: Text(
                              'Schedule',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 15),
                            ),
                            trailing: Icon(Icons.keyboard_arrow_right),
                            onTap: () {
                              Get.to(studentSchedule(
                                userId: userData['Uid'],
                                Course: userData['Course'],
                                Dept: userData['Dept'],
                                Batch: userData['Batch'],
                              ));
                            },
                          ),
                        ),
                      )
                    : Card(
                        color: Colors.blue,
                        shadowColor: Colors.black,
                        child: ListTile(
                          hoverColor: Colors.white70,
                          title: Text(
                            'Schedule',
                            style: TextStyle(color: Colors.white, fontSize: 15),
                          ),
                          trailing: Icon(Icons.keyboard_arrow_right),
                          onTap: () {
                            Get.to(studentSchedule(
                              userId: userData['Uid'],
                              Course: userData['Course'],
                              Dept: userData['Dept'],
                              Batch: userData['Batch'],
                            ));
                          },
                        ),
                      ),
              ),
              Card(
                color: Colors.blue,
                shadowColor: Colors.black,
                child: ListTile(
                  hoverColor: Colors.white70,
                  title: Text(
                    'Marks',
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                  trailing: Icon(Icons.keyboard_arrow_right),
                  onTap: () {
                    Get.to(PdfPageMark());
                  },
                ),
              ),
              Card(
                color: Colors.blue,
                shadowColor: Colors.black,
                child: ListTile(
                  hoverColor: Colors.white70,
                  title: Text(
                    'Fee Details',
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                  trailing: Icon(Icons.keyboard_arrow_right),
                  onTap: () {
                    //
                    Get.to(feePay(
                      userdept: userData['Dept'],
                      userCourse: userData['Course'],
                    ));
                  },
                ),
              ),
              Card(
                color: Colors.blue,
                shadowColor: Colors.black,
                child: ListTile(
                    hoverColor: Colors.white70,
                    title: Text(
                      'Profile',
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                    trailing: Icon(Icons.keyboard_arrow_right),
                    onTap: () {
                      Get.to(profilePageWeb(
                          Batch: userData['Batch'],
                          Course: userData['Course'],
                          Dept: userData['Dept'],
                          RegNo: userData['Reg-No'],
                          Email: userData['email'],
                          Name: userData['Name'],
                          Uid: userData['Uid']));
                    }),
              ),
            ],
          ));
    } else if (_connectionStatus == false) {
      return Scaffold(
          body: Column(
        children: [
          Text("no connection"),
        ],
      ));
    } else {
      return Scaffold(
          //body: Text("somthing wrong"),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : getConnection();
  }
}
