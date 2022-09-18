import 'package:flutter/material.dart';

class DisplayRowText extends StatelessWidget {
  const DisplayRowText({Key? key, required this.text, required this.fieldValue})
      : super(key: key);
  final String text;
  final String fieldValue;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          text,
          style: const TextStyle(color: Color(0xFFC7C7C7), fontSize: 22),
        ),
        Text(
          fieldValue,
          style: const TextStyle(color: Color(0xFFC7C7C7), fontSize: 22),
        )
      ],
    );
  }
}
