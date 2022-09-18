import 'package:bill_split_app/widgets/custom_button.dart';
import 'package:bill_split_app/widgets/custom_card.dart';
import 'package:bill_split_app/widgets/display_info.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class ResultScreen extends StatefulWidget {
  const ResultScreen(
      {Key? key,
      required this.friends,
      required this.tax,
      required this.tip,
      required this.equallyDivided})
      : super(key: key);
  final int friends;
  final int tax;
  final int tip;
  final double equallyDivided;

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  final player = AudioPlayer();
  bool isFocusedCalculateAgain = false;
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

  @override
  void dispose() {
    super.dispose();
    player.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF131419),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: Column(
            children: [
              DisplayInfo(
                  displayInfoTextHeader: 'Equally Divided',
                  headerTextValue: widget.equallyDivided.toStringAsFixed(2),
                  friendsValue: '${widget.friends}',
                  tipValue: widget.tip,
                  taxValue: widget.tax),
              CustomCard(
                child: Center(
                  child: Text(
                    'Everybody Should Pay \$${widget.equallyDivided.toStringAsFixed(2)}',
                    style:
                        const TextStyle(color: Color(0xFFC7C7C7), fontSize: 15),
                  ),
                ),
              ),
              CustomButton(
                  text: 'Calculate Again ?',
                  isFocused: isFocusedCalculateAgain,
                  onPressed: () async {
                    setState(() {
                      isFocusedCalculateAgain = true;
                    });
                    await playAudio();
                    await Future.delayed(const Duration(milliseconds: 200));
                    Navigator.pop(context);
                  })
            ],
          ),
        ),
      ),
    );
  }
}
