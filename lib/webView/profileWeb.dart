import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../responsive/dimansion.dart';

class profilePageWeb extends StatefulWidget {
  final String Uid;
  final String Dept;
  final String Course;
  final String Email;
  final String Batch;
  final String RegNo;
  final String Name;

  const profilePageWeb(
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
  State<profilePageWeb> createState() => _profilePageWebState();
}

bool isLoading = false;
var userData = {};

class _profilePageWebState extends State<profilePageWeb> {
  getdata() async {
    setState(() {
      isLoading = true;
    });
    try {
      print(
          '/Bharathiar University/${widget.Dept}/Course/${widget.Course}/Batch/${widget.Batch}/StudentPersonalDetails/');
      var userSnap = await FirebaseFirestore.instance
          .collection(
              '/Bharathiar University/${widget.Dept}/Course/${widget.Course}/Batch/${widget.Batch}/StudentPersonalDetails/')
          .doc(widget.RegNo)
          .get();

      // get post lENGTH
      print(userSnap);
      userData = userSnap.data()!;
      print(userData);
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
                    : const EdgeInsets.symmetric(),
                width: double.infinity,
                child: Column(
                  children: [
                    Container(
                      child: Column(
                        children: [
                          Text(
                            'PROFILE DETAILS',
                            style: GoogleFonts.alike(fontSize: 20),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            child: Row(
                              children: [
                                CircleAvatar(
                                  radius: 50,
                                  child: Icon(
                                    Icons.account_circle,
                                    size: 100,
                                  ),
                                  backgroundColor: Colors.white,

                                  // backgroundImage: NetworkImage(
                                  //     'https://firebasestorage.googleapis.com/v0/b/flutterfirebase-39775.appspot.com/o/profile%2Fprofilepic.jpeg?alt=media&token=479aeb37-9256-4c8b-a622-7477c9627b73'),
                                ),
                                Row(
                                  children: [
                                    Container(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 30),
                                      child: Column(
                                        children: [
                                          Text(
                                            widget.Name,
                                            textAlign: TextAlign.left,
                                            style:
                                                GoogleFonts.lato(fontSize: 24),
                                          ),
                                          Text(
                                            widget.Dept,
                                            textAlign: TextAlign.left,
                                            style:
                                                GoogleFonts.lato(fontSize: 20),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                )
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
                                    text: 'Email Id  :',
                                    style: GoogleFonts.lato(fontSize: 20),
                                  ),
                                ),
                                Text(
                                  '${widget.Email}',
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
                                    text: 'Course  :',
                                    style: GoogleFonts.lato(fontSize: 20),
                                  ),
                                ),
                                Text(
                                  '${widget.Course}',
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
                                    text: 'Batch  :',
                                    style: GoogleFonts.lato(fontSize: 20),
                                  ),
                                ),
                                Text(
                                  '${widget.Batch}',
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
                                    text: 'Register Number  :',
                                    style: GoogleFonts.lato(fontSize: 20),
                                  ),
                                ),
                                Text(
                                  '${widget.RegNo}',
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
                                    text: 'Email Id  :',
                                    style: GoogleFonts.lato(fontSize: 20),
                                  ),
                                ),
                                Text(
                                  'bharath18pbk@gmail.com',
                                  style: GoogleFonts.abel(fontSize: 18),
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                              ],
                            ),
                          ),
                          Divider(
                            height: 10,
                            thickness: 1,
                            color: Colors.grey,
                          ),
                          Text(
                            'PERSONAL INFORMATION',
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
                                    text: 'DOB  :',
                                    style: GoogleFonts.lato(fontSize: 16),
                                  ),
                                  maxFontSize: 20,
                                ),
                                Text(
                                  '${userData['DOB']}',
                                  style: GoogleFonts.abel(),
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
                                    text: 'PARENT NAME  :',
                                    style: GoogleFonts.lato(fontSize: 16),
                                  ),
                                  maxFontSize: 20,
                                ),
                                Text(
                                  '${userData['FatherName']}-${userData['MotherName']}',
                                  style: GoogleFonts.abel(),
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
                                    text: 'ADDRESS       :',
                                    style: GoogleFonts.lato(fontSize: 16),
                                  ),
                                  maxFontSize: 20,
                                ),
                                Text(
                                  '${userData['Address']['line1']}  ${userData['Address']['line2']}',
                                  style: GoogleFonts.abel(),
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                              ],
                            ),
                          ),
                          Text(
                              '${userData['Address']['line3']}  ${userData['Address']['line4']}-${userData['Address']['pin']}'),
                          SizedBox(
                            height: 30,
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 25),
                            child: Row(
                              children: [
                                AutoSizeText.rich(
                                  TextSpan(
                                    text: 'MOBILE NO  :',
                                    style: GoogleFonts.lato(fontSize: 16),
                                  ),
                                  maxFontSize: 20,
                                ),
                                Text(
                                  '${userData['MobileNo']}',
                                  style: GoogleFonts.abel(),
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
