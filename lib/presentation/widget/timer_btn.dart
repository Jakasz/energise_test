import 'dart:async';

import 'package:avatar_glow/avatar_glow.dart';
import 'package:energise_test/data/provider/page_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TimerButtonPulse extends StatelessWidget {
  TimerButtonPulse({super.key});
  late Timer timer;
  late PageProvider provider = PageProvider();
  @override
  Widget build(BuildContext context) {
    provider = Provider.of<PageProvider>(context);
    return Column(
      children: [
        InkWell(
          customBorder: const CircleBorder(),
          splashColor: Colors.red,
          onTap: () {
            provider.setPulseAnimate(!provider.animate);
            provider.isRunning ? stopTimer() : startTimer();
          },
          child: Ink(
            height: 80,
            width: 80,
            child: AvatarGlow(
                glowShape: BoxShape.circle,
                animate: provider.animate,
                glowColor: Colors.red,
                child: Center(
                  child: Text(provider.isRunning
                      ? AppLocalizations.of(context)!.pause
                      : AppLocalizations.of(context)!.play),
                )),
          ),
        ),
        AnimatedCrossFade(
            firstChild: Text(
              getTimer(),
              style: TextStyle(
                  color: Colors.black.withOpacity(1),
                  fontSize: 25,
                  fontWeight: FontWeight.bold),
            ),
            secondChild: Text(
              getTimer(),
              style: TextStyle(
                  color: Colors.black.withOpacity(0.6),
                  fontSize: 25,
                  fontWeight: FontWeight.bold),
            ),
            crossFadeState: provider.seconds % 2 == 0
                ? CrossFadeState.showFirst
                : CrossFadeState.showSecond,
            duration: const Duration(seconds: 1)),
      ],
    );
  }

  String getTimer() {
    int hours = provider.seconds ~/ 3600;
    int minutes = (provider.seconds % 3600) ~/ 60;
    int seconds = provider.seconds % 60;
    return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  void startTimer() {
    if (provider.isRunning) return;
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      provider.setSeconds();
    });
    provider.setTimerStatus(true);
  }

  void stopTimer() {
    if (!provider.isRunning) return;
    timer.cancel();
    provider.setTimerStatus(false);
    provider.stopTimer();
  }
}
