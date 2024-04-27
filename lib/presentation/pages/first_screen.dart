import 'package:energise_test/presentation/widget/timer_btn.dart';

import 'package:flutter/material.dart';

class FirstScreen extends StatelessWidget {
  const FirstScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TimerButtonPulse(),
          ],
        ),
      ),
    );
  }
}
