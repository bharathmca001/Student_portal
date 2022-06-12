import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String email;
  final String uid;
  final String username;
  final String Batch;
  final String Course;
  final String Dept;
  final String RegNo;

  const User({
    required this.username,
    required this.uid,
    required this.email,
    required this.Batch,
    required this.Course,
    required this.Dept,
    required this.RegNo,
  });

  static User fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return User(
      username: snapshot["Name"],
      uid: snapshot["Uid"],
      email: snapshot["email"],
      Batch: snapshot["Batch"],
      Course: snapshot["Course"],
      Dept: snapshot["Dept"],
      RegNo: snapshot["Reg-No"],
    );
  }

  Map<String, dynamic> toJason() => {
        "username": username,
        "uid": uid,
        "email": email,
        "Batch": Batch,
        "Course": Course,
        "Dept": Dept,
        "RegNo": RegNo,
      };
}
