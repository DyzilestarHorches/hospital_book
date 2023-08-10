import 'package:flutter/material.dart';

class ChoiceHolder extends StatefulWidget {
  final int numberOfChoices;
  final List<String> choices;
  const ChoiceHolder(this.numberOfChoices, this.choices, {super.key});

  @override
  State<ChoiceHolder> createState() => _ChoiceHolderState();
}

class _ChoiceHolderState extends State<ChoiceHolder> {
  @override
  int choosing = 0;
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 60,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: Colors.black)),
      child: Row(
          children: widget.choices
              .asMap()
              .entries
              .map((e) => Expanded(
                  child: GestureDetector(
                      onTap: () {
                        setState(() {
                          choosing = e.key;
                        });
                      },
                      child: ChoiceHolderChoice(e.value, choosing == e.key))))
              .toList()),
    );
  }
}

class ChoiceHolderChoice extends StatefulWidget {
  final bool isChosen;
  final String choice;
  const ChoiceHolderChoice(this.choice, this.isChosen, {super.key});

  @override
  State<ChoiceHolderChoice> createState() => _ChoiceHolderChoiceState();
}

class _ChoiceHolderChoiceState extends State<ChoiceHolderChoice> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          border: widget.isChosen ? Border.all(color: Colors.black) : null,
          color: widget.isChosen ? Color(0xFFDEDEDE) : Colors.transparent),
      alignment: Alignment.center,
      child: Text(widget.choice),
    );
  }
}
