import 'package:bill_split_app/widgets/display_row_text.dart';
import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';

import 'display_column_text.dart';

class DisplayInfo extends StatelessWidget {
  const DisplayInfo(
      {Key? key,
      required this.displayInfoTextHeader,
      required this.headerTextValue,
      required this.friendsValue,
      required this.tipValue,
      required this.taxValue})
      : super(key: key);
  final String displayInfoTextHeader;
  final String headerTextValue;
  final String friendsValue;
  final int taxValue;
  final int tipValue;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 130,
      alignment: Alignment.center,
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
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 1,
              child: DisplayColumnText(
                text: displayInfoTextHeader,
                fieldValue: '\$$headerTextValue',
              ),
            ),
            Expanded(
              flex: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DisplayRowText(text: 'Friends', fieldValue: friendsValue),
                  const SizedBox(
                    height: 10,
                  ),
                  DisplayRowText(text: 'Tax', fieldValue: '$taxValue%'),
                  const SizedBox(
                    height: 10,
                  ),
                  DisplayRowText(text: 'Tip', fieldValue: '\$$tipValue'),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
