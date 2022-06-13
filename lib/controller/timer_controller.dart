import 'dart:async';

class TimerController {
  void preset(int timePresetMinutes, String minutes, String seconds) {
    int secondsToInt = 0;
    int minutesToInt = timePresetMinutes;

    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (minutesToInt > 0 && secondsToInt == 0) {
        secondsToInt = 59;
        minutesToInt--;
      }
      if (minutesToInt == 0 && secondsToInt == 0) {
        timer.cancel();
      }
      secondsToInt--;
    });
  }
}
