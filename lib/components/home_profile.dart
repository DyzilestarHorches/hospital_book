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
                width: 300,
                height: 230,
                child: Stack(
                  children: [
                    //info
                    Positioned(
                      top: 30,
                      child: Container(
                        width: 300,
                        height: 200,
                        decoration: BoxDecoration(color: Colors.blue),
                        child: Column(children: [
                          Text('${data['name']}'),
                          Text('${data['natID']}'),
                          //Text('${data['age']}'),
                        ]),
                      ),
                    ),
                    Positioned(
                      left: 150 - 30,
                      child: Container(
                        width: 60,
                        height: 60,
                        child: Icon(Icons.person),
                        decoration: BoxDecoration(
                            color: Colors.orange,
                            borderRadius: BorderRadius.circular(30)),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }

          return CircularProgressIndicator();
        });
  }
}
