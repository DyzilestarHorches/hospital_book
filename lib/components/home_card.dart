import 'package:flutter/material.dart';

class HomeCard extends StatelessWidget {
  final String imgLink;
  final String title;
  final String content;
  final Color color;

  const HomeCard(this.imgLink, this.title, this.content, this.color);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: 100,
        padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
        child: Wrap(children: [
          Material(
            borderRadius: BorderRadius.circular(20),
            elevation: 5,
            child: Container(
              width: double.infinity,
              height: 100,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(20)),
              padding: EdgeInsets.all(10),
              child: Row(
                children: [
                  Container(
                    //photo
                    height: 80,
                    width: 100,
                    padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),

                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: color,
                        border: Border.all(
                          color: const Color(0xFF000000),
                        )),
                    child: Image(
                      image: AssetImage(imgLink),
                      height: 70,
                      width: 70,
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  //info
                  Container(
                    width: 200,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: const TextStyle(
                              fontFamily: 'Actor',
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.left,
                        ),
                        Text(
                          content,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.left,
                          softWrap: true,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ]));
  }
}
