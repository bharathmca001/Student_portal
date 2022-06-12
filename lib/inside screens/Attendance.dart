import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../responsive/dimansion.dart';

class AttendancePage extends StatefulWidget {
  final String Uid;
  final String Dept;
  final String Course;
  final String Email;
  final String Batch;
  final String RegNo;
  final String Name;
  const AttendancePage(
      {Key? key,
      required this.Batch,
      required this.Course,
      required this.Dept,
      required this.RegNo,
      required this.Email,
      required this.Name,
      required this.Uid})
      : super(key: key);

  @override
  State<AttendancePage> createState() => _AttendancePageState();
}

bool isLoading = false;

var userData = {};

class _AttendancePageState extends State<AttendancePage> {
  getdata() async {
    setState(() {
      isLoading = true;
    });
    try {
      var userSnap = await FirebaseFirestore.instance
          .collection(
              '/Bharathiar University/DCA/Course/MCA/Batch/Batch-19/Attendance/')
          .doc(widget.RegNo)
          .get();

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
    // TODO: implement initState
    super.initState();
    getdata();
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Scaffold(
            appBar: AppBar(
              title: Text('Profile'),
            ),
            body: SingleChildScrollView(
              child: Container(
                padding: MediaQuery.of(context).size.width > webScreenSize
                    ? EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width / 3)
                    : const EdgeInsets.symmetric(horizontal: 32),
                width: double.infinity,
                child: Column(
                  children: [
                    Container(
                      child: Column(
                        children: [
                          Text(
                            'ATTENDANCE INFORMATION',
                            style: GoogleFonts.alike(fontSize: 20),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 25),
                            child: Row(
                              children: [
                                AutoSizeText.rich(
                                  TextSpan(
                                    text: ' ${userData['SUB1']['NAME']} :',
                                    style: GoogleFonts.lato(fontSize: 20),
                                  ),
                                ),
                                Text(
                                  '${userData['SUB1']['PERCENT']}',
                                  style: GoogleFonts.abel(fontSize: 18),
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 25),
                            child: Row(
                              children: [
                                AutoSizeText.rich(
                                  TextSpan(
                                    text: '${userData['SUB2']['NAME']}:',
                                    style: GoogleFonts.lato(fontSize: 20),
                                  ),
                                ),
                                Text(
                                  '${userData['SUB2']['PERCENT']}',
                                  style: GoogleFonts.abel(fontSize: 18),
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 25),
                            child: Row(
                              children: [
                                AutoSizeText.rich(
                                  TextSpan(
                                    text: '${userData['SUB3']['NAME']}:',
                                    style: GoogleFonts.lato(fontSize: 20),
                                  ),
                                ),
                                Text(
                                  '${userData['SUB3']['PERCENT']}',
                                  style: GoogleFonts.abel(fontSize: 18),
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 25),
                            child: Row(
                              children: [
                                AutoSizeText.rich(
                                  TextSpan(
                                    text: '${userData['SUB4']['NAME']}:',
                                    style: GoogleFonts.lato(fontSize: 20),
                                  ),
                                ),
                                Text(
                                  '${userData['SUB4']['PERCENT']}',
                                  style: GoogleFonts.abel(fontSize: 18),
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 25),
                            child: Row(
                              children: [
                                AutoSizeText.rich(
                                  TextSpan(
                                    text: '${userData['SUB5']['NAME']}:',
                                    style: GoogleFonts.lato(fontSize: 20),
                                  ),
                                ),
                                Text(
                                  '${userData['SUB5']['PERCENT']}',
                                  style: GoogleFonts.abel(fontSize: 18),
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Divider(
                      height: 10,
                      thickness: 1,
                      color: Colors.grey,
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
