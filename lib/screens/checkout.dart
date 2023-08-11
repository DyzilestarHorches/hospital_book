import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hospital_booking/components/choice_holder.dart';
import 'package:hospital_booking/screens/home.dart';
import 'package:jiffy/jiffy.dart';
import 'package:qr_flutter/qr_flutter.dart';

class Checkout extends StatefulWidget {
  final DateTime date;
  final String symptoms;

  const Checkout(this.date, this.symptoms, {super.key});

  @override
  State<Checkout> createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  CollectionReference users = FirebaseFirestore.instance.collection('user');

  @override
  Widget build(BuildContext context) {
    final User? user = auth.currentUser;
    final uid = user?.uid;
    final String ticketID = '${user?.uid}-${widget.date}-192';
    CollectionReference tickets =
        FirebaseFirestore.instance.collection('user/${uid}/tickets');

    Future<void> addTicket() {
      if (uid != null) {
        return tickets
            .doc(ticketID)
            .set({
              'department': 'General',
              'room': '219',
              'symptom': widget.symptoms,
              'time': widget.date
              //'age': null // 42
            })
            .then((value) => print("User Added"))
            .catchError((error) => print("Failed to add user: $error"));
      } else {
        print('UID is null');
        return Future.delayed(Duration(microseconds: 0));
      }
    }

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

                      Container(
                          width: 300,
                          child: ChoiceHolder(2, ['Credit', 'Momo'], payChoice,
                              (value) {
                            setState(() {
                              payChoice = value;
                            });
                          })),
                      const SizedBox(
                        height: 40,
                      ),
                      //Button
                      SizedBox(
                          width: 250,
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
                                //process
                                addTicket().then((value) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text(
                                              'Ticket booked succesfully!')));
                                }).onError((error, stackTrace) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text('Transaction error!')));
                                });
                                await Future.delayed(Duration(seconds: 2));
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const MyHomePage()));
                              },
                              child: const Text(
                                'Pay \$1',
                                style: TextStyle(
                                    fontFamily: 'Actor', fontSize: 22),
                              )))
                    ]),
              ),
            ),
          );
        }

        return CircularProgressIndicator();
      },
    );
  }
}
