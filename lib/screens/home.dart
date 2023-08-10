import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../components/home_home.dart';
import '../components/home_profile.dart';
import 'login.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int stateIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFF29A49),
        actions: [Icon(Icons.notifications)],
      ),
      drawer: Drawer(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 50, 0, 0),
          child: Column(children: [
            GestureDetector(
              onTap: () async {
                FirebaseAuth.instance.signOut().then((value) {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => Login()));
                });
              },
              child: Icon(Icons.logout),
            )
          ]),
        ),
      ),
      body: stateIndex == 0 ? HomeWidget() : ProfileWidget(),
      bottomNavigationBar: BottomNavigationBar(
          onTap: (index) {
            setState(() {
              stateIndex = index;
            });
          },
          currentIndex: stateIndex,
          items: [
            const BottomNavigationBarItem(
                icon: Icon(Icons.home), label: 'home'),
            const BottomNavigationBarItem(
                icon: Icon(Icons.person), label: 'profile'),
          ]),
    );
  }
}
