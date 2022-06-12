import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AchievementPage extends StatelessWidget {
  const AchievementPage({Key? key}) : super(key: key);

  Widget buildCard() {
    Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance
        .collection('/Bharathiar University/DCA/Achievements')
        .orderBy('Created', descending: true)
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
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 50,
                            backgroundColor: Colors.white,
                            //backgroundImage: NetworkImage(url),
                            backgroundImage: NetworkImage(data['Img']),
                          ),
                          Expanded(
                              child: InkWell(
                            onTap: () {
                              print(data['Name']);
                            },
                            child: Padding(
                                padding: EdgeInsets.only(
                                  left: 25,
                                ),
                                child: Text(data['Name'] +
                                    '\n' +
                                    data['Course'] +
                                    '\n' +
                                    data['Batch'] +
                                    '\n' +
                                    data['Achievement'])),
                          )),
                        ],
                      ),
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
        title: Text('Achievement'),
      ),
      body: buildCard(),
    );
  }
}
