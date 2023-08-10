import 'package:flutter/material.dart';
import 'package:hospital_booking/components/choice_holder.dart';

class Booking extends StatefulWidget {
  const Booking({super.key});

  @override
  State<Booking> createState() => _BookingState();
}

class _BookingState extends State<Booking> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFF29A49),
        title: Text('Book A Ticket'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(30, 20, 30, 20),
        child: Column(children: [
          Container(
            child: Row(children: [
              //photo
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                    image: const DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage('assets/images/hospital.jpg')),
                    borderRadius: BorderRadius.circular((50))),
              ),
              const SizedBox(
                width: 20,
              ),
              //info
              Container(
                child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Omega Hospital',
                        style: TextStyle(
                            fontFamily: 'Actor',
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Tan Phu District',
                        style: TextStyle(fontFamily: 'Actor', fontSize: 15),
                      ),
                    ]),
              ),
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
              'Information',
              style: TextStyle(
                  fontFamily: 'Actor',
                  fontSize: 30,
                  fontWeight: FontWeight.bold),
            ),
          ),

          const SizedBox(
            height: 20,
          ),

          TextField(
            decoration: InputDecoration(
                hintText: 'Symptom',
                hintStyle: TextStyle(fontFamily: 'Actor', fontSize: 20)),
          ),

          SizedBox(
            height: 20,
          ),
          ChoiceHolder(2, ['Today', 'Tommorrow']),
          SizedBox(
            height: 20,
          ),
          ChoiceHolder(2, ['Morning', 'Afternoon'])
        ]),
      ),
    );
  }
}
