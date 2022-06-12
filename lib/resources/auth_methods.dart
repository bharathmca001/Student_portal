import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:get/get.dart';
import 'package:flutterfirebase/model/user.dart' as model;

class AuthMethods {
  // get user details
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // get user details
  Future<model.User> getUserDetails() async {
    User currentUser = _auth.currentUser!;

    DocumentSnapshot documentSnapshot =
        await _firestore.collection('student').doc(currentUser.uid).get();
    print('check' + currentUser.uid);
    return model.User.fromSnap(documentSnapshot);
  }

  Future<String> loginUser(
      {required String email, required String password}) async {
    String res = "some error occ";
    try {
      // print('come login');
      _auth.currentUser?.sendEmailVerification();
      print('send');
      if (email.isNotEmpty || password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );

        User? user = FirebaseAuth.instance.currentUser;

        if (user != null && !user.emailVerified) {
          await user.sendEmailVerification();
          Get.snackbar("Verification", "Verify Your Email");
          res = "Verify";
        } else {
          res = "success";
        }
      } else {
        res = "Please enter all the fields";
      }
    } on FirebaseException catch (e) {
      if (e.code == 'user-not-found') {
        res = "user not found";
      } else if (e.code == 'wrong-password') {
        res = "wrong password";
      }
    } catch (err) {
      print(err.toString());
      return err.toString();
    }
    print('return res is $res');
    return res;
  }

  Future signOut() async {
    await _auth.signOut();
  }
}
