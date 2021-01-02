import 'package:DropBox/Screens/HomeScreen.dart';
import 'package:DropBox/Screens/LoginScreen.dart';
import 'package:DropBox/Screens/RegisterScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
    .then((_) {
      runApp(new MyApp());
    });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'DropBox',
      home:FirebaseAuth.instance.currentUser==null? LoginScreen():HomePage(),
      routes: {
        'login':(context)=>LoginScreen(),
        'register':(context)=>RegisterScreen(),
        'homeScreen':(home)=>HomePage(),
      },
    );
  }
}

