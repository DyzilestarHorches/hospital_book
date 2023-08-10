import 'package:flutter/material.dart';
import 'package:hospital_booking/components/choice_holder.dart';
import 'package:qr_flutter/qr_flutter.dart';

class Checkout extends StatefulWidget {
  final DateTime date;

  const Checkout(this.date, {super.key});

  @override
  State<Checkout> createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {
  @override
  Widget build(BuildContext context) {
    int payChoice = 0;
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
                  data: '1234567890',
                  version: QrVersions.auto,
                  size: 150.0,
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'Bill Gates - 60 years old',
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
                  'Estimated Time: ${widget.date}',
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
                    child:
                        ChoiceHolder(2, ['Credit', 'Momo'], payChoice, (value) {
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
                        onPressed: () {
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) => const Checkout()));
                        },
                        child: Text(
                          'Pay \$1',
                          style: TextStyle(fontFamily: 'Actor', fontSize: 22),
                        )))
              ]),
        ),
      ),
    );
  }
}
