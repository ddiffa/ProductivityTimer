import 'dart:async';
import 'timer_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CountDownTimer {
  double _radius = 1;
  bool _isActive = true;
  Timer timer;
  Duration _time;
  Duration _fullTime;
  int work = 30;
  int shortBreak = 5;
  int longBreak = 20;

  void startBreak(bool isShort) {
    _radius = 1;
    _time = Duration(minutes: (isShort) ? shortBreak : longBreak, seconds: 0);
    _fullTime = _time;
  }

  void stopTimer() {
    this._isActive = false;
  }

  void startTimer() {
    if (_time.inSeconds > 0) {
      this._isActive = true;
    }
  }

  void startWork() async {
    await readSettings();
    _radius = 1;
    _time = Duration(minutes: this.work, seconds: 0);
    _fullTime = _time;
  }

  String returnTime(Duration t) {
    String minutes = (t.inMinutes < 10)
        ? '0' + t.inMinutes.toString()
        : t.inMinutes.toString();
    int numSeconds = t.inSeconds - (t.inMinutes * 60);
    String seconds =
        (numSeconds < 10) ? '0' + numSeconds.toString() : numSeconds.toString();
    String formattedTime = minutes + ":" + seconds;
    return formattedTime;
  }

  Stream<TimerModel> stream() async* {
    //yield* statement to deliver a result. T0 make it simple, it's like a return statement,
    // but it doesn't end the function.
    // You have to use "*" sign after yield because we are returning a Stream.

    //yield* Stream.periodic() is a constructor creating a Stream that emits events at the intervals specified
    // in the first parameter. In our code, this will emit a value every 1 second.
    yield* Stream.periodic(Duration(seconds: 1), (int a) {
      //We declare a String called time and check whether the _isActive field is true, as follows :
      String time;
      if (this._isActive) {
        // If it is, we decrease the value of time by 1 second (it's a countdown, after all), like this:
        _time = _time - Duration(seconds: 1);

        // we also update the _radius value. This is the remaining time divided by the total time, as follows:
        // This value goes from 1, at the beginning of the countdown, to 0 at the end of the countdown
        _radius = _time.inSeconds / _fullTime.inSeconds;

        // We check whether the _time field got down to 0 and if it did, we change the value of _isActive to false
        // to stop the countdown, as follows:
        if (_time.inSeconds <= 0) {
          _isActive = false;
        }
      }

      //we call the returnTime method to transform the remaining Duration into a String, like This :
      time = returnTime(_time);
      //Finally, we return a TimerModel Object containing the time String and the _radius double like this
      return TimerModel(time, _radius);

      //So this function returns a Stream of TimerModel, decrementing the duration every second.
    });
  }

  Future readSettings() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    work = prefs.getInt('workTime') == null ? 30 : prefs.getInt('workTime');
    shortBreak =
        prefs.getInt('shortBreak') == null ? 30 : prefs.getInt('shortBreak');
    longBreak =
        prefs.getInt('longBreak') == null ? 30 : prefs.getInt('longBreak');
  }
}
