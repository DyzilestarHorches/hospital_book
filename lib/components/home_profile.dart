import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfileWidget extends StatefulWidget {
  const ProfileWidget({super.key});

  @override
  State<ProfileWidget> createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends State<ProfileWidget> {
  CollectionReference users = FirebaseFirestore.instance.collection('user');
  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    final User? user = auth.currentUser;
    final uid = user?.uid;

    return FutureBuilder<DocumentSnapshot>(
        future: users.doc(uid).get(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text("Something went wrong");
          }
          if (snapshot.hasData && !snapshot.data!.exists) {
            return Text("Document does not exist");
          }

          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data =
                snapshot.data!.data() as Map<String, dynamic>;
            return Center(
              child: Container(
                width: 350,
                height: 230,
                child: Stack(
                  children: [
                    //info
                    Positioned(
                      top: 30,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
                        child: Container(
                          padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                          width: 350 - 80,
                          height: 200,
                          decoration: BoxDecoration(color: Colors.blue),
                          child: Column(children: [
                            Text('${data['name']}'),
                            Text('${data['natID']}'),
                            //Text('${data['age']}'),
                          ]),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 0,
                      child: Container(
                          width: 80,
                          height: 80,
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(40),
                                image: DecorationImage(
                                    image: AssetImage(
                                        'assets/images/billgate.jpg'))),
                          )),
                    ),
                  ],
                ),
              ),
            );
          }

          return Center(child: CircularProgressIndicator());
        });
  }
}
