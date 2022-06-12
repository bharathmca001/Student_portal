import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutterfirebase/video/videoplayer.dart';
import 'package:flutterfirebase/webView/browser.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart' as p;
import 'package:progress_dialog/progress_dialog.dart';

class webinar extends StatefulWidget {
  const webinar({Key? key}) : super(key: key);

  @override
  _webinarState createState() => _webinarState();
}

class _webinarState extends State<webinar> {
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
          newPath = newPath + "/BU/Webinar";
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
        .collection('Bharathiar University/DCA/Webinar')
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
                  clipBehavior: Clip.antiAlias,
                  color: Colors.limeAccent,
                  shadowColor: Colors.black,
                  child: Column(
                    children: [
                      ListTile(
                        hoverColor: Colors.white70,
                        title: Text(
                          data['title'],
                          style: TextStyle(
                              color: Colors.black.withOpacity(0.6),
                              fontSize: 15),
                        ),
                        subtitle: Text("Department of computer application"),
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
                              Get.to(videoDisplay(videoUrl: data['download']));
                            },
                            child: const Text('PLAY'),
                          ),
                          ElevatedButton(
                            //textColor: const Color(0xFF6200EE),
                            onPressed: () {
                              // Perform some action
                              print(data['download']);
                              print(data['img']);
                              // try to download
                              if (GetPlatform.isWeb) {
                                Browser().launchInBrowser(data['download']);
                              } else {
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
      // backgroundColor: Colors.grey,
      appBar: AppBar(
        title: Text('Webinar'),
      ),
      body: Container(child: buildCard()),
    );
  }
}
