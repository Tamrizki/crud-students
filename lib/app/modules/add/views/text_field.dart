import 'package:flutter/material.dart';

class Textfield extends StatelessWidget {
  Textfield(
      {Key? key,
      required this.textController,
      required this.label,
      this.isGender = false})
      : super(key: key);
  final bool isGender;
  final String label;
  final TextEditingController textController;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 24),
      child: TextField(
        maxLength: (isGender) ? 1 : 18,
        controller: textController,
        decoration: InputDecoration(labelText: label, counterText: ''),
      ),
    );
  }
}