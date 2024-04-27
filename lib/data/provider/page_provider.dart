import 'package:flutter/material.dart';

class PageProvider extends ChangeNotifier {
  int _pageIndex = 0;
  bool _isRunning = false;
  int _seconds = 0;
  int get pageIndex => _pageIndex;
  bool get isRunning => _isRunning;
  int get seconds => _seconds;
  bool _pulseAnimate = true;
  bool get animate => _pulseAnimate;
  void changePageIndex(int index) {
    _pageIndex = index;
    notifyListeners();
  }

  void setPulseAnimate(bool animate) {
    _pulseAnimate = animate;
    notifyListeners();
  }

  void setTimerStatus(bool runState) {
    _isRunning = runState;
    notifyListeners();
  }

  void setSeconds() {
    _seconds++;
    notifyListeners();
  }

  void stopTimer() {
    _seconds = 0;
    notifyListeners();
  }
}
