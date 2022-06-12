import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class feePay extends StatefulWidget {
  final String userdept;
  final String userCourse;
  const feePay({Key? key, required this.userdept, required this.userCourse})
      : super(key: key);

  @override
  _feePayState createState() => _feePayState();
}

class _feePayState extends State<feePay> {
  Widget feeCard() {
    Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance
        .collection('/Fee/${widget.userdept}/${widget.userCourse}')
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

              return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Column(children: <Widget>[
                    Center(
                        child: Text(
                      '${widget.userCourse} Fee',
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    )),
                    ElevatedButton(
                      onPressed: () {
                        _launchInBrowser(
                            'http://fms.b-u.ac.in:8000/semfees-login/');
                      },
                      child: Text("Click to view payment details"),
                    ),
                    DataTable(
                      columns: [
                        DataColumn(
                            label: Text('Description',
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold))),
                        DataColumn(
                            label: Text('Amount',
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold))),
                      ],
                      rows: [
                        DataRow(cells: [
                          DataCell(Text('Tuition Fee (Per Semester)')),
                          DataCell(Text(data['Tuition fee'])),
                        ]),
                        DataRow(cells: [
                          DataCell(Text(
                              'Tuition Fee (Per Semester) (For SC / ST - Students)')),
                          DataCell(Text(data['Tuition Fee SC/ST'])),
                        ]),
                        DataRow(cells: [
                          DataCell(Text('Lab Fee')),
                          DataCell(Text(data['Lab Fee'])),
                        ]),
                        DataRow(cells: [
                          DataCell(Text('Course Material Fee')),
                          DataCell(Text(data['Course Material'])),
                        ]),
                        DataRow(cells: [
                          DataCell(Text('Special Fee')),
                          DataCell(Text(data['Special Fee'])),
                        ]),
                        DataRow(cells: [
                          DataCell(Text('Other Fee (For BU Students)')),
                          DataCell(Text(data['Other Fee BU'])),
                        ]),
                        DataRow(cells: [
                          DataCell(Text(
                              'Other Fee (For Other Institution Students)')),
                          DataCell(Text(data['Other Fee Other'])),
                        ]),
                      ],
                    ),
                    Center(
                        child: Text(
                      'Total Fee',
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    )),
                    DataTable(columns: [
                      DataColumn(
                          label: Text('Semester',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold))),
                      DataColumn(
                          label: Text('BU Students',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold))),
                      DataColumn(
                          label: Text('SC/ST-Students',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold))),
                    ], rows: [
                      DataRow(cells: [
                        DataCell(Text('I')),
                        DataCell(Text(data['First sem'])),
                        DataCell(Text(data['First Sem SC'])),
                      ]),
                      DataRow(cells: [
                        DataCell(Text('II')),
                        DataCell(Text(data['Second Sem'])),
                        DataCell(Text(data['Second Sem SC'])),
                      ]),
                      DataRow(cells: [
                        DataCell(Text('III')),
                        DataCell(Text(data['Third Sem'])),
                        DataCell(Text(data['Third Sem SC'])),
                      ]),
                      DataRow(cells: [
                        DataCell(Text('IV')),
                        DataCell(Text(data['Fourth Sem'])),
                        DataCell(Text(data['Fourth Sem SC'])),
                      ]),
                    ]),
                  ]));
            }).toList(),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fees details'),
      ),
      body: feeCard(),
    );
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
