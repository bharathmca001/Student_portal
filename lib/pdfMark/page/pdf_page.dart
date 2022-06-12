import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutterfirebase/model/user.dart' as model;

import 'package:flutterfirebase/pdfMark/model/markSheet.dart';

import 'package:flutterfirebase/pdfMark/widget/button_widget.dart';
import 'package:flutterfirebase/pdfMark/widget/title_widget.dart';
import 'package:provider/provider.dart';

import '../../providars/user_provider.dart';

class PdfPageMark extends StatefulWidget {
  @override
  _PdfPageMarkState createState() => _PdfPageMarkState();
}

class _PdfPageMarkState extends State<PdfPageMark> {
  Object? get valueSem => null;
  var students1;
  void getData() async {
    students = [];
    FirebaseFirestore.instance
        .collection(
            "/Bharathiar University/DCA/Course/MCA/Batch/Batch-19/Mark/SEM-2/19CSEA001")
        .snapshots()
        .listen((data) => data.docs.forEach((doc) {
              print(data.docs.length);
              print(doc.data()['subjectCode']);

              var Mark = new Student(
                  subjectCode: doc.data()['subjectCode'],
                  subjectName: doc.data()['subjectName'],
                  internalMark: doc.data()['internalMark'],
                  externalMark: doc.data()['externalMark'],
                  result: doc.data()['result'],
                  totalMark: doc.data()['totalMark']);
              students.add(Mark);
              print(students);
            }));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // getData();
  }

  @override
  Widget build(BuildContext context) {
    model.User user = Provider.of<UserProvider>(context).getUser;
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        title: Text('Marksheet'),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.all(32),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TitleWidget(
                icon: Icons.picture_as_pdf,
                text: 'Generate MarkSheet',
              ),
              const SizedBox(height: 48),
              ButtonWidget(
                text: 'Invoice PDF',
                onClicked: () async {},
                userName: '${user.username}',
                RegNo: '${user.RegNo}',
                Course: '${user.Course}',
                Batch: '${user.Batch}',
                Dept: '${user.Dept}',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
