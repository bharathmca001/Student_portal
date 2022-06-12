import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutterfirebase/providars/user_provider.dart';
import 'package:flutterfirebase/responsive/mobileScreenLayout.dart';
import 'package:flutterfirebase/responsive/responsive_layout.dart';
import 'package:flutterfirebase/responsive/webScreenLayout.dart';
import 'package:flutterfirebase/screens/emailVerifyPage.dart';
import 'package:flutterfirebase/screens/login.dart';
import 'package:flutterfirebase/utils/colours.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

//try
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: 'AIzaSyD83RStlWQGYcufvl7WRsBQXxA65jPtRbg',
          appId: '1:562416368625:web:000091177b8467224d6250',
          messagingSenderId: '562416368625',
          projectId: 'flutterfirebase-39775'),
    );
  }
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  // final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserProvider(),
        ),
      ],
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'DCA',
        theme: ThemeData(
            primarySwatch: Colors.blue, backgroundColor: Colors.grey[200]),

        home: StreamBuilder(
          stream: FirebaseAuth.instance
              .authStateChanges(), //firebase have three methods idTokenchange and userChange
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              if (snapshot.hasData) {
                var currentUser = FirebaseAuth.instance.currentUser;
                print(currentUser!.email.toString());
                if (currentUser.emailVerified) {
                  return const ResponsiveLayout(
                      webScreenLayout: webScreenLayout(),
                      mobileScreenLayout: mobileScreenLayout());
                } else {
                  return emailVerifyPage();
                }
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('bharath ${snapshot.error}'),
                );
              }
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(
                  color: primaryColor,
                ),
              );
            }
            return const LoginScreen();
          },
        ),
//
//         routes: {
//           "Event": (_) => event(),
//         },
      ),
    );
  }
}
