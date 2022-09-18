import 'package:flutter/material.dart';

class DisplayColumnText extends StatelessWidget {
  const DisplayColumnText(
      {Key? key, required this.fieldValue, required this.text})
      : super(key: key);
  final String text;
  final String fieldValue;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          text,
          style: const TextStyle(
            color: Color(0xFFC7C7C7),
            fontSize: 22,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          fieldValue,
          style: const TextStyle(color: Color(0xFFC7C7C7), fontSize: 22),
        ),
      ],
    );
  }
}
