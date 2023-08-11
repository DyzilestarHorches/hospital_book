import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hospital_booking/components/choice_holder.dart';
import 'package:hospital_booking/screens/home.dart';
import 'package:jiffy/jiffy.dart';
import 'package:qr_flutter/qr_flutter.dart';

class Ticket extends StatefulWidget {
  final DateTime date;

  const Ticket(this.date, {super.key});

  @override
  State<Ticket> createState() => _TicketState();
}

class _TicketState extends State<Ticket> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  CollectionReference users = FirebaseFirestore.instance.collection('user');

  @override
  Widget build(BuildContext context) {
    final User? user = auth.currentUser;
    final uid = user?.uid;
    final String ticketID = '${user?.uid}-${widget.date}-192';
    CollectionReference tickets =
        FirebaseFirestore.instance.collection('user/${uid}/tickets');

    int payChoice = 0;

    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(uid).get(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text("Something went wrong");
        }
        if (snapshot.hasData && !snapshot.data!.exists) {
          return Text("Document does not exist");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          return Scaffold(
              appBar: AppBar(
                centerTitle: true,
                title: const Text('Deposit Checkout'),
                backgroundColor: const Color(0xFFF29A49),
                foregroundColor: Colors.white,
              ),
              body: Container(
                width: double.infinity,
                alignment: Alignment.center,
                child: SingleChildScrollView(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        //Ticket title
                        const Text(
                          'Omega Hospital',
                          style: TextStyle(
                              fontFamily: 'Actor',
                              fontSize: 25,
                              fontWeight: FontWeight.bold),
                        ),
                        //QR
                        const SizedBox(
                          height: 10,
                        ),
                        QrImageView(
                          data: ticketID,
                          version: QrVersions.auto,
                          size: 150.0,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          '${data['name']} - ${data['age'] != null ? data['age'] : '?'} years old',
                          style: TextStyle(
                            fontFamily: 'Actor',
                            fontSize: 22,
                            //fontWeight: FontWeight.bold
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          'Omega Hospital - Otorhinolaryngology',
                          style: TextStyle(
                            fontFamily: 'Actor',
                            fontSize: 22,
                            //fontWeight: FontWeight.bold
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          'Room 192 - Doctor. Livia',
                          style: TextStyle(
                            fontFamily: 'Actor',
                            fontSize: 22,
                            //fontWeight: FontWeight.bold
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),

                        Text(
                          'Estimated Time: ${Jiffy.parseFromDateTime(widget.date).format(pattern: 'dd MMM yyyy, hh:mm a')}',
                          style: TextStyle(
                              fontFamily: 'Actor',
                              fontSize: 22,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                      ]),
                ),
              ));
        }

        return Center(child: CircularProgressIndicator());
      },
    );
  }
}
