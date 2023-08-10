import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hospital_booking/firebase_options.dart';
import 'package:hospital_booking/screens/home.dart';
import 'package:hospital_booking/screens/login.dart';
import 'package:hospital_booking/screens/register.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    // TODO: implement initState
    checkLogin();
  }

  Future<void> checkLogin() async {
    await Future.delayed(Duration(seconds: 2));
    var pref = await SharedPreferences.getInstance();
    String? userName = pref.getString('username');
    String? password = pref.getString('password');

    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
    // FirebaseAuth.instance.authStateChanges().listen((User? user) async {
    //   if (user == null) {
    if (userName == null || password == null) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Login()));
    } else {
      try {
        FirebaseAuth.instance
            .signInWithEmailAndPassword(email: userName, password: password)
            .then((value) => {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => MyHomePage()))
                });
      } on FirebaseAuthException catch (e) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Register()));
      }
    }
    // } else {
    //   Navigator.of(context).pushReplacement(
    //       MaterialPageRoute(builder: (context) => MyHomePage()));
    // }

    //check with server
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      //icon
      child: Container(
          width: 240,
          height: 240,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(120),
            image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage('assets/images/hospital.jpg')),
          )),
    ));
  }
}
