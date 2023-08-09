import 'package:flutter/material.dart';
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
    var pref = await SharedPreferences.getInstance();
    var userName = pref.getString('username');
    var passWord = pref.getString('password');

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
