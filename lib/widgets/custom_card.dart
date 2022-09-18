import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';

class CustomCard extends StatelessWidget {
  const CustomCard({Key? key, required this.child}) : super(key: key);
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
          color: const Color(0xFF131419),
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
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
          ]),
      child: child,
    );
  }
}
