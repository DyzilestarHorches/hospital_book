import 'package:flutter/material.dart';
import 'package:hospital_booking/screens/home.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hospital_booking/screens/loginWithUser.dart';

import 'home.dart';
import 'loginWithUser.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool passVisibility = false;
  int passLength = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(),
            //image
            Container(
              width: 140,
              height: 140,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(80),
                  //border: Border.all(color: Color(0xFF61C4E3), width: 3),
                  image: const DecorationImage(
                      image: AssetImage('assets/images/hospital.jpg'),
                      fit: BoxFit.cover)),
            ),
            //Full name
            const SizedBox(
              height: 50,
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(50, 0, 50, 0),
              child: const TextField(
                  //obscureText: true,
                  textAlign: TextAlign.left,
                  style: TextStyle(fontFamily: 'Actor', fontSize: 20),
                  decoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFFF29A49))),
                      hintText: 'Full Name')),
            ),
            //natID
            const SizedBox(
              height: 5,
            ),

            Container(
              padding: const EdgeInsets.fromLTRB(50, 0, 50, 0),
              child: const TextField(
                  //obscureText: true,
                  textAlign: TextAlign.left,
                  style: TextStyle(fontFamily: 'Actor', fontSize: 20),
                  decoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFFF29A49))),
                      hintText: 'National ID')),
            ),

            const SizedBox(
              height: 5,
            ),
            //Username
            Container(
              padding: const EdgeInsets.fromLTRB(50, 0, 50, 0),
              child: const TextField(
                  //obscureText: true,
                  textAlign: TextAlign.left,
                  style: TextStyle(fontFamily: 'Actor', fontSize: 20),
                  decoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFFF29A49))),
                      hintText: 'Username')),
            ),
            const SizedBox(
              height: 5,
            ),
            //password
            Container(
              padding: const EdgeInsets.fromLTRB(50, 0, 50, 0),
              child: TextField(
                  onChanged: (text) {
                    setState(() {
                      passLength = text.length;
                    });
                  },
                  obscureText: !passVisibility,
                  textAlign: TextAlign.left,
                  style: const TextStyle(fontFamily: 'Actor', fontSize: 20),
                  decoration: InputDecoration(
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            passVisibility = !passVisibility;
                          });
                        },
                        icon: passVisibility
                            ? const Icon(Icons.visibility)
                            : const Icon(Icons.visibility_off),
                      ),
                      enabledBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFFF29A49))),
                      hintText: 'Password')),
            ),

            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(50, 0, 50, 0),
              child: Container(
                decoration: BoxDecoration(
                    color: (passLength == 0)
                        ? Colors.transparent
                        : (passLength < 6)
                            ? Colors.red
                            : (passLength < 8)
                                ? Colors.orange
                                : Colors.green,
                    borderRadius: BorderRadius.circular(5)),
                width: double.infinity,
                height: 10,
              ),
            ),
            //button
            const SizedBox(
              height: 30,
            ),
            SizedBox(
                width: 150,
                height: 50,
                child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(const Color(0xFFF29A49)),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        )),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const MyHomePage()));
                    },
                    child: const Text(
                      'Register',
                      style: TextStyle(fontFamily: 'Actor', fontSize: 18),
                    ))),
            Spacer(),
            GestureDetector(
              onTap: () => {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const LoginWithUser()))
              },
              child: Container(
                width: double.infinity,
                height: 50,
                padding: const EdgeInsets.fromLTRB(0, 0, 25, 0),
                child: const Text(
                  'Have an account? Login',
                  textAlign: TextAlign.end,
                  style: TextStyle(
                      color: Color(0xFF61C4E3),
                      fontFamily: 'Actor',
                      fontSize: 15),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
