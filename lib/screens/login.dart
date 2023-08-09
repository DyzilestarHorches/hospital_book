import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hospital_booking/screens/home.dart';
import 'package:hospital_booking/screens/loginWithUser.dart';
import 'package:hospital_booking/screens/register.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home.dart';
import 'loginWithUser.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final passController = TextEditingController();
  bool passVisibility = false;
  bool isWaitingForLogin = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color(0xFFE6E6E6),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Spacer(),
            //image
            Container(
              width: 140,
              height: 140,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(80),
                  border: Border.all(color: Color(0xFF61C4E3), width: 3),
                  image: const DecorationImage(
                    image: AssetImage('assets/images/billgate.jpg'),
                  )),
            ),
            const SizedBox(
              height: 10,
            ),
            //name
            const Text(
              'Bill Gates',
              style: TextStyle(fontFamily: 'Actor', fontSize: 28),
            ),
            const SizedBox(
              height: 20,
            ),
            //TextField
            Container(
              padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
              child: TextField(
                  controller: passController,
                  obscureText: true,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontFamily: 'Actor', fontSize: 20),
                  decoration: const InputDecoration(
                      // suffixIcon: IconButton(
                      //   onPressed: () {
                      //     setState(() {
                      //       passVisibility = !passVisibility;
                      //     });
                      //   },
                      //   icon: passVisibility
                      //       ? const Icon(Icons.visibility)
                      //       : const Icon(Icons.visibility_off),
                      // ),
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFFF29A49))),
                      hintText: 'Password')),
            ),
            const SizedBox(
              height: 20,
            ),
            //Submit
            isWaitingForLogin
                ? CircularProgressIndicator()
                : SizedBox(
                    width: 150,
                    height: 50,
                    child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                const Color(0xFFF29A49)),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                            )),
                        onPressed: () async {
                          //get API
                          setState(() {
                            isWaitingForLogin = true;
                          });

                          var dio = Dio();
                          String password = passController.text;
                          dio
                              .get(
                                  'http://148.72.158.178/~nandigho/blog/login.php?user=abc123@gmail.com&pass=$password')
                              .then((res) async {
                            setState(() {
                              isWaitingForLogin = false;
                            });
                            var jsonObject = jsonDecode(res.data);
                            //print(jsonObject['result']);
                            if (jsonObject['result']) {
                              //save Pref
                              var pref = await SharedPreferences.getInstance();
                              await pref.setString(
                                  'password', passController.text);

                              //move Home
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const MyHomePage()));
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text(jsonObject['reason'])));
                            }
                          });
                        },
                        child: const Text(
                          'Login',
                          style: TextStyle(fontFamily: 'Actor', fontSize: 18),
                        ))),
            Spacer(),

            //Not you?
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
                  'Not you? Change account',
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
