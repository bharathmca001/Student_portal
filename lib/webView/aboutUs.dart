import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:auto_size_text/auto_size_text.dart';

import '../responsive/dimansion.dart';

class AboutUSWeb extends StatefulWidget {
  const AboutUSWeb({Key? key}) : super(key: key);

  @override
  State<AboutUSWeb> createState() => _AboutUSWebState();
}

class _AboutUSWebState extends State<AboutUSWeb> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("AboutUs"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              // padding: MediaQuery.of(context).size.width > webScreenSize
              //     ? EdgeInsets.symmetric(
              //         horizontal: MediaQuery.of(context).size.width / 3)
              //     : const EdgeInsets.symmetric(horizontal: 32),
              // width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 30, horizontal: 200),
              child: Column(
                children: [
                  Center(
                    child: AutoSizeText(
                      'DEPARTMENT OF COMPUTER APPLICATIONS',
                      style: GoogleFonts.aBeeZee(
                          fontSize: 30,
                          backgroundColor: Color.fromRGBO(216, 246, 255, 100),
                          color: Color.fromRGBO(0, 91, 194, 1)),
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  SizedBox(
                    height: 400.0,
                    child: Carousel(
                      images: [
                        ExactAssetImage("assets/dcalab.jpg"),
                        ExactAssetImage("assets/bu.jpg"),
                        ExactAssetImage("assets/dcalab.jpg"),
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
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 30, horizontal: 200),
              child: Row(
                children: [
                  Container(
                    child: AutoSizeText(
                      'ABOUT THE \ DEPARTMENT',
                      textAlign: TextAlign.start,
                      style: GoogleFonts.lato(
                          fontSize: 20,
                          backgroundColor: Color.fromRGBO(225, 225, 225, 1)),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 30),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              'Genesis',
                              style: GoogleFonts.lato(fontSize: 24),
                            ),
                            Divider(
                              thickness: 1,
                              height: 0.5,
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 30, vertical: 10),
                              child: SizedBox(
                                width: 700,
                                child: AutoSizeText(
                                  'The Department of Computer Applications was established in the year 2008.  It has its roots from the year 1985 and it is one of the well known departments in the field of computer applications education and research. It plays a vital role in both academic and research contributions to the society.  The Department of Computer Applications offers Master of Computer Applications (M.C.A.), M.Sc. Data Analytics, M.Sc. Cyber Security, M.Phil. Computer Science and Ph.D. Computer Science programmes.  It imparts the state-of-the-art computer knowledge to students so that they are ready to solve the real-world challenges.',
                                  textAlign: TextAlign.justify,
                                  style: GoogleFonts.lato(fontSize: 20),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 30,
                            )
                          ],
                        ),
                        Row(
                          children: [
                            SizedBox(
                              height: 30,
                            ),
                            Text(
                              'Salient Features',
                              style: GoogleFonts.lato(fontSize: 24),
                            ),
                            Divider(
                              thickness: 1,
                              height: 1,
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 30, vertical: 10),
                              child: SizedBox(
                                width: 700,
                                child: AutoSizeText(
                                  'The Department of Computer Applications emphasizes a shift from mass teaching to personalized instruction, single learning to multiple learning, rigid daily program to flexible schedules, training in formal skills and knowledge, isolated content to interrelated, memorized answers to case study-based problem solving.',
                                  textAlign: TextAlign.justify,
                                  style: GoogleFonts.lato(fontSize: 20),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
