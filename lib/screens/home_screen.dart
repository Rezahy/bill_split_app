import 'package:bill_split_app/screens/result_screen.dart';
import 'package:bill_split_app/widgets/circle_button.dart';
import 'package:bill_split_app/widgets/custom_button.dart';
import 'package:bill_split_app/widgets/custom_card.dart';
import 'package:bill_split_app/widgets/display_info.dart';
import 'package:bill_split_app/widgets/keyboard_button.dart';
import 'package:bill_split_app/widgets/keyboard_icon_button.dart';
import 'package:bill_split_app/widgets/tax_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String focusedButtonText = '';
  String taxNumberSelectedText = '';
  int friends = 0;
  String billValue = '';
  int tax = 0;
  int tip = 0;

  final List<String> calculatorSymbolsList = [
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    '.',
    '0',
    '<-'
  ];
  final List<int> taxList = [0, 10, 20, 30];
  final player = AudioPlayer();

  Iterable<Widget> keyboardNumberButtonsWidget = [];
  Iterable<Widget> taxNumbersWidget = [];

  @override
  void initState() {
    super.initState();
    taxNumbersWidget = taxList.map((taxNumber) => Expanded(
          child: TaxButton(
            isSelected: taxNumberSelectedText == '$taxNumber',
            text: '$taxNumber%',
            onPressed: () async {
              setState(() {
                taxNumberSelectedText = '$taxNumber';
                tax = taxNumber;
                focusedButtonText = '';
              });
              await playAudio();
            },
          ),
        ));
    keyboardNumberButtonsWidget =
        calculatorSymbolsList.map((String keyboardText) {
      if (keyboardText == '<-') {
        return GestureDetector(
          onTap: () async {
            if (billValue.isNotEmpty) {
              setState(() {
                billValue = billValue.substring(0, billValue.length - 1);
              });
            }
            setState(() {
              focusedButtonText = keyboardText;
            });
            await playAudio();
          },
          onLongPress: () async {
            setState(() {
              billValue = '';
              focusedButtonText = '<-';
            });

            await playAudio();
          },
          child: KeyboardIconButton(
              isFocused: focusedButtonText == keyboardText,
              icon: Icons.backspace_outlined),
        );
      }
      return GestureDetector(
        onTap: () async {
          setState(() {
            billValue += keyboardText;
            focusedButtonText = keyboardText;
          });
          await playAudio();
        },
        child: KeyboardButton(
            isFocused: keyboardText == focusedButtonText, text: keyboardText),
      );
    });
  }

  Future playAudio() async {
    try {
      await player.setAsset(
        'assets/sounds/pressed-7.mp3',
      );
      await player.setVolume(0.3);
      await player.play();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  double divideAmount() {
    String currentBillValue = billValue.isNotEmpty ? billValue : '0';
    double taxAmount = double.parse(currentBillValue) * (tax / 100);
    double finalBill =
        (taxAmount + tip + double.parse(currentBillValue)) / friends;
    if (finalBill.isNaN || finalBill.isInfinite) {
      return 0;
    }
    return finalBill;
  }

  @override
  void dispose() {
    super.dispose();
    player.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color(0xFF131419),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 25, left: 25, right: 25),
          child: Column(
            children: [
              DisplayInfo(
                displayInfoTextHeader: 'Total',
                headerTextValue: billValue.isNotEmpty ? billValue : '0',
                friendsValue: '${friends.toInt()}',
                taxValue: tax,
                tipValue: tip,
              ),
              Expanded(
                  child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    CustomCard(
                      child: Column(
                        children: [
                          const Text(
                            'How Many Friends?',
                            style: TextStyle(
                                color: Color(0xFFC7C7C7), fontSize: 18),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Slider(
                            min: 0,
                            max: 15,
                            value: friends.toDouble(),
                            onChanged: (newValue) {
                              setState(() {
                                friends = newValue.toInt();
                              });
                            },
                            thumbColor: const Color(0xFFC7C7C7),
                            activeColor: const Color(0xFFC7C7C7),
                            inactiveColor: Colors.white24.withOpacity(0.15),
                          )
                        ],
                      ),
                    ),
                    CustomCard(
                      child: Column(
                        children: [
                          const Text(
                            'Tax',
                            style: TextStyle(
                                color: Color(0xFFC7C7C7), fontSize: 18),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: taxNumbersWidget.toList(),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: size.width * 0.6,
                      child: Row(
                        children: [
                          Expanded(
                            child: CustomCard(
                              child: Column(
                                children: [
                                  const Text(
                                    'Tip',
                                    style: TextStyle(
                                        color: Color(0xFFC7C7C7), fontSize: 18),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      CircleButton(
                                          onPressed: () async {
                                            if (tip > 0) {
                                              setState(() {
                                                tip -= 1;
                                              });
                                            }
                                            setState(() {
                                              focusedButtonText = '-';
                                            });
                                            await playAudio();
                                          },
                                          text: '-',
                                          isFocused: focusedButtonText == '-'),
                                      Text(
                                        '\$${tip.toStringAsFixed(0)}',
                                        style: const TextStyle(
                                            color: Color(0xFFC7C7C7),
                                            fontSize: 18),
                                      ),
                                      CircleButton(
                                          onPressed: () async {
                                            setState(() {
                                              focusedButtonText = '+';
                                              tip += 1;
                                            });
                                            await playAudio();
                                          },
                                          text: '+',
                                          isFocused: focusedButtonText == '+'),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Wrap(
                      children: keyboardNumberButtonsWidget.toList(),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomButton(
                        text: 'Split Bill',
                        isFocused: focusedButtonText == 'splitBill',
                        onPressed: () async {
                          double finalBill = divideAmount();
                          setState(() {
                            focusedButtonText = 'splitBill';
                          });
                          await playAudio();
                          Navigator.of(context).push(
                            CupertinoPageRoute(
                              builder: (_) => ResultScreen(
                                  friends: friends.toInt(),
                                  tax: tax,
                                  tip: tip,
                                  equallyDivided: finalBill),
                            ),
                          );
                          setState(() {
                            focusedButtonText = '';
                          });
                        }),
                    const SizedBox(
                      height: 15,
                    ),
                  ],
                ),
              )),
            ],
          ),
        ),
      ),
    );
  }
}
