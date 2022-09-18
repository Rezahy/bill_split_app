import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';

class CircleButton extends StatelessWidget {
  const CircleButton(
      {Key? key,
      required this.text,
      required this.isFocused,
      required this.onPressed})
      : super(key: key);
  final bool isFocused;
  final String text;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        onPressed();
      },
      child: Container(
        width: 45,
        height: 45,
        margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        decoration: BoxDecoration(
          color: const Color(0xFF131419),
          borderRadius: BorderRadius.circular(50),
          boxShadow: isFocused
              ? [
                  BoxShadow(
                      color: Colors.black.withOpacity(0.5),
                      offset: const Offset(2, 2),
                      inset: true,
                      blurRadius: 5),
                  BoxShadow(
                      color: Colors.white.withOpacity(0.12),
                      offset: const Offset(-3, -3),
                      inset: true,
                      blurRadius: 7),
                ]
              : [
                  BoxShadow(
                      color: Colors.black.withOpacity(0.5),
                      offset: const Offset(2, 2),
                      blurRadius: 5),
                  BoxShadow(
                      color: Colors.white.withOpacity(0.05),
                      offset: const Offset(-3, -3),
                      blurRadius: 7),
                ],
        ),
        child: Center(
          child: Text(
            text,
            style: isFocused
                ? const TextStyle(color: Color(0xFF7CFC00), fontSize: 18)
                : const TextStyle(color: Color(0xFFC7C7C7), fontSize: 20),
          ),
        ),
      ),
    );
  }
}
