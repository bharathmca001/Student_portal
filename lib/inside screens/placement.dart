import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterfirebase/webView/browser.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:path_provider/path_provider.dart' as p;

import 'package:permission_handler/permission_handler.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import 'package:dio/dio.dart';

class placementTrain extends StatefulWidget {
  const placementTrain({Key? key}) : super(key: key);

  @override
  State<placementTrain> createState() => _placementTrainState();
}

class _placementTrainState extends State<placementTrain> {
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

  Widget Aptitude() {
    Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance
        .collection('/Bharathiar University/DCA/Placement/Training/Aptitude')
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
                color: Colors.white,
                shadowColor: Colors.black,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ListTile(
                      leading: Icon(Icons.book),
                      hoverColor: Colors.lightBlueAccent,
                      title: AutoSizeText(data['title'],
                          maxFontSize: 20, style: GoogleFonts.alike()),
                      subtitle: AutoSizeText(data['author'],
                          maxFontSize: 18, style: GoogleFonts.lato()),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        TextButton(
                          child: const Text('VIEW'),
                          onPressed: () {
                            if (GetPlatform.isWeb) {
                              Browser().launchInBrowser(data['download']);
                            } else {
                              Get.to(pdfView(
                                path: data['download'],
                                name: data['title'],
                              ));
                            }
                          },
                        ),
                        const SizedBox(width: 8),
                        TextButton(
                          child: const Text('DOWNLOAD'),
                          onPressed: () {
                            if (GetPlatform.isWeb) {
                              Browser().launchInBrowser(data['download']);
                            } else {
                              print(data['download']);
                              print(data['img']);
                              // try to download
                              final urlPath = data['download'];
                              _downloadAndSaveFile(
                                  context, urlPath, data['img']);
                            }
                          },
                        ),
                        const SizedBox(width: 8),
                      ],
                    ),
                  ],
                ),
              ));
            }).toList(),
          );
        });
  }

  Widget GdTopic() {
    Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance
        .collection('/Bharathiar University/DCA/Placement/Training/GdTopics')
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
                  color: Colors.white,
                  shadowColor: Colors.black,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ListTile(
                        hoverColor: Colors.white70,
                        title: AutoSizeText(data['title'],
                            maxFontSize: 20, style: GoogleFonts.alike()),
                        subtitle: AutoSizeText(data['subtitle'],
                            maxFontSize: 18, style: GoogleFonts.lato()),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          );
        });
  }

  Widget Test() {
    Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance
        .collection('/Bharathiar University/DCA/Placement/Training/Test')
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
                  color: Colors.white,
                  shadowColor: Colors.black,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ListTile(
                        hoverColor: Colors.lightBlueAccent,
                        title: AutoSizeText(data['title'],
                            maxFontSize: 20, style: GoogleFonts.alike()),
                        subtitle: AutoSizeText(data['subtitle'],
                            maxFontSize: 18, style: GoogleFonts.lato()),
                        onTap: () {
                          //
                        },
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          TextButton(
                            child: const Text('VIEW'),
                            onPressed: () {
                              if (GetPlatform.isWeb) {
                                Browser().launchInBrowser(data['download']);
                              } else {
                                Get.to(pdfView(
                                  path: data['download'],
                                  name: data['title'],
                                ));
                              }
                            },
                          ),
                          const SizedBox(width: 8),
                          TextButton(
                            child: const Text('DOWNLOAD'),
                            onPressed: () {
                              if (GetPlatform.isWeb) {
                                Browser().launchInBrowser(data['download']);
                              } else {
                                final urlPath = data['download'];
                                _downloadAndSaveFile(
                                    context, urlPath, data['img']);
                              }
                            },
                          ),
                          const SizedBox(width: 8),
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
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Colors.blueGrey,
        appBar: AppBar(
          title: Text("Placement"),
          bottom: const TabBar(tabs: [
            Tab(icon: Text('Aptitude')),
            Tab(icon: Text('GDTopics')),
            Tab(icon: Text('Test')),
          ]),
        ),
        body: TabBarView(
          children: [
            Aptitude(),
            GdTopic(),
            Test(),
          ],
        ),
      ),
    );
  }
}

class pdfView extends StatefulWidget {
  var path;
  String name;

  pdfView({Key? key, @required this.path, required this.name})
      : super(key: key);

  @override
  _pdfViewState createState() => _pdfViewState();
}

class _pdfViewState extends State<pdfView> {
  final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        title: Text(widget.name),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.bookmark,
              color: Colors.white,
            ),
            onPressed: () {
              _pdfViewerKey.currentState?.openBookmarkView();
            },
          ),
        ],
      ),
      body: SfPdfViewer.network(
        widget.path,
        //scrollDirection: PdfScrollDirection.horizontal,
        key: _pdfViewerKey,
      ),
    );
  }
}
