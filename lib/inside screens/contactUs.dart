import 'package:auto_size_text/auto_size_text.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class contactUs extends StatefulWidget {
  const contactUs({Key? key}) : super(key: key);

  @override
  State<contactUs> createState() => _contactUsState();
}

class _contactUsState extends State<contactUs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About Us'),
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: AutoSizeText(
                    'DEPARTMENT OF COMPUTER APPLICATIONS',
                    maxFontSize: 20,
                    style: GoogleFonts.aBeeZee(
                        backgroundColor: Color.fromRGBO(216, 246, 255, 100),
                        color: Color.fromRGBO(0, 91, 194, 1)),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 250.0,
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
            AutoSizeText(
              'ABOUT THE \ DEPARTMENT',
              maxFontSize: 20,
              textAlign: TextAlign.start,
              style: GoogleFonts.lato(
                  backgroundColor: Color.fromRGBO(225, 225, 225, 1)),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                SizedBox(
                  width: 350,
                  child: AutoSizeText(
                    'The Department of Computer Applications was established in the year 2008.  It has its roots from the year 1985 and it is one of the well known departments in the field of computer applications education and research. It plays a vital role in both academic and research contributions to the society.  The Department of Computer Applications offers Master of Computer Applications (M.C.A.), M.Sc. Data Analytics, M.Sc. Cyber Security, M.Phil. Computer Science and Ph.D. Computer Science programmes.  It imparts the state-of-the-art computer knowledge to students so that they are ready to solve the real-world challenges.',
                    textAlign: TextAlign.justify,
                    maxFontSize: 20,
                    style: GoogleFonts.lato(),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
