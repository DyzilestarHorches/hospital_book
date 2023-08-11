import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hospital_booking/components/my_tickets_ticket.dart';

class MyTicket extends StatefulWidget {
  const MyTicket({super.key});

  @override
  State<MyTicket> createState() => _MyTicketState();
}

class _MyTicketState extends State<MyTicket> {
  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    final User? user = auth.currentUser;
    final uid = user?.uid;
    CollectionReference tickets =
        FirebaseFirestore.instance.collection('user/${uid}/tickets');
    return FutureBuilder<QuerySnapshot>(
        future: tickets.orderBy('time').get(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final allData =
                snapshot.data?.docs.map((doc) => doc.data()).toList();
            print(allData);
            return Scaffold(
              appBar: AppBar(
                backgroundColor: Color(0xFFF29A49),
                title: Text('My Tickets'),
                centerTitle: true,
              ),
              body: Container(
                width: double.infinity,
                color: Color(0xFFDEDEDE),
                child: Padding(
                    padding: EdgeInsets.fromLTRB(30, 20, 30, 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Upcomming Tickets',
                          style: TextStyle(
                              fontFamily: 'Actor',
                              fontSize: 30,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: allData!.map((e) {
                            final object = e as Map<String, dynamic>;
                            Timestamp timestamp = object['time'];

                            return Column(
                              children: [
                                const SizedBox(
                                  height: 10,
                                ),
                                MyTicketsTicket(
                                    room: object['room'],
                                    department: object['department'],
                                    date: DateTime.fromMillisecondsSinceEpoch(
                                        (timestamp.millisecondsSinceEpoch)
                                            .toInt())),
                              ],
                            );
                          }).toList(),
                        ),
                      ],
                    )),
              ),
            );
          }
          return Center(child: CircularProgressIndicator());
        });
  }
}
