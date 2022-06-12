import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutterfirebase/model/user.dart' as model;
import 'package:flutterfirebase/providars/user_provider.dart';
import 'package:provider/provider.dart';
import '../api/pdfMarkSheet_api.dart';
import '../api/pdf_api.dart';
import '../model/markSheet.dart';

class ButtonWidget extends StatefulWidget {
  final String text;
  final String userName;
  final String RegNo;
  final String Dept;
  final String Course;
  final String Batch;
  final VoidCallback onClicked;

  const ButtonWidget(
      {Key? key,
      required this.text,
      required this.onClicked,
      required this.RegNo,
      required this.userName,
      required this.Course,
      required this.Dept,
      required this.Batch})
      : super(key: key);

  @override
  State<ButtonWidget> createState() => _ButtonWidgetState();
}

class _ButtonWidgetState extends State<ButtonWidget> {
  //
  var hintSem = "Choose Semester";

  var valueSem;

  var valueChoose;

  Widget body() {
    if (valueSem != null) {
      print(valueSem);
      return ElevatedButton(
          onPressed: makeMark, child: Text('$valueSem open pdf'));
    } else {
      print('null');
      return getSem();
    }
  }

  void makeMark() async {
    print('onclicked');

    print(valueSem);
    final markSheet = MarkSheet(
      info: StudentInfo(name: widget.userName, regNo: widget.RegNo),
    );

    final pdfFile = await PdfInvoiceApi.generate(markSheet);

    PdfApi.openFile(pdfFile);
  }

  void getData() async {
    print('getdata');
    print(valueSem);
    String sem = valueSem.toString();
    students = [];
    FirebaseFirestore.instance
        .collection(
            "/Bharathiar University/${widget.Dept}/Course/${widget.Course}/Batch/${widget.Batch}/Mark/$sem/${widget.RegNo}")
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

  Widget getSem() {
    // print(Course);
    model.User user = Provider.of<UserProvider>(context).getUser;

    Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance
        .collection(
            '/Bharathiar University/${user.Dept}/Course/${user.Course}/Batch/${user.Batch}/Mark/')
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
          return DropdownButton(
              onTap: () {
                print('hear also');
                widget.onClicked;
              },
              hint: Text(
                hintSem,
                style: TextStyle(color: Colors.white),
              ),
              items: snapshot.data!.docs.map((DocumentSnapshot document) {
                return DropdownMenuItem(
                  child: Text(document.id),
                  value: document.id,
                );
              }).toList(),
              value: valueSem,
              onChanged: (value) {
                setState(() {
                  this.hintSem = value.toString();
                  this.valueSem = value.toString();
                  print('here work' + valueSem);

                  getData();
                  widget.onClicked;
                });
              });
        });
  }

  //
  @override
  Widget build(BuildContext context) {
    return body();
    // return ElevatedButton(
    //   style: ElevatedButton.styleFrom(
    //     minimumSize: Size.fromHeight(40),
    //   ),
    //   child: FittedBox(
    //     child: Text(
    //       widget.text,
    //       style: TextStyle(fontSize: 20, color: Colors.white),
    //     ),
    //   ),
    //   onPressed: widget.onClicked,
    // );
  }
}
