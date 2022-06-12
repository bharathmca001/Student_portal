import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutterfirebase/webView/browser.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart' as p;
import 'package:progress_dialog/progress_dialog.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class event extends StatefulWidget {
  const event({Key? key}) : super(key: key);

  @override
  _eventState createState() => _eventState();
}

class _eventState extends State<event> {
  late String _fileFullPath;
  Dio dio = Dio();
  late String progress;
  Future<List<Directory>?> _getExternalStoragePath() {
    return p.getExternalStorageDirectories(type: p.StorageDirectory.documents);
  }

  late String newPath = "";
  //request permission
  Future<bool> _requestPermission(Permission permission) async {
    if (await permission.isGranted) {
      return true;
    } else {
      var result = await permission.request();
      if (result == PermissionStatus.granted) {
        return true;
      } else {
        return false;
      }
    }
  }

  Future _downloadAndSaveFile(
      BuildContext context, String urlPath, String fileName) async {
    ProgressDialog pr;
    pr = new ProgressDialog(context, type: ProgressDialogType.Normal);
    pr.style(message: "Downloading file");
    try {
      if (Platform.isAndroid) {
        if (await _requestPermission(Permission.storage)) {
          await pr.show();

          final dirList = await _getExternalStoragePath();

          final path = dirList![0].path;
          List<String> folders = path.split("/");
          for (int x = 1; x < folders.length; x++) {
            String folder = folders[x];
            if (folder != "Android") {
              newPath += "/" + folder;
            } else {
              break;
            }
          }
          newPath = newPath + "/BU";
          final file = File('$newPath/$fileName');
          // var dio = Dio();
          await dio.download(urlPath, file.path,
              onReceiveProgress: (rec, total) {
            setState(() {
              progress = ((rec / total) * 100).toStringAsFixed(0) + "%";
              print(progress);
              pr.update(message: "please Wait:$progress");
            });
          });
          pr.hide();
          newPath = "";
          _fileFullPath = file.path;
          print(_fileFullPath);
        } else {
          print('permission error');
          return false;
        }
      }
    } catch (e) {
      print(e);
    }
    return false;
  }

  Widget buildCard() {
    Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance
        .collection('Bharathiar University/Event/Circular')
        .orderBy('created', descending: true)
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
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                  elevation: 10,
                  clipBehavior: Clip.antiAlias,
                  color: Colors.white,
                  shadowColor: Colors.black,
                  borderOnForeground: true,
                  child: Column(
                    children: [
                      ListTile(
                        hoverColor: Colors.white70,
                        title: Text(
                          data['title'],
                          style: TextStyle(
                              color: Colors.black.withOpacity(0.8),
                              fontSize: 16),
                        ),
                        subtitle: Text(
                          'Updated :' +
                              DateFormat.yMMMd()
                                  .add_jm()
                                  .format(data['created'].toDate()),
                          style: TextStyle(
                              color: Colors.black.withOpacity(0.6),
                              fontSize: 14),
                        ),
                        //trailing: Icon(Icons.keyboard_arrow_right),
                        // onTap: () {
                        //  Get.to(pdfView(path: data['download']));
                        //  print(data['download']);
                        //},
                      ),
                      ButtonBar(
                        //alignment: MainAxisAlignment.start,
                        children: [
                          ElevatedButton(
                            //textColor: const Color(0xFF6200EE),
                            onPressed: () {
                              // Perform some action
                              if (GetPlatform.isWeb) {
                                Browser().launchInBrowser(data['download']);
                              } else {
                                Get.to(pdfView(
                                  path: data['download'],
                                  name: data['title'],
                                ));
                              }
                            },
                            child: const Text('VIEW'),
                          ),
                          ElevatedButton(
                            //textColor: const Color(0xFF6200EE),
                            onPressed: () {
                              if (GetPlatform.isWeb) {
                                Browser().launchInBrowser(data['download']);
                              } else {
                                // try to download
                                final urlPath = data['download'];
                                _downloadAndSaveFile(
                                    context, urlPath, data['img']);
                              }
                            },
                            child: const Text('DOWNLOAD'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        title: Text('Event'),
      ),
      body: buildCard(),
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
      backgroundColor: Colors.blueGrey,
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
