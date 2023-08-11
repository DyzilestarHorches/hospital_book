import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hospital_booking/components/home_card.dart';
import 'package:hospital_booking/screens/myTicket.dart';

import '../screens/booking.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({super.key});

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
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
          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data =
                snapshot.data!.data() as Map<String, dynamic>;
            return Container(
              height: double.infinity,
              color: Color(0xFFDEDEDE),
              child: Padding(
                padding: EdgeInsets.fromLTRB(30, 20, 30, 20),
                child: SingleChildScrollView(
                  child: Column(children: [
                    //profile
                    Container(
                      child: Row(children: [
                        //photo
                        Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image:
                                      AssetImage('assets/images/billgate.jpg')),
                              borderRadius: BorderRadius.circular((50))),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        //info
                        Container(
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  '${data['name']}',
                                  style: TextStyle(
                                      fontFamily: 'Actor',
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  'Nat. ID: ${data['natID']}',
                                  style: TextStyle(
                                      fontFamily: 'Actor', fontSize: 15),
                                ),
                              ]),
                        )
                      ]),
                    ),

                    const SizedBox(
                      height: 40,
                    ),
                    //title
                    Container(
                      width: double.infinity,
                      alignment: Alignment.centerLeft,
                      child: const Text(
                        'Bookings',
                        style: TextStyle(
                            fontFamily: 'Actor',
                            fontSize: 30,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Booking()));
                      },
                      child: HomeCard(
                          'assets/images/ticket-icon.png',
                          'Book A Ticket',
                          'Describe symptom, choose time, and get a ticket',
                          Color(0xFF61C4E3)),
                    ),
                    const SizedBox(
                      height: 20,
                    ),

                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MyTicket()));
                      },
                      child: HomeCard(
                          'assets/images/clock-icon.png',
                          'My Tickets',
                          'View booked tickets, and schedule your time',
                          Color(0xFFA8DE65)),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    HomeCard('assets/images/setting-icon.png', 'Settings',
                        'Configure privacy and preferences', Color(0xFFDEDEDE))
                  ]),
                ),
              ),
            );
          }
          return Center(child: CircularProgressIndicator());
        });
  }
}
