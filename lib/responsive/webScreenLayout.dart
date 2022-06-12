import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterfirebase/inside%20screens/Achievement.dart';
import 'package:flutterfirebase/inside%20screens/Attendance.dart';
import 'package:flutterfirebase/inside%20screens/Event.dart';
import 'package:flutterfirebase/inside%20screens/placement.dart';
import 'package:flutterfirebase/inside%20screens/shedule.dart';
import 'package:flutterfirebase/inside%20screens/webinar.dart';
import 'package:flutterfirebase/pdfMark/page/pdf_page.dart';
import 'package:flutterfirebase/screens/library.dart';
import 'package:flutterfirebase/webView/aboutUs.dart';
import 'package:flutterfirebase/webView/profileWeb.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../inside screens/FacultyPage.dart';
import '../webView/browser.dart';

class webScreenLayout extends StatefulWidget {
  const webScreenLayout({Key? key}) : super(key: key);

  @override
  State<webScreenLayout> createState() => _webScreenLayoutState();
}

class _webScreenLayoutState extends State<webScreenLayout> {
  final List _isHovering = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false
  ];
  var uid;
  var userData = {};
  bool isLoading = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    uid = FirebaseAuth.instance.currentUser!.uid;
    getdata();
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
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Scaffold(
            // appBar: AppBar(
            //   title: Text('DCA '),
            // ),

            body: SingleChildScrollView(
            child: SizedBox(
              height: 750,
              child: Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                  image: AssetImage("assets/bu.jpg"),
                  fit: BoxFit.cover,
                )),
                child: Column(
                  children: [
                    Container(
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.5),
                            // gradient: LinearGradient(
                            //     begin: Alignment.centerLeft,
                            //     end: Alignment.centerRight,
                            //     colors: [
                            //       Color.fromRGBO(195, 20, 50, 1.0),
                            //       Color.fromRGBO(36, 11, 54, 1.0)
                            //     ]),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              //ImageIcon(image),
                              Image.asset(
                                'bu_logo_front.png',
                                width: 400,
                                height: 120,
                              ),

                              Row(
                                children: [
                                  Text(
                                    'DEPARTMENT OF COMPUTER APPLICATION',
                                    style: GoogleFonts.lato(
                                        fontSize: 25, color: Colors.white),
                                    // style: TextStyle(
                                    //     fontWeight: FontWeight.bold,
                                    //     color: Colors.cyanAccent,
                                    //     fontSize: 20),
                                  ),
                                  SizedBox(
                                    width: 30,
                                  ),
                                  InkWell(
                                    child: CircleAvatar(
                                      backgroundImage:
                                          AssetImage('assets/dcalab.jpg'),
                                      radius: 25,
                                      child: PopupMenuButton(
                                          icon: CircleAvatar(
                                            radius: 0,
                                          ),
                                          itemBuilder: (context) => [
                                                PopupMenuItem(
                                                  child: ListTile(
                                                    title: const Text('Logout'),
                                                    onTap: () {},
                                                  ),
                                                )
                                              ]),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 30,
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),

                    //nav end
                    //next
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                PopupMenuButton(
                                    child: Container(
                                      width: 100,
                                      height: 28,
                                      decoration: BoxDecoration(
                                        color: Color.fromRGBO(255, 241, 148, 1),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(9)),
                                      ),
                                      child: Center(
                                        child: Text(
                                          'ACADEMIC',
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.lato(
                                              textStyle:
                                                  TextStyle(fontSize: 15)),
                                        ),
                                      ),
                                    ),

                                    //icon: Text('one two'),
                                    itemBuilder: (context) => [
                                          PopupMenuItem(
                                            child: ListTile(
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10)),
                                              ),
                                              hoverColor: Colors.cyanAccent,
                                              title: const Text('SYLLABUS',
                                                  style:
                                                      TextStyle(fontSize: 15)),
                                              onTap: () {
                                                String url1;
                                                FirebaseFirestore.instance
                                                    .collection(
                                                        '/Bharathiar University/${userData['Dept']}/Course/${userData['Course']}/Batch/${userData['Batch']}/Syllabus/')
                                                    .get()
                                                    .then((QuerySnapshot
                                                        querySnapshot) {
                                                  querySnapshot.docs
                                                      .forEach((doc) {
                                                    Browser().launchInBrowser(
                                                        doc["url"]);
                                                  });
                                                });
                                              },
                                            ),
                                          ),
                                          PopupMenuItem(
                                            child: ListTile(
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10)),
                                              ),
                                              hoverColor: Colors.cyanAccent,
                                              title: const Text('FACULTY',
                                                  style:
                                                      TextStyle(fontSize: 15)),
                                              onTap: () {
                                                Get.to(facultyPage());
                                              },
                                            ),
                                          ),
                                          PopupMenuItem(
                                            child: ListTile(
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10)),
                                              ),
                                              hoverColor: Colors.cyanAccent,
                                              title: const Text(
                                                  'SEMINARS AND CONFERENCE',
                                                  style:
                                                      TextStyle(fontSize: 15)),
                                              onTap: () {
                                                Get.to(webinar());
                                              },
                                            ),
                                          ),
                                          PopupMenuItem(
                                            child: ListTile(
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10)),
                                              ),
                                              hoverColor: Colors.cyanAccent,
                                              title: const Text('LIBRARY',
                                                  style:
                                                      TextStyle(fontSize: 15)),
                                              onTap: () {
                                                Get.to(libraryDept());
                                              },
                                            ),
                                          ),
                                        ]),
                                SizedBox(
                                  width: 30,
                                ),
                                PopupMenuButton(
                                    child: Container(
                                      width: 120,
                                      height: 28,
                                      decoration: BoxDecoration(
                                        color: Color.fromRGBO(255, 241, 148, 1),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(9)),
                                      ),
                                      child: Center(
                                        child: Text(
                                          'NOTIFICATION',
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.lato(
                                              textStyle:
                                                  TextStyle(fontSize: 15)),
                                        ),
                                      ),
                                    ),

                                    //icon: Text('one two'),
                                    itemBuilder: (context) => [
                                          PopupMenuItem(
                                            child: ListTile(
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10)),
                                              ),
                                              hoverColor: Colors.cyanAccent,
                                              title: const Text('NOTIFICATION',
                                                  style:
                                                      TextStyle(fontSize: 15)),
                                              onTap: () {
                                                Get.to(event());
                                              },
                                            ),
                                          ),
                                          PopupMenuItem(
                                            child: ListTile(
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10)),
                                              ),
                                              hoverColor: Colors.cyanAccent,
                                              title: const Text('SCHEDULE',
                                                  style:
                                                      TextStyle(fontSize: 15)),
                                              onTap: () {
                                                Get.to(studentSchedule(
                                                    userId: userData['Uid'],
                                                    Dept: userData['Dept'],
                                                    Course: userData['Course'],
                                                    Batch: userData['Batch']));
                                              },
                                            ),
                                          ),
                                          PopupMenuItem(
                                            child: ListTile(
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10)),
                                              ),
                                              hoverColor: Colors.cyanAccent,
                                              title: const Text(
                                                  'BU-NOTIFICATION AND \ CIRCULARS',
                                                  style:
                                                      TextStyle(fontSize: 15)),
                                              onTap: () {
                                                Browser().launchInBrowser(
                                                    'https://b-u.ac.in/notifications');
                                              },
                                            ),
                                          ),
                                        ]),
                                SizedBox(
                                  width: 30,
                                ),
                                PopupMenuButton(
                                    child: Container(
                                      width: 120,
                                      height: 28,
                                      decoration: BoxDecoration(
                                        color: Color.fromRGBO(255, 241, 148, 1),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(9)),
                                      ),
                                      child: Center(
                                        child: Text(
                                          'DEPARTMENT',
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.lato(
                                              textStyle:
                                                  TextStyle(fontSize: 15)),
                                        ),
                                      ),
                                    ),

                                    //icon: Text('one two'),
                                    itemBuilder: (context) => [
                                          PopupMenuItem(
                                            child: ListTile(
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10)),
                                              ),
                                              hoverColor: Colors.cyanAccent,
                                              title: const Text('WEBINAR',
                                                  style:
                                                      TextStyle(fontSize: 15)),
                                              onTap: () {
                                                Get.to(webinar());
                                              },
                                            ),
                                          ),
                                          PopupMenuItem(
                                            child: ListTile(
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10)),
                                              ),
                                              hoverColor: Colors.cyanAccent,
                                              title: const Text('ACHIEVEMENT',
                                                  style:
                                                      TextStyle(fontSize: 15)),
                                              onTap: () {
                                                Get.to(AchievementPage());
                                              },
                                            ),
                                          ),
                                          PopupMenuItem(
                                            child: ListTile(
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10)),
                                              ),
                                              hoverColor: Colors.cyanAccent,
                                              title: const Text('PLACEMENT',
                                                  style:
                                                      TextStyle(fontSize: 15)),
                                              onTap: () {
                                                Get.to(placementTrain());
                                              },
                                            ),
                                          ),
                                        ]),
                              ],
                            ),
                            Row(
                              children: [
                                RaisedButton(
                                  child: new Text('Fee Payment'),
                                  color: Colors.lightGreenAccent,
                                  onPressed: () {
                                    Browser().launchInBrowser(
                                        'http://fms.b-u.ac.in:8000/semfees-login/');
                                  },
                                ),
                                SizedBox(
                                  width: 30,
                                ),
                                RaisedButton(
                                  child: new Text('Exam Portal'),
                                  color: Colors.lightGreenAccent,
                                  onPressed: () {
                                    Browser().launchInBrowser(
                                        'https://buonlineexam2022.b-u.ac.in/Identity/Account/Login?ReturnUrl=%2F');
                                  },
                                ),
                                SizedBox(
                                  width: 30,
                                ),
                                RaisedButton(
                                  child: new Text('About Us'),
                                  color: Colors.lightGreenAccent,
                                  onPressed: () {
                                    Get.to(AboutUSWeb());
                                  },
                                ),
                                SizedBox(
                                  width: 30,
                                ),
                                PopupMenuButton(
                                    child: Container(
                                      width: 80,
                                      height: 28,
                                      decoration: BoxDecoration(
                                        color: Color.fromRGBO(255, 241, 148, 1),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(9)),
                                      ),
                                      child: Center(
                                        child: Text(
                                          'PROFILE',
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.lato(
                                              textStyle:
                                                  TextStyle(fontSize: 15)),
                                        ),
                                      ),
                                    ),

                                    //icon: Text('one two'),
                                    itemBuilder: (context) => [
                                          PopupMenuItem(
                                            child: ListTile(
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10)),
                                              ),
                                              hoverColor: Colors.cyanAccent,
                                              title: const Text('Mark',
                                                  style:
                                                      TextStyle(fontSize: 15)),
                                              onTap: () {
                                                Get.to(PdfPageMark());
                                              },
                                            ),
                                          ),
                                          PopupMenuItem(
                                            child: ListTile(
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10)),
                                              ),
                                              hoverColor: Colors.cyanAccent,
                                              title: const Text('Attendance',
                                                  style:
                                                      TextStyle(fontSize: 15)),
                                              onTap: () {
                                                Get.to(AttendancePage(
                                                    Batch: userData['Batch'],
                                                    Course: userData['Course'],
                                                    Dept: userData['Dept'],
                                                    RegNo: userData['Reg-No'],
                                                    Email: userData['email'],
                                                    Name: userData['Name'],
                                                    Uid: userData['Uid']));
                                              },
                                            ),
                                          ),
                                          PopupMenuItem(
                                            child: ListTile(
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10)),
                                              ),
                                              hoverColor: Colors.cyanAccent,
                                              title: const Text('Profile',
                                                  style:
                                                      TextStyle(fontSize: 15)),
                                              onTap: () {
                                                Get.to(profilePageWeb(
                                                  RegNo: userData['Reg-No'],
                                                  Batch: userData['Batch'],
                                                  Course: userData['Course'],
                                                  Uid: userData['Uid'],
                                                  Dept: userData['Dept'],
                                                  Name: userData['Name'],
                                                  Email: userData['email'],
                                                ));
                                              },
                                            ),
                                          ),
                                        ]),
                              ],
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ));
  }
}
