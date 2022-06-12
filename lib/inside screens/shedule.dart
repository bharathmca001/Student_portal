import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class studentSchedule extends StatefulWidget {
  final userId;
  final Dept;
  final Course;
  final Batch;
  const studentSchedule(
      {Key? key,
      required this.userId,
      required this.Dept,
      required this.Course,
      required this.Batch})
      : super(key: key);

  @override
  _studentScheduleState createState() => _studentScheduleState();
}

class _studentScheduleState extends State<studentSchedule> {
  Widget Schedule() {
    Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance
        .collection(
            '/Bharathiar University/${widget.Dept}/Course/${widget.Course}/Batch/${widget.Batch}/Schedule')
        .snapshots();

    return StreamBuilder<QuerySnapshot>(
        stream: _usersStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("Loading");
          }
          return ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data =
                  document.data()! as Map<String, dynamic>;

              return Table(
                border: TableBorder.all(color: Colors.black),
                children: [
                  TableRow(children: [
                    AutoSizeText(
                      data['day'],
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                    AutoSizeText(
                      data['10-11'],
                      style: GoogleFonts.lato(),
                      maxFontSize: 20,
                    ),
                    AutoSizeText(
                      data['11-12'],
                      style: GoogleFonts.lato(),
                      maxFontSize: 20,
                    ),
                    AutoSizeText(
                      data['12-1'],
                      style: GoogleFonts.lato(),
                      maxFontSize: 20,
                    ),
                    AutoSizeText(
                      data['2-3'],
                      style: GoogleFonts.lato(),
                      maxFontSize: 20,
                    ),
                    AutoSizeText(
                      data['3-4'],
                      style: GoogleFonts.lato(),
                      maxFontSize: 20,
                    ),
                    AutoSizeText(
                      data['4-5'],
                      style: GoogleFonts.lato(),
                      maxFontSize: 20,
                    ),
                  ]),
                ],
              );
            }).toList(),
          );
        });
  }

  Widget specialSchedule() {
    Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance
        .collection(
            '/Bharathiar University/${widget.Dept}/Course/${widget.Course}/Batch/${widget.Batch}/specialSchedule')
        .snapshots();

    return StreamBuilder<QuerySnapshot>(
        stream: _usersStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("Loading");
          }
          return ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data =
                  document.data()! as Map<String, dynamic>;

              return Card(
                  elevation: 10,
                  color: Colors.blue,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                  borderOnForeground: true,
                  child: Column(
                    children: [
                      ListTile(
                        hoverColor: Colors.white70,
                        title: Text(
                          data['special'],
                          style: TextStyle(
                              color: Colors.white.withOpacity(0.9),
                              fontSize: 15),
                        ),
                      ),
                    ],
                  ));
            }).toList(),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Schedule"),
          bottom: const TabBar(tabs: [
            Tab(icon: Text('Time Table')),
            Tab(icon: Text('Special')),
          ]),
        ),
        body: TabBarView(
          children: [
            Schedule(),
            specialSchedule(),
          ],
        ),
      ),
    );
  }
}
