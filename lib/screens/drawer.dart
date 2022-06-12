import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterfirebase/inside%20screens/Achievement.dart';
import 'package:flutterfirebase/inside%20screens/Event.dart';
import 'package:flutterfirebase/inside%20screens/FacultyPage.dart';
import 'package:flutterfirebase/inside%20screens/contactUs.dart';
import 'package:flutterfirebase/inside%20screens/placement.dart';
import 'package:flutterfirebase/inside%20screens/webinar.dart';
import 'package:flutterfirebase/screens/library.dart';
import 'package:flutterfirebase/screens/login.dart';
import 'package:flutterfirebase/webView/aboutUs.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class NavigationDrawerWidget extends StatefulWidget {
  final String userId;
  final String userEmail;
  final String course;
  NavigationDrawerWidget(
      {Key? key,
      required this.userEmail,
      required this.userId,
      required this.course})
      : super(key: key);

  @override
  State<NavigationDrawerWidget> createState() => _NavigationDrawerWidgetState();
}

class _NavigationDrawerWidgetState extends State<NavigationDrawerWidget> {
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Material(
        //   color: Color.fromRGBO(50, 75, 205, 1.0),
        color: Colors.blueGrey,
        child: ListView(
          padding: EdgeInsets.zero,

          // Important: Remove any padding from the ListView.

          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
                image: DecorationImage(
                  image: AssetImage("assets/bu.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Text(widget.course),
                  ),
                  Align(
                    alignment: Alignment.bottomRight + Alignment(0, -.4),
                    child: Text(
                      widget.userEmail,
                      style: TextStyle(color: Colors.white60),
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              title: const Text('Notifications'),
              onTap: () {
                _launchInApp('https://b-u.ac.in/notifications');
              },
            ),
            ListTile(
              title: const Text('Circulars'),
              onTap: () {
                _launchInApp('https://b-u.ac.in/notifications');
              },
            ),
            Divider(
              height: 1,
              thickness: 1,
            ),
            ListTile(
              title: const Text('Dept Events'),
              onTap: () {
                Get.to(event());
              },
            ),
            ListTile(
              title: const Text('Dept Webinar'),
              onTap: () {
                Get.to(webinar());
              },
            ),
            ListTile(
              title: const Text('Dept Library'),
              onTap: () {
                // Update the state of the app
                // ...
                Get.to(libraryDept());
                // Then close the drawer
              },
            ),
            ListTile(
              title: const Text('Achievement'),
              onTap: () {
                // Update the state of the app
                // ...
                Get.to(AchievementPage());
                // Then close the drawer
              },
            ),
            ListTile(
              title: const Text('Placement'),
              onTap: () {
                // Update the state of the app
                // ...
                Get.to(placementTrain());
                // Then close the drawer
              },
            ),
            ListTile(
              title: const Text('Dept Faculty'),
              onTap: () {
                // Update the state of the app
                // ...
                Get.to(facultyPage());
                // _launchInApp('https://b-u.ac.in/23/faculty');
                // Then close the drawer
              },
            ),
            Divider(
              height: 1,
              thickness: 1,
            ),
            ListTile(
              title: const Text('Online Payment'),
              onTap: () {
                // Update the state of the app
                // ...
                _launchInBrowser('http://fms.b-u.ac.in:8000/semfees-login/');
                // Then close the drawer
              },
            ),
            ListTile(
              title: const Text('Online Exam Portal'),
              onTap: () {
                // Update the state of the app
                // ...
                _launchInApp(
                    'https://buonlineexam2022.b-u.ac.in/Identity/Account/Login?ReturnUrl=%2F');

                // Then close the drawer
              },
            ),
            ListTile(
              title: const Text('About Us'),
              onTap: () {
                Get.to(contactUs());
              },
            ),
            ListTile(
              title: const Text('Logout'),
              leading: Icon(Icons.account_circle),
              onTap: () {
                signOut();
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => const LoginScreen(),
                  ),
                );

                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  Future signOut() async {
    FirebaseAuth.instance.signOut();
    if (Platform.isAndroid) {
      SystemNavigator.pop();
    } else {
      exit(0);
    }
    dispose();
  }

  @override
  void dispose() {
    // TODO: implement dispose

    super.dispose();
  }
}

Future<void> _launchInBrowser(String url) async {
  if (!await launch(
    url,
    forceSafariVC: true,
    forceWebView: false,
    enableJavaScript: true,
    universalLinksOnly: false,
    enableDomStorage: true,
    headers: <String, String>{'my_header_key': 'my_header_value'},
  )) {
    throw 'Could not launch $url';
  }
}

Future<void> _launchInApp(String url) async {
  if (!await launch(
    url,
    forceSafariVC: true,
    forceWebView: true,
    enableJavaScript: true,
    universalLinksOnly: true,
    enableDomStorage: true,
    headers: <String, String>{'my_header_key': 'my_header_value'},
  )) {
    throw 'Could not launch $url';
  }
}
