import 'package:flutter/material.dart';
import 'package:timer_app/timer_model.dart';
import 'package:timer_app/widgets.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'timer.dart';

class TimerHomePage extends StatelessWidget {
  final CountDownTimer timer = CountDownTimer();

  @override
  Widget build(BuildContext context) {
    timer.startWork();
    return Scaffold(
        appBar: AppBar(
          title: Text("My Work Timer"),
        ),
        body: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraint) {
          final double availableWidth = constraint.maxWidth;
          return Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Padding(padding: EdgeInsets.all(defaultPadding)),
                  Expanded(
                      child: ProductivityButton(
                    color: Color(0xff009688),
                    text: "Work",
                    onPressed: () => timer.startTimer(),
                  )),
                  Padding(
                    padding: EdgeInsets.all(defaultPadding),
                  ),
                  Expanded(
                    child: ProductivityButton(
                      color: Color(0xff607D8B),
                      text: "Short Break",
                      onPressed: () => timer.startBreak(true),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(defaultPadding),
                  ),
                  Expanded(
                      child: ProductivityButton(
                    color: Color(0xff455A64),
                    text: "Long Break",
                    onPressed: () => timer.startBreak(false),
                  )),
                  Padding(
                    padding: EdgeInsets.all(defaultPadding),
                  )
                ],
              ),
              Container(
                  child: StreamBuilder(
                      initialData: TimerModel('00:00', 1),
                      stream: timer.stream(),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        TimerModel timer = snapshot.data;
                        return Expanded(
                          child: CircularPercentIndicator(
                            radius: availableWidth / 2,
                            lineWidth: 10.0,
                            percent: timer.percent,
                            center: Text(
                              timer.time,
                              style: Theme.of(context).textTheme.headline4,
                            ),
                            progressColor: Color(0xff009688),
                          ),
                        );
                      })),
              Row(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(defaultPadding),
                  ),
                  Expanded(
                      child: ProductivityButton(
                    color: Color(0xff212121),
                    text: 'Stop',
                    onPressed: () => timer.stopTimer(),
                  )),
                  Padding(
                    padding: EdgeInsets.all(defaultPadding),
                  ),
                  Expanded(
                    child: ProductivityButton(
                        color: Color(0xff009688),
                        text: 'Restrat',
                        onPressed: () => timer.startTimer()),
                  ),
                  Padding(
                    padding: EdgeInsets.all(defaultPadding),
                  )
                ],
              )
            ],
          );
        }));
  }
}

final double defaultPadding = 5.0;

void emptyMethod() {}
