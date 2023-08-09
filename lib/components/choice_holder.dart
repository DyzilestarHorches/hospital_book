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
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
