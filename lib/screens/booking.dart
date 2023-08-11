import 'package:flutter/material.dart';
import 'package:hospital_booking/components/choice_holder.dart';
import 'package:hospital_booking/screens/checkout.dart';

class Booking extends StatefulWidget {
  const Booking({super.key});

  @override
  State<Booking> createState() => _BookingState();
}

int getTime(bool isMorning) {
  if (isMorning) {
    return 11;
  } else {
    return 16;
  }
}

class _BookingState extends State<Booking> {
  final symptomController = TextEditingController();
  String department = '';
  int dayChoice = 0;
  int shiftChoice = 0;
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
        child: SingleChildScrollView(
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
              controller: symptomController,
              decoration: InputDecoration(
                  hintText: 'Symptom',
                  hintStyle: TextStyle(fontFamily: 'Actor', fontSize: 20)),
            ),

            const SizedBox(
              height: 20,
            ),

            //sugest
            const Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text('Suggested Room:'),
                Text(
                  'General',
                  style: TextStyle(
                      fontFamily: 'Actor',
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                )
              ],
            ),

            const SizedBox(
              height: 20,
            ),
            ChoiceHolder(2, ['Today', 'Tommorrow'], dayChoice, (value) {
              setState(() {
                dayChoice = value;
              });
            }),
            const SizedBox(
              height: 20,
            ),
            ChoiceHolder(2, const ['Morning', 'Afternoon'], shiftChoice,
                (value) {
              setState(() {
                shiftChoice = value;
              });
            }),
            const SizedBox(
              height: 60,
            ),
            //button
            SizedBox(
                width: 250,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    //process
                    int time = getTime(shiftChoice == 0);
                    DateTime now = new DateTime.now();
                    DateTime date = DateTime(
                        now.year, now.month, now.day + dayChoice, time);
                    print(time);
                    print(date);

                    //navigate
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                Checkout(date, symptomController.text)));
                  },
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(const Color(0xFFF29A49)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      )),
                  child: const Text(
                    'Book',
                    style: TextStyle(fontFamily: 'Actor', fontSize: 20),
                  ),
                ))
          ]),
        ),
      ),
    );
  }
}
