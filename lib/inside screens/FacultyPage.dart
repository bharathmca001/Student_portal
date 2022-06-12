import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../responsive/dimansion.dart';
import '../webView/browser.dart';

class facultyPage extends StatefulWidget {
  const facultyPage({Key? key}) : super(key: key);

  @override
  State<facultyPage> createState() => _facultyPageState();
}

class _facultyPageState extends State<facultyPage> {
  Widget buildCard() {
    Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance
        .collection('/Bharathiar University/DCA/Faculty')
        // .orderBy('created', descending: true)
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
                child: Column(
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          child: Icon(
                            Icons.account_circle,
                            size: 100,
                          ),

                          radius: 40,
                          backgroundColor: Colors.blueGrey,
                          //backgroundImage: NetworkImage(url),
                          // backgroundImage: NetworkImage(url),
                        ),
                        Expanded(
                            child: InkWell(
                          onTap: () {
                            print(data['Name']);
                            if (GetPlatform.isWeb) {
                              Browser().launchInBrowser(data['Pdf']);
                            } else {
                              Get.to(pdfView(
                                path: data['Pdf'],
                                name: data['Name'],
                              ));
                            }
                          },
                          child: Padding(
                              padding: EdgeInsets.only(
                                  left: 25, top: 30, bottom: 30),
                              child: Text('\n' +
                                  data['Name'] +
                                  '\n' +
                                  data['Designation'])),
                        )),
                      ],
                    ),
                  ],
                ),
              );
            }).toList(),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        title: Text('Faculty page'),
      ),
      body: Container(
          padding: MediaQuery.of(context).size.width > webScreenSize
              ? EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width / 3)
              : const EdgeInsets.symmetric(horizontal: 32),
          width: double.infinity,
          child: buildCard()),
    );
  }
}

class pdfView extends StatefulWidget {
  var path;
  var name;
  pdfView({Key? key, @required this.path, required this.name})
      : super(key: key);

  @override
  _pdfViewState createState() => _pdfViewState();
}

class _pdfViewState extends State<pdfView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
      ),
      body: Container(
        child: SfPdfViewer.network(
          widget.path,
        ),
      ),
    );
  }
}
