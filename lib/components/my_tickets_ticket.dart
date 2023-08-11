import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hospital_booking/screens/myTicket.dart';
import 'package:hospital_booking/screens/ticket.dart';
import 'package:jiffy/jiffy.dart';
import 'package:qr_flutter/qr_flutter.dart';

class MyTicketsTicket extends StatefulWidget {
  final String room;
  final String department;
  final DateTime date;
  const MyTicketsTicket(
      {super.key,
      required this.room,
      required this.department,
      required this.date});

  @override
  State<MyTicketsTicket> createState() => _MyTicketsTicketState();
}

class _MyTicketsTicketState extends State<MyTicketsTicket> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    final User? user = auth.currentUser;
    final uid = user?.uid;
    final String ticketID = '${user?.uid}-${widget.date}-192';
    return Material(
      borderRadius: BorderRadius.circular(20),
      elevation: 5,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(20),
        ),
        child: GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => Ticket(widget.date)));
          },
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
            child: Row(
              children: [
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  const Text(
                    'Omega Hospital',
                    style: TextStyle(
                      fontFamily: 'Actor',
                      fontSize: 20,
                    ),
                  ),
                  Text('Room: ${widget.room} - ${widget.department}'),
                  Text(
                      'Time: ${Jiffy.parseFromDateTime(widget.date).format(pattern: 'dd MMM yyyy, hh:mm a')}')
                ]),
                Spacer(),
                QrImageView(
                  data: ticketID,
                  size: 70,
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 15,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
