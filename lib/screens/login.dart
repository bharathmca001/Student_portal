import 'dart:ui';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutterfirebase/resources/auth_methods.dart';
import 'package:flutterfirebase/responsive/dimansion.dart';
import 'package:flutterfirebase/responsive/mobileScreenLayout.dart';
import 'package:flutterfirebase/responsive/responsive_layout.dart';
import 'package:flutterfirebase/responsive/webScreenLayout.dart';
import 'package:flutterfirebase/screens/emailVerifyPage.dart';

import 'package:flutterfirebase/widgets/text_field.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var getEmail;
  var getId;
  final TextEditingController _regController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  bool _isLoading = false;
  late Future<void> _initializeFlutterFireFuture;
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _regController.dispose();
    _dobController.dispose();
  }

  void loginUser() async {
    setState(() {
      _isLoading = true;
    });
    String res = await AuthMethods()
        .loginUser(email: _regController.text, password: _dobController.text);
    print(res);
    if (res == "Verify") {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => emailVerifyPage()));
    } else if (res == "success") {
      // go to home screen
      print(res);
      // var currentUser = FirebaseAuth.instance.currentUser;
      //  setState(() {
      //    getEmail = currentUser!.email.toString();
      //    getId = currentUser.uid.toString();
      //    print(getEmail);
      //  });

      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => ResponsiveLayout(
              webScreenLayout: webScreenLayout(),
              mobileScreenLayout: mobileScreenLayout())));

      setState(() {
        _isLoading = false;
      });
    } else if (res == "admin") {
      print("admin");

      setState(() {
        _isLoading = false;
      });
      Get.snackbar("result", 'enter valid email');
    } else {
      setState(() {
        _isLoading = false;
      });
      Get.snackbar("result", res);
      //
      // Navigator.of(context).pushReplacement(
      //     MaterialPageRoute(builder: (context) => emailVerifyPage()));
      //showSnackBar(res, context); //its from utils file we dont need it now
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      // padding: EdgeInsets.only(top: 35, right: 10, left: 10),
      padding: EdgeInsets.all(1),
      child: Scaffold(
        appBar: AppBar(
          title: AutoSizeText(
            "Student Portal",
            textAlign: TextAlign.center,
            maxFontSize: 30,
            style: GoogleFonts.roboto(),
          ),
        ),
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Container(
            padding: MediaQuery.of(context).size.width > webScreenSize
                ? EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width / 3)
                : const EdgeInsets.symmetric(horizontal: 32),
            width: double.infinity,
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Flexible(
                    child: Container(),
                    flex: 2,
                  ),
                  //image
                  SizedBox(height: 150, child: Image.asset('assets/BU.png')),

                  const SizedBox(height: 64),
                  //textfield input regno
                  TextFieldInput(
                      textEditingController: _regController,
                      hintText: 'Email Id',
                      textInputType: TextInputType.text),
                  //textfield input password
                  const SizedBox(height: 24),
                  TextFieldInput(
                      textEditingController: _dobController,
                      hintText: 'Password',
                      isPass: true,
                      textInputType: TextInputType.text),
                  //button login
                  const SizedBox(height: 24),
                  InkWell(
                    onTap: () {
                      loginUser();
                    },
                    child: Container(
                      child: _isLoading
                          ? const Center(
                              child: CircularProgressIndicator(
                                color: Colors.white,
                              ),
                            )
                          : const Text('Login',
                              style: TextStyle(color: Colors.white)),
                      width: double.infinity,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: const ShapeDecoration(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(4),
                          ),
                        ),
                        color: Colors.blue,
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),
                  //transation to singin
                  Flexible(
                    child: Container(),
                    flex: 2,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        child: AutoSizeText("Forgot Your Password?"),
                        padding: const EdgeInsets.symmetric(vertical: 8),
                      ),
                      GestureDetector(
                        child: Text(
                          "Click to Reset",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        onTap: () {
                          ResetPassword();
                        },
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  //login
  Future ResetPassword() async {
    await FirebaseAuth.instance
        .sendPasswordResetEmail(email: _regController.text.trim());

    Get.snackbar('Reset Password', 'Email Send Successfully!!');
  }
}
